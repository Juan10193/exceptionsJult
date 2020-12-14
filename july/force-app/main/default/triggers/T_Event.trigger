trigger T_Event on Event (before insert, before update) {

  List<Contact> listContact = new List<Contact>();
    
     for(Event ev : Trigger.New) {
         if(ev.WhoId != null){
         if(ev.WhoId.getSObjectType() == Contact.sObjectType)
         {
            for(Contact cont : [select id from Contact where id =: ev.WhoId])
            {
                 system.debug(ev.WhoId.getSObjectType());
                 if( ev.Type=='Meeting')
                 {
                    DateTime  LastMeeting = ev.LastModifiedDate; 
                    cont.Last_Meeting_Contact__c  = LastMeeting;
                    listContact.add(cont); 
                     system.debug(':::::::::::Event'+cont+':::::::::::::::::::'+'El evento se completo correctamente');
                 } 
                

             }//for interno  

         }
        }
     }
    update listContact;
}