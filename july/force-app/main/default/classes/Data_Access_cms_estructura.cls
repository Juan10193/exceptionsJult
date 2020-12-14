public without sharing class Data_Access_cms_estructura {
    
    @AuraEnabled
    public static string getMessageEstructure(string quey, string recordId, Boolean isJoinQuery, string joinField, string sobjectName){
        if(isJoinQuery ==false){
            string query = quey + '\'' + recordId + '\'';
            List<SObject> sobjt = Database.query(query);
            if(sobjt.size()>0){
                return JSON.serialize(sobjt);
            }
        }else{
            list<SObject>RecordJoinField =Database.query('Select Id, ' + joinField+ ' FROM ' + sobjectName + ' WHERE Id ='  + '\'' + recordId + '\'');
            if(RecordJoinField.size()>0){
                string idJoinField = String.valueOf(RecordJoinField.get(0).get(joinField));
                string query = quey + '\'' + idJoinField + '\'';
                List<SObject> sobjt = Database.query(query);
                if(sobjt.size()>0){
                    return JSON.serialize(sobjt);
                }
            }
        }
       
        
        return null;
    }
}