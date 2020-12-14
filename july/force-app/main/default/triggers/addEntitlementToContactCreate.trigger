trigger addEntitlementToContactCreate on Contact (after insert) {
    
    //Seleccionamos todas las asignaciones, no importa si estan vigentes o no
    List<Entitlement> entls = [Select e.name, e.StartDate, e.Id, e.EndDate
                               From Entitlement e Where name = 'In Queue' ];
    List<EntitlementContact> myEContactlist = new List<EntitlementContact>();
    
    for(contact c : Trigger.new){
        for(Entitlement e:entls){
            System.debug('Entitament name=' + e.name);
            EntitlementContact myEContact = new EntitlementContact(EntitlementId = e.Id,ContactId = c.Id);
            myEContactlist.add(myEContact);            
        }
    }
    
    if(myEContactlist !=null && myEContactlist.size()>0){        insert myEContactlist ;    }
    
}