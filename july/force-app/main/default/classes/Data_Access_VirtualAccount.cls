public class Data_Access_VirtualAccount {
    public static map<String,Virtual__c> getVirtualAccountByName(list<string> name){
        map<String,Virtual__c> mapVirtualAccount = new map<String,Virtual__c>();
        for(Virtual__c virtualAccount: [SELECT Id, OwnerId, Name, Bank__c, CLABE__c, Entity_CP_id__c, 
                                           Entity_CP_Name__c, Engeniun_Legal_Entity__c 
                                           FROM Virtual__c where name in:name]){
        	mapVirtualAccount.put(virtualAccount.Engeniun_Legal_Entity__c, virtualAccount);            
        }      
        return mapVirtualAccount;       
    }

}