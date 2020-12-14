trigger defaultEntitlement on Case (Before Insert, Before Update) {
    /*
If the Entitlement Name is not set then, check to see if the Contact on the Case has an active Entitlement
and select the first one.  If not then check to see if the Account on the Case has an active Entitlement.
*/
    
    
   ///////////////////////////////////
    List<Id> contactIds = new List<Id>();
    List<Id> acctIds = new List<Id>();

    for (Case c : Trigger.new){
        c.EntitlementId = null;
        if (c.EntitlementId == null && c.ContactId != null && c.AccountId != null){
            contactIds.add(c.ContactId);
            acctIds.add(c.AccountId);
        }    
    }

    if(contactIds.isEmpty()==false)
    {        
        List<Entitlement> entls = [Select e.name, e.StartDate, e.Id, e.EndDate, e.AccountId, e.AssetId From Entitlement e Where e.EndDate >= Today And e.StartDate <= Today ];
       
        if(entls.isEmpty()==false){
            for(Case c : Trigger.new){
                
                if(c.EntitlementId == null && c.ContactId != null){
                    for(Entitlement ec:entls){
                        //Insertamos el EntitlamentContact
                        /*EntitlementContact entlContact = new EntitlementContact( ContactId = c.ContactId, EntitlementId = ec.Id );
                        try {
                            insert entlContact;
                        } catch (exception ee) {
                            System.debug('Error al insertar:' + ee);
                        } */
                        if(c.status == 'New' && ec.name == 'In Queue'){
                            c.EntitlementId = ec.Id;
                            break;
                        }
                        if(c.status == 'On Hold-Pending Client' && ec.name == 'On Hold-Pending Client'){
                            c.EntitlementId = ec.Id;
                            break;
                        }                   
                        if(c.status != 'New' && c.status != 'Closed' && c.status != 'Canceled' && ec.name == c.CAS001_ls_requerimiento__c){
                            c.EntitlementId = ec.Id;
                            break;
                        }                      
                    } 
                }
            } 
        } 
    } 
}