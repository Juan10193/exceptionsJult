trigger addContacsToEntitlementCreate on Entitlement (after insert) {
    
    
    //Seleccionamos todas las asignaciones, no importa si estan vigentes o no
/*    List<Contact> con = [Select e.name, e.Id From Contact e ];
    List<EntitlementContact> myEContactlist = new List<EntitlementContact>();   
    
    
    for(Entitlement e : Trigger.new){
        for(Contact c:con){ 
            EntitlementContact myEContact = new EntitlementContact(EntitlementId = e.Id, ContactId = c.Id); 
            myEContactlist.add(myEContact);  }
    }
    
    if(myEContactlist !=null && myEContactlist.size()>0){ insert myEContactlist ;   }    */

}