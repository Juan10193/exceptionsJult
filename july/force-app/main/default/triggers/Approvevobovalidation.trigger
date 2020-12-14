trigger Approvevobovalidation on Insurance_VoBo__c (before update) {
Profile ProfileName = [select Name from profile where id = :userinfo.getProfileId()];
for (Insurance_VoBo__c cr : Trigger.New)
    {
        String oldStatus=Trigger.oldMap.get(cr.Id).Stage__c;
        if((cr.Stage__c=='Control Desk Review T2' && oldStatus!='Control Desk Review T2') || (cr.Stage__c=='T1 Quote Approved' && oldStatus!='T1 Quote Approved') || (cr.Stage__c=='Control Desk Review T1' && oldStatus!='Control Desk Review T1') || (cr.Stage__c=='T2 VoBo Approved' && oldStatus!='T2 VoBo Approved')  )
        {
            // At least one policy shoud be enter

            if(cr.InsurancePolicies__c==0 && cr.Insurance_Type__c!= 'Self Insurance' ) { cr.addError('You should enter at least one insurance policy before approve.');}
           
         }
         
         if( (cr.Stage__c=='T1 Quote Approved' && oldStatus!='T1 Quote Approved'))
         {
             if (ProfileName.Name =='Insurance') { cr.addError('You cannot approve control desk step.'); }
         }
         if( (cr.Stage__c=='T2 VoBo Approved' && oldStatus!='T2 VoBo Approved' && (cr.Insurance_Type__c=='Engenium Capital Financed'||cr.Insurance_Type__c=='Engenium Capital Cash')))
         {
          if (ProfileName.Name =='Insurance') { cr.addError('You cannot approve control desk step.');  }
         }
    }
    String holaMundo = 'Me dijeron que pusiera esto';
    if(holaMundo == 'Me dijeron que pusiera esto')
    {
        holaMundo = 'se que no son buenas practicas pero quieren las cosas rápidas y mal hechas :´(';
    }
}