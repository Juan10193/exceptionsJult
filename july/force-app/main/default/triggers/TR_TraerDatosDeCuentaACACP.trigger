trigger TR_TraerDatosDeCuentaACACP on Credit_approval_CP__c (after insert) {
    
    List<id> idCaList = new List<id>();
    for(Credit_approval_CP__c ca : Trigger.new)
    {        
        //guardamos el id de la cuenta que se ha seleccionado
        idCaList.add(ca.id);    
    }    
    List<Credit_approval_CP__c> caData= new List<Credit_approval_CP__c>();
    List<Credit_approval_CP__c> caListUpdate = new List<Credit_approval_CP__c>();  
    try{
        //traemos los datos que usaremos para actualizar el CA
        caData = [select CPL_rb_account__c,
                  CPL_rb_account__r.name,
                  CPL_rb_account__r.ACC_tx_Risk_Economic_Group__c,
                  CPL_rb_account__r.ACC_rb_Risk_Classification__c,
                  CPL_rb_account__r.ACC_rb_OR_rating__c,
                  CPL_rb_account__r.ACC_un_Total_Exposure__c,
                  CPL_rb_account__r.ACC_un_Capex_Exposure__c,
                  CPL_rb_account__r.ACC_un_Fleet_Exposure__c,
                  CPL_rb_account__r.ACC_un_Real_Estate_Exposure__c,
                  CPL_rb_account__r.ACC_un_Technology_Exposure__c,
                  CPL_rb_account__r.ACC_rb_SIC_Code__c,
                  CPL_rb_account__r.ACC_tx_Customer_Since__c,
                  id
                  from Credit_approval_CP__c where id in:idCaList]; 
        for(Credit_approval_CP__c ca : caData)
        {
            caListUpdate.add(new Credit_approval_CP__c(id=ca.id, //Exposure__c = ca.CPL_rb_account__r.ACC_un_Total_Exposure__c,
                                                       //CPI_un_Technology_Exposure__c = ca.CPL_rb_account__r.ACC_un_Real_Estate_Exposure__c,
                                                       //CPI_un_Real_Estate_Exposure__c = ca.CPL_rb_account__r.ACC_un_Real_Estate_Exposure__c,
                                                       //CPI_un_Fleet_Exposure__c = ca.CPL_rb_account__r.ACC_un_Fleet_Exposure__c,
                                                       //CPI_un_Capex_Exposure__c = ca.CPL_rb_account__r.ACC_un_Capex_Exposure__c,
                                                       //CPI_tx_Risk_Economic_Group__c = ca.CPL_rb_account__r.ACC_tx_Risk_Economic_Group__c,
                                                       CPI_rb_Risk_Classification__c = ca.CPL_rb_account__r.ACC_rb_Risk_Classification__c,
                                                       ES3_tx_Account_Name__c = ca.CPL_rb_account__r.name,
                                                       //CPI_rb_OR_rating__c = ca.CPL_rb_account__r.ACC_rb_OR_rating__c, 
                                                       //CPI_rb_SIC_code__c = ca.CPL_rb_account__r.ACC_rb_SIC_Code__c,
                                                       CPI_tx_Customer_Since__c = ca.CPL_rb_account__r.ACC_tx_Customer_Since__c));
        } 
        if(caListUpdate.size()>0)
            update caListUpdate;
        
    }
    Catch(Exception e){
        System.debug('Exception al seleccionar o actualizar los Credit Approvals OEJ:'+e.getMessage());
    }
    
}