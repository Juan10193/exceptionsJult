public class Data_Access_TBO014_Credit_Approval {
	public static map<id,TBO014_Credit_Approval__c> getCABysetID(set<id> caIds){
         map<id,TBO014_Credit_Approval__c> mapCA = new  map<id,TBO014_Credit_Approval__c>([SELECT Id, TBO014_un_Amount_MXN__c, TBO014_un_Amount_USD__c, TBO014_un_Total_Amount_USD_Converted__c 
                                                  FROM TBO014_Credit_Approval__c 
                                                  WHERE Id in :caIds]);
    	return mapCA;
    }
}