public class ES2_ControllerExt_Prescreening {
    
    
    
    private final ES2_Obj_Prescreening__c prescreening;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public ES2_ControllerExt_Prescreening(ApexPages.StandardController stdController) {
        System.debug((ES2_Obj_Prescreening__c)stdController.getRecord());
        this.prescreening = (ES2_Obj_Prescreening__c)stdController.getRecord();
    }
    
    public id getQueueUWSr()
    {
        
        try
        {
        	QueueSObject QueueID = [Select Queue.Id, Queue.Name, Queue.Type from QueueSObject WHERE Queue.Type ='Queue' AND Queue.Name =: 'Underwriting Sr approvers' Limit 1];    
            return QueueID.Queue.Id;
        }catch(exception e){
            System.debug('No existe la cola Underwriting Sr approvers');
            return null;
        }        
        
        
    }
    
    public PageReference approval()
    {           
        
        
        prescreening.ES2_ls_Status__c = 'Approved';
        prescreening.OwnerId = prescreening.CreatedById;
        System.debug('Id prescreening: '+prescreening.id);
        update prescreening;            
        PageReference pr = new PageReference('/apex/ES2_ReadPage_Prescreening?id=' + prescreening.id);
        pr.setRedirect(true); //Pasamos el controlador vacio
        return pr;        
    }      
    public PageReference inProcess()
    {                
        PageReference pr; 
        
        if ( String.isBlank(prescreening.ES2_rb_Sr_UnderWriter__c)  ) //Error falta UW Senior
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Agregar Sr UnderWriter'));
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            prescreening.ES2_ls_Status__c = 'In Process';
            prescreening.OwnerId = getQueueUWSr();
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening?id=' + prescreening.id);
            pr.setRedirect(true); //Pasamos el controlador lleno  
            update prescreening;
        }
        return pr;          
               
    }      
    public PageReference picRequired()
    {
        PageReference pr; 
        if ( String.isBlank(prescreening.ES2_tx_Comments_UW__c)  ) //Error en 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Agregar Comentarios'));
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            prescreening.ES2_ls_Status__c = 'PIC Required';
            prescreening.OwnerId = prescreening.CreatedById;
            update prescreening;
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening?id=' + prescreening.id);
            pr.setRedirect(true); //Pasamos el controlador vacio    
            
        }
        

        return pr;        
    }               
    public PageReference declined()
    {

        
        PageReference pr; 
        
        if ( String.isBlank(prescreening.ES2_tx_Comments_UW__c)  ) //Error en 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Agregar Comentarios'));
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            prescreening.ES2_ls_Status__c = 'Declined';
            prescreening.OwnerId = prescreening.CreatedById;
            pr = new PageReference('/apex/ES2_ReadPage_Prescreening?id=' + prescreening.id);
            pr.setRedirect(true); //Pasamos el controlador lleno  
            update prescreening;
        }
        return pr;        
    }  
    public PageReference approved()
    {
        prescreening.ES2_ls_Status__c = 'Approved';
        prescreening.OwnerId = prescreening.CreatedById;
        update prescreening;
        PageReference pr = new PageReference('/apex/ES2_ReadPage_Prescreening?id=' + prescreening.id);
        pr.setRedirect(true); //Pasamos el controlador vacio
        return pr;        
    }     
}