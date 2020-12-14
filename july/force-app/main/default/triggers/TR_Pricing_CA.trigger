trigger TR_Pricing_CA on ES3_obj_Pricing_in_Credit_Approval__c (before insert,before delete, before update) {
    TR_Handdler_Pricing_CA handdler_pricing = new TR_Handdler_Pricing_CA();
    String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
    if(!profileName.equals('Administrator') && !profileName.equals('System Administrator') && !profileName.equals('Administrador del sistema')){
        system.debug('profileName ' + profileName);
        if(Trigger.isDelete && Trigger.isBefore){
            handdler_pricing.Valida_Pricing(Trigger.old,'Is not possible delete this record because the credit approval has been approved ');
        } else if (Trigger.isInsert && Trigger.isBefore){
            handdler_pricing.Valida_Pricing(Trigger.new,'Is not possible add this record because the credit approval has been approved');
        } else if (Trigger.isUpdate && Trigger.isBefore){
            handdler_pricing.Valida_Stage_CA(Trigger.newMap,profileName); 
        }
    }
}