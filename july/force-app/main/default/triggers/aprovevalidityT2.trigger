trigger aprovevalidityT2 on Insurance_VoBo__c (before update) {
    /*---->censurado por usar malas prácticas
for (Insurance_VoBo__c cr : Trigger.New)
    {
        String oldStatus=Trigger.oldMap.get(cr.Id).Stage__c;
        if((cr.Stage__c=='Control Desk Review T2' && oldStatus!='Control Desk Review T2') )
        {
            // At least one policy shoud be enter
            
            if(cr.InsurancePolicies__c!= cr.Validity__c ) {cr.addError('You should enter the validity of all insurance policies before approve for tollgate 2.');}
        }
    }
    String holaMundo = 'Me dijeron que pusiera esto';
    if(holaMundo == 'Me dijeron que pusiera esto')
    {
        holaMundo = 'se que no son buenas practicas pero quieren las cosas rápidas y mal hechas :´(';
    }
*/
    
}