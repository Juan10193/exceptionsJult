@IsTest
private class ButtonSuppliersApproval_cls_test {
    
    public static testMethod void successRecord() {
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedowns_Contingency_plan__c createTakedownInvoice = Data_Factory_TakedownInvoice_Test.createTakeDownEval();

        ButtonSuppliersApproval_cls.submitApproval(createTakedownInvoice.Id);
    }
}