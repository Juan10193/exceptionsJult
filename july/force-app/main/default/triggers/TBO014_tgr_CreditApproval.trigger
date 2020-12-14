trigger TBO014_tgr_CreditApproval on TBO014_Credit_Approval__c (after update) {
    
    List<Opportunity> updtOppsList = new List<Opportunity>();
    
    for(TBO014_Credit_Approval__c creditApp:trigger.new){
        
        if ((creditApp.TBO014_tx_Status__c != trigger.oldMap.get(creditApp.Id).TBO014_tx_Status__c) && String.isNotEmpty(creditApp.TBO014_tx_Status__c) && ((creditApp.TBO014_tx_Status__c.equals('Submitted')) || (creditApp.TBO014_tx_Status__c.equals('Approved')) || (creditApp.TBO014_tx_Status__c.equals('Conditionally Approved')) || (creditApp.TBO014_tx_Status__c.equals('Declined')) || (creditApp.TBO014_tx_Status__c.equals('Withdrawn')))) {
            List<Opportunity> lstOpp = [Select StageName from Opportunity Where OPP_rb_Credit_Approval__c = :creditApp.Id];
            
            for(Opportunity opp:lstOpp){
                Boolean isUpdt = false;
                
                Date effectiveEndDateCA = creditApp.TBO014_fh_Effective_End_Date__c;
                Date todaysDate = Date.today();
                
                if(creditApp.TBO014_tx_Status__c.equals('Submitted')) {
                    opp.StageName='In Credit';
                    isUpdt = true;
                }
                else if((creditApp.TBO014_tx_Status__c.equals('Approved') || creditApp.TBO014_tx_Status__c.equals('Conditionally Approved'))) {
                    if ((opp.StageName == 'In Credit') || (opp.StageName == 'MOD')) {
                        opp.StageName='Backlog';  
                        isUpdt = true;
                    }
                }
                else if(creditApp.TBO014_tx_Status__c.equals('Declined') || creditApp.TBO014_tx_Status__c.equals('Withdrawn')) {
                    opp.StageName='Lost Deal'; 
                    isUpdt = true;
                }
                
                if (isUpdt) {
                    updtOppsList.add(opp);
                }
            }
            
            if(creditApp.TBO014_ls_Approval_Category__c.equals('MOD') && creditApp.TBO014_tx_Status__c.equals('Approved') && (creditApp.TBO014_rb_Credit_Approval_Original__c != null)) {
                List<Opportunity> lstOppCAO = [Select Id, StageName, Amount from Opportunity Where OPP_rb_Credit_Approval__c = :creditApp.TBO014_rb_Credit_Approval_Original__c];
                
                for (Opportunity opp : lstOppCAO) {
                    AggregateResult completedTakedownResult = [SELECT COUNT(Id) takedownsCompleted FROM TBO020_Takedowns__c WHERE TBO020_tx_Status__c = 'Funded' AND TBO020_pd_Opportunity__c = :opp.Id];
                                        
                    Integer numCompletedTakedowns = ((Integer) completedTakedownResult.get('takedownsCompleted'));
                    
                    if (numCompletedTakedowns == 0) {                        
                        opp.StageName = 'Original MOD';
                    }
                    else if (numCompletedTakedowns > 0) {
                        AggregateResult takedownAmountResult = [SELECT SUM(TBO020_dv_Amount__c) takedownTotalAmount FROM TBO020_Takedowns__c WHERE TBO020_pd_Opportunity__c = :opp.Id];
                        
                        Decimal takedownTotalAmount = ((Decimal) takedownAmountResult.get('takedownTotalAmount'));
                        
                        if (opp.Amount > takedownTotalAmount) {
                            opp.StageName = 'Partially Booked';
                        }
                        else {
                            opp.StageName = 'Funded';
                        }
                    }
                    
                    updtOppsList.add(opp);
                }
            }
        }
    }
    
    try{
        if(Util_cls.updateCreditApp)
            update updtOppsList;            
    }catch(Exception e){
        trigger.new[0].adderror(Util_cls.obtieneMensajeReglaValidacion(e));
    }
}