public class addCurrencyInSuperTrump_handdler {
    
    public void newpricing(map<id,IST__SuperTRUMP_Pricing_Quote__c> newPricings){
        map<string,TBO018_Pricing__c> listp = new map<string,TBO018_Pricing__c> ();
        Map<String,String> mPricings = new Map<String,String>();
        List<String> ltemplate = new List<String>();
        for(TBO018_Pricing__c objTempPic : [select id, TBO018_rb_SuperTRUMP_Pricing_Quote__c from TBO018_Pricing__c where TBO018_rb_SuperTRUMP_Pricing_Quote__c = : newPricings.keySet()]){
            mPricings.put(objTempPic.TBO018_rb_SuperTRUMP_Pricing_Quote__c, objTempPic.id);
        }
        for(id idpri : newPricings.keyset()){
            if(newPricings.get(idpri).IST__QuoteStatus__c == 'Quoted'){
                TBO018_Pricing__c newpricing = new TBO018_Pricing__c();
                newpricing.Id = mPricings.get(idpri);
                newpricing.TBO018_rb_Opportunity__c = newPricings.get(idpri).IST__Opportunity__c;
                system.debug('opportunity ST ' + newPricings.get(idpri).IST__Opportunity__c);
                newpricing.TBO018_rb_SuperTRUMP_Pricing_Quote__c = newPricings.get(idpri).Id;
                newpricing.CurrencyIsoCode = newPricings.get(idpri).MC_Currency__c;
                newpricing.ES3_Opportunity_Collateral__c = newPricings.get(idpri).Opportunity_Collateral__c;
                newpricing.ES3_TX_SUPERTRUMP_TX__c = newPricings.get(idpri).Name;
                newpricing.ES3_nu_Residual_Value_Percent__c = newPricings.get(idpri).Residual_Value__c;
                newpricing.ES3_tx_ARR_ADV__c = newPricings.get(idpri).IST__Payment_Timing__c;
                newpricing.ES3_tx_Ballon_Bullet_Payment__c = string.valueOf(newPricings.get(idpri).IST__Balloon__c);
                newpricing.ES3_tx_Frequency_Monthly_Quarterly__c = newPricings.get(idpri).IST__Periodicity__c;
                newpricing.ES3_tx_Product_TL_QL_LOAN__c = newPricings.get(idpri).Product_Name__c;
                newpricing.TBO018_dv_ANI__c = newPricings.get(idpri).TotalBookANI__c;
                newpricing.TBO018_dv_Amount__c = newPricings.get(idpri).IST__Cost__c;
                newpricing.TBO018_dv_Residual__c = newPricings.get(idpri).IST__Residual__c;
                newpricing.TBO018_fh_Money_Cost_Date__c = newPricings.get(idpri).MoneyCostDateFound__c;
                newpricing.TBO018_ls_Type__c = 'Proposal';
                newpricing.TBO018_pr_Book_Yield__c = newPricings.get(idpri).BookYield__c;
                newpricing.TBO018_pr_Cost_of_Funds_Levered__c = newPricings.get(idpri).Cost_of_Funds_Levered__c;
                newpricing.TBO018_pr_Cost_of_Funds_Unlevered__c = newPricings.get(idpri).Cost_of_Funds_Unlevered__c;
                newpricing.TBO018_pr_Economic_ROE__c = newPricings.get(idpri).Economic_ROE__c;
                newpricing.TBO018_pr_Economic_ROI__c = newPricings.get(idpri).Economic_ROI__c;
                newpricing.TBO018_pr_Economic_Yield__c = newPricings.get(idpri).Economic_Yield__c;
                newpricing.TBO018_pr_Expense_ANI__c = newPricings.get(idpri).Expense_ANI__c;
                newpricing.TBO018_pr_Finance_Margin__c = newPricings.get(idpri).Finance_Margin__c;
                newpricing.TBO018_pr_Full_Term_Rate__c = newPricings.get(idpri).Full_Term_Rate__c;
                newpricing.TBO018_pr_Full_Term_Rate_w_Resid__c = newPricings.get(idpri).FulltermRatewithresidual__c;
                newpricing.TBO018_pr_Lending_Rate__c = newPricings.get(idpri).IST__Lending_Rate__c;
                newpricing.TBO018_pr_Loss_ANI__c = newPricings.get(idpri).LossANI__c;
                newpricing.TBO018_pr_Opening_Fee__c = newPricings.get(idpri).Opening_Fee__c;
                newpricing.TBO018_pr_Security_Deposit__c = newPricings.get(idpri).Security_Deposit__c;
                newpricing.TBO018_tx_Description__c = newPricings.get(idpri).IST__Description__c;
                ltemplate.add(newPricings.get(idpri).IST__Template__c);
                //newpricing.TBO018_tx_Supertrump_Template__c = newPricings.get(idpri).IST__Template__r.Name;
                //newpricing.TBO018_tx_Product__c = newPricings.get(idpri).IST__Template__r.Name == 'EC Loan'?'Term Load':newPricings.get(idpri).IST__Template__r.Name.mid(4,newPricings.get(idpri).IST__Template__r.Name.length());
                newpricing.TBO018_tx_Rate_Type__c = newPricings.get(idpri).Rate_Type__c;
                newpricing.TBO018_un_Contributed_Value__c = newPricings.get(idpri).Contributed_Value__c;
                newpricing.TBO018_un_Depreciation__c = newPricings.get(idpri).Depreciation__c;
                newpricing.TBO018_un_Net_Income__c = newPricings.get(idpri).Net_Income__c;
                newpricing.TBO018_un_Term__c = newPricings.get(idpri).IST__Term__c;
                listp.put(newpricing.TBO018_rb_SuperTRUMP_Pricing_Quote__c,newpricing);
            }
        }
            map<string,string> mSTTemplate = new map<string,string>();
            for(IST__SuperTRUMP_Template__c objTempSTT : [select id, name from IST__SuperTRUMP_Template__c where id =: ltemplate]){
                mSTTemplate.put(objTempSTT.id,objTempSTT.name);
            }
            for(String idpri : listp.keyset()){
                
                    listp.get(idpri).TBO018_tx_Supertrump_Template__c = mSTTemplate.get(newPricings.get(idpri).IST__Template__c);
                    //newpricing.TBO018_tx_Supertrump_Template__c = tem[0].Name;
                    listp.get(idpri).TBO018_tx_Product__c = mSTTemplate.get(newPricings.get(idpri).IST__Template__c) == 'EC Loan'?'Term Loan':mSTTemplate.get(newPricings.get(idpri).IST__Template__c).mid(3,mSTTemplate.get(newPricings.get(idpri).IST__Template__c).length());
                   //listp.put(string.valueOf(templete),newpricing);
                
            }
        if(listp !=null && listp.size()>0){
            system.debug('lista ' + listp);
     		Upsert listp.values();
		}
        //insert newpricing;
    }
}