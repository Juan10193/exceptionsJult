public without sharing class Data_Access_cms_mdt {
    
    public static String getCmsRecord(string query){
        string sqlQuery = '\'' + query + '\'';
        List<SObject> sobjList = Database.query(query);
        string jsonString = JSON.serialize(sobjList);
        return jsonString;
    }
}