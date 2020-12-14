trigger CompleteResolutionTimeMilestone on Case (after update) {
    if (UserInfo.getUserType() == 'Standard'){
        DateTime completionDate = System.now(); 
        //List<Id> updateCases = new List<Id>();
        List<Id> updateCasesNew = new List<Id>();
        List<Id> updateCasesAssigned = new List<Id>();
        List<Id> updateCasesInApproval = new List<Id>();
        List<Id> updateCasesOnHold = new List<Id>();
        
        
        /*for (Case c : Trigger.new){
            if (((c.isClosed == true)||(c.Status == 'Closed'))&&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)))
                updateCases.add(c.Id);
            if (c.Status == 'Assigned')
            {
                for (Case cc : Trigger.old){
                    system.debug('New Trigger Assigned, old trigger ' + cc.Status );
                    if (cc.Status == 'In approval') 
                    {
                        system.debug('New Trigger Assigned, old trigger ' + cc.Status + 'Entramos a if In Aproval');
                        updateCasesAssigned.add(c.Id);
                    }
                    if (cc.Status == 'New')                        
                    {
                        system.debug('New Trigger Assigned, old trigger ' + cc.Status + 'Entramos a if New');
                        updateCasesNew.add(c.Id);                    
                    }
                        
                }
            }            
		}*/
        
        for (Case c : Trigger.new){
            for (Case cc : Trigger.old){
                //Si cambio cualquier estatus o requiere aprobación / ejecución son verdaderos pero antes eran falsos
                if ((c.Status != cc.Status)||
                    (c.CAS058_ck_requiereSegundaAprobacion__c == true && cc.CAS058_ck_requiereSegundaAprobacion__c == false)||
                    (c.CAS059_ck_requiereSegundaEjecucion__c == true && cc.CAS059_ck_requiereSegundaEjecucion__c == false ))
                {
                    //Verificamos cual fue el ultimo estatus para saber que actividad es la que hay que cerrar,
                    //Si el anterior estado era Cancelado o Cerrado no cerramos ninguna actividad
                    system.debug('OEJ New Trigger: ' + c.Status );
                    system.debug('OEJ Old Trigger: ' + cc.Status );
                    system.debug('OEJ New Trigger User: ' + c.OwnerId );
                    system.debug('OEJ Old Trigger User: ' + cc.OwnerId );  
                    system.debug('OEJ Trigger User Requiere 2da Aprobación new: ' + c.CAS058_ck_requiereSegundaAprobacion__c + ' ||| old:'  + cc.CAS058_ck_requiereSegundaAprobacion__c);
                    system.debug('OEJ Trigger User Requiere 2da Ejecución  new: ' + c.CAS059_ck_requiereSegundaEjecucion__c + ' ||| old:' + cc.CAS059_ck_requiereSegundaEjecucion__c);                      
                    if (cc.Status == 'New') // Cerramos In Queue
                    {
                        updateCasesNew.add(c.Id); 
                    }
                    if (cc.Status == 'In approval')
                    {
                        updateCasesInApproval.add(c.Id); 
                    }
                    if (cc.Status == 'On Hold-Pending Client')
                    {
                        updateCasesOnHold.add(c.Id); 
                    }
                    if (cc.Status == 'Assigned')
                    {
                        updateCasesAssigned.add(c.Id);
                    }
                }
                
            }
          
        }
        
        /*if (updateCases.isEmpty() == false)
        {
            System.debug('Enviamos updateCases');
            milestoneUtils.completeMilestone(updateCases, 'Ejecución', completionDate);
        }*/
        if (updateCasesNew.isEmpty() == false)
        {
            System.debug('Enviamos updateCasesNew');
            milestoneUtils.completeMilestone(updateCasesNew, 'In Queue', completionDate); 
        }            
        if (updateCasesInApproval.isEmpty() == false)
        {
            System.debug('Enviamos updateCasesInApproval');
            milestoneUtils.completeMilestone(updateCasesInApproval, 'Aprobación', completionDate);   
        }
        if (updateCasesOnHold.isEmpty() == false)
        {
            System.debug('Enviamos updateCasesOnHold');
            milestoneUtils.completeMilestone(updateCasesOnHold, 'On Hold-Pending Client', completionDate);   
        }
        if (updateCasesAssigned.isEmpty() == false)
        {
            System.debug('Enviamos updateCasesAssigned');
            milestoneUtils.completeMilestone(updateCasesAssigned, 'Ejecución', completionDate);   
        }
        
    }
}