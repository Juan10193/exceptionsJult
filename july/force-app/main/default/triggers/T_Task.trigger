/************************************************************************************
Autor: JESUS MARTIN VITAL TAPIA	
Compañia: BXTOOLKIT
Correo: martin.vital@bxtoolkit.com
Descripción: Trigger que asigna la fecha de un evento de tipo llamada al campo de 
			 Ultima_Actividad en prospectos.
*************************************************************************************/

trigger T_Task on Task (before insert, before update) {
  Lead le = new Lead();
    Set<String> WhoListLeads = new  Set<String>();
    Set<String> WhoListContact = new  Set<String>();
    List<Contact> cList= new  List<Contact>();
    List<Lead> ledList= new  List<Lead>();
    
  List<Task> eve = new List<Task>();
     for(Task a : Trigger.New) {
       if(a.WhoId != null){
         if(a.WhoId.getSObjectType() == Lead.sObjectType)
         {
             WhoListLeads.add(a.WhoId);
         }else if (a.WhoId.getSObjectType() == Contact.sObjectType){
             WhoListContact.add(a.WhoId);
         }
        }
     }
    if(!WhoListLeads.isEmpty()){
        ledList= [select id, Minute_Counter_Stop__c, Llamada_realizada__c, CreatedDate from Lead where id IN : WhoListLeads];
        for(Task taskLeads : Trigger.New){

            for(Lead led : ledList){
                 if(taskLeads.Status=='Completed' && taskLeads.Type=='Call' && taskLeads.WhoID == led.Id)
                 {
                    DateTime  FechaActual = taskLeads.LastModifiedDate; 
                     if(FechaActual==null){
                         FechaActual=DateTime.now();
                     }
                     led.Ultima_Actividad__c = FechaActual;
                     led.Llamada_realizada__c=true;
                     led.Day_Counter_Update__c = (FechaActual.getTime() - led.CreatedDate.getTime())/(1000*60*60*24);
                     if(led.Llamada_realizada__c == false || led.Minute_Counter_Stop__c == 0 || led.Minute_Counter_Stop__c == null)
                         led.Minute_Counter_Stop__c = ((FechaActual.getTime() - led.CreatedDate.getTime())/1000)/60;
                     led.Status='Contacting';
                     system.debug(':::::::::::FEcha actual'+FechaActual );
                     system.debug(':::::::::::Lead'+led+':::::::::::::::::::'+FechaActual+'La terea se completo correctamente'+taskLeads.IsClosed);
					
                 }   
            }
            
        }//fin de for Trigger
         update ledList;
    }
    
    
    if(!WhoListContact.isEmpty()){
      cList = [select id from Contact where id IN : WhoListContact];
        for (Task taskContact :Trigger.New ){
            
            for(Contact cont : cList){
                
                  if ( taskContact.Status=='Completed' && taskContact.Type=='Call' && taskContact.WhoId == cont.id){
                      
                            DateTime  FechaActualContact = taskContact.LastModifiedDate; 
                    		cont.Last_Activity_Contact__c = FechaActualContact;
                  			system.debug('Contacto'+cont);

                  }                 
            }
        }
        update cList;
    }

}//Fin del trigger