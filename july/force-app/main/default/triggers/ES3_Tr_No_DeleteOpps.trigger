trigger ES3_Tr_No_DeleteOpps on Opportunity_in_Credit_approval_CP__c (before delete) {
    
    list<id>oppIds = new list<id>();
    
    string userProfile =getUserProfile();
    
    for(Opportunity_in_Credit_approval_CP__c OppInCA :trigger.old ){
        
        oppIds.add(OppInCa.CP_rb_Credit_approval_CP__c);
        
        
    }
    
    list<Credit_approval_CP__c> CPS = [SELECT ES3_ls_RISK_REVIEW_STATUS__c FROM Credit_approval_CP__c where Id in:oppIds];
    
    for(Opportunity_in_Credit_approval_CP__c OppInCA :trigger.old ){
        system.debug('JD perfil: ' + userProfile);
        if(userProfile !='System Administrator'&&
           userProfile !='Administrador del sistema'&&
           userProfile !='Administrator'){
               
               for(Credit_approval_CP__c CP : CPS){
                   
                   if(CP.id == OppInCA.CP_rb_Credit_approval_CP__c && (CP.ES3_ls_RISK_REVIEW_STATUS__c =='Decline' || CP.ES3_ls_RISK_REVIEW_STATUS__c =='Approved'|| CP.ES3_ls_RISK_REVIEW_STATUS__c =='Approved with conditions'|| CP.ES3_ls_RISK_REVIEW_STATUS__c =='Withdrawn'))
                   {
                       OppInCa.adderror('Opportunity Cannot be deleted when status is: ' + CP.ES3_ls_RISK_REVIEW_STATUS__c);
                   }
               }
           }
    }
    
    
    
    public static string getUserProfile(){
        id id1 = userinfo.getProfileId();
        system.debug('JD idddd:' + id1);
        string profileName;
        
        for (profile record :[Select Name  from profile where Id=:id1]){
            profileName = record.Name;
            
        }
        
        return profileName;
    }
    
}