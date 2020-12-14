/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-13-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-07-2020   eduardo.amiens@outlook.com   Initial Version
**/
public without sharing class woaClosingMemoOppController {
    
    @AuraEnabled(cacheable=true)
    public static WS_ClosingMemoREST_Wrapper getClosingMemo(Id oppId) {
        WS_ClosingMemoREST_OppHelper helper = new WS_ClosingMemoREST_OppHelper(oppId);
        return helper.getData();
    }
}