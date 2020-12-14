/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-13-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-13-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api } from 'lwc';
import WOA_nu_Term_in_months_without_PP from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_nu_Term_in_months_without_PP__c'
import WOA_nu_Term_in_Months_Including_PP from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_nu_Term_in_Months_Including_PP__c'
import WOA_nu_Progress_Payments_M from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_nu_Progress_Payments_M__c'
import WOA_tl_Progress_Description from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_Progress_Description__c'
import WOA_nu_Grace_Period_M from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_nu_Grace_Period_M__c'
import WOA_ls_Type_of_Grace_Period from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Type_of_Grace_Period__c'
import WOA_ls_Low_High_High_Low from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Low_High_High_Low__c'
import WOA_tl_Low_High_High_Low_Description from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_Low_High_High_Low_Description__c'
import WOA_pr_Advance_Payment from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Advance_Payment__c'
import WOA_ls_EFA from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_EFA__c'
import WOA_ls_Used_New from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Used_New__c'
import WOA_ls_SL_B_YES_NO from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_SL_B_YES_NO__c'
import WOA_ls_EBO from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_EBO__c'
import WOA_tl_EBO_Description from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_EBO_Description__c'
import WOA_tl_Asset_description from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_Asset_description__c'
import WOA_tl_Return_Condition from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_Return_Condition__c'
import WOA_pr_Remarketing_Fee from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Remarketing_Fee__c'
import WOA_pr_Split_Trac from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Split_Trac__c'
import WOA_pr_Lock_Fee from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Lock_Fee__c'
import WOA_tx_Boot_Collateral_Type from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tx_Boot_Collateral_Type__c'
import WOA_tl_EOL_Option from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_tl_EOL_Option__c'
import WOA_ls_Prom_Note from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Prom_Note__c'
import WOA_ls_Carga_Peligrosa from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Carga_Peligrosa__c'
import WOA_ls_Cash_Collateral from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Cash_Collateral__c'
import WOA_ls_Cross_Collateral from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Cross_Collateral__c'
import WOA_ls_Direct_Debit from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_ls_Direct_Debit__c'
import WOA_nu_ROI_No_Insurance from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_nu_ROI_No_Insurance__c'
import WOA_pr_Opening_Fee from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Opening_Fee__c'
import WOA_dv_Security_Deposit from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_dv_Security_Deposit__c'
import WOA_pr_Security_Deposit from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Security_Deposit__c'
import WOA_at_Security_Deposit_Comments from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_at_Security_Deposit_Comments__c'
import WOA_pr_Rate from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_Rate__c'
import WOA_pr_RV from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_RV__c'
import WOA_dv_Ballon_Bullet_Payment from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_dv_Ballon_Bullet_Payment__c'
import WOA_pr_P_Option from '@salesforce/schema/IST__SuperTRUMP_Pricing_Quote__c.WOA_pr_P_Option__c'

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WoaSuperTrumpClosingMemoForm extends LightningElement {
    @api recordId

    fields = [WOA_nu_Term_in_months_without_PP,
        WOA_nu_Term_in_Months_Including_PP,
        WOA_nu_Progress_Payments_M,
        WOA_tl_Progress_Description,
        WOA_nu_Grace_Period_M,
        WOA_ls_Type_of_Grace_Period,
        WOA_ls_Low_High_High_Low,
        WOA_tl_Low_High_High_Low_Description,
        WOA_pr_Advance_Payment,
        WOA_ls_EFA,
        WOA_ls_Used_New,
        WOA_ls_SL_B_YES_NO,
        WOA_ls_EBO,
        WOA_tl_EBO_Description,
        WOA_tl_Asset_description,
        WOA_tl_Return_Condition,
        WOA_pr_Remarketing_Fee,
        WOA_pr_Split_Trac,
        WOA_pr_Lock_Fee,
        WOA_tx_Boot_Collateral_Type,
        WOA_tl_EOL_Option,
        WOA_ls_Prom_Note,
        WOA_ls_Carga_Peligrosa,
        WOA_ls_Cash_Collateral,
        WOA_ls_Cross_Collateral,
        WOA_ls_Direct_Debit,
        WOA_nu_ROI_No_Insurance,
        WOA_pr_Opening_Fee,
        WOA_dv_Security_Deposit,
        WOA_pr_Security_Deposit,
        WOA_at_Security_Deposit_Comments,
        WOA_pr_Rate,
        WOA_pr_RV,
        WOA_dv_Ballon_Bullet_Payment,
        WOA_pr_P_Option]

    handleSuccess() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: "Success!!",
                message: 'The record has been updated.',
                variant: "Success"
            })
        );
    }
}