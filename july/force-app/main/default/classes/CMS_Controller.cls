//Juand
public without sharing class CMS_Controller {
    
   /*  @AuraEnabled(cacheable =false)
    public static string documentsProcess(SObject objeto, string processName,string recordTypeName, Boolean isUnic){
        string query = CMS_Controller.getQuery(objeto, processName,recordTypeName, isUnic);
        system.debug('EL QUERY');
        System.debug(query);
        string jsonString = Data_Access_cms_mdt.getCmsRecord(query);
        return jsonString;
    }
 */


   /*  public static string getQuery(SObject objeto, string processName,string recordTypeName, Boolean isUnic){
        system.debug('EL UNICO: '  + isUnic);
        string nombreObjeto  = String.valueOf(objeto.getSObjectType());
        if(nombreObjeto.contains('__c')){
            nombreObjeto = nombreObjeto.remove('__c');
        }
        string seleccion ='SELECT RecordType_Name__c, Process_Name__c,CMS_Process__c, Process_ID__c, Documents_to_Exclude__c';
        string desde = ' FROM ' + nombreObjeto+ 'CMS__mdt';
        if(processName != String.valueOf(objeto.getSObjectType())){
            system.debug('Imprimiendo el SOBJECT');
            system.debug(objeto);
            system.debug('Imprimiendo el Processo');
            System.debug(processName);
            Map<String, Object> fieldsToValue = objeto.getPopulatedFieldsAsMap();
            
            if(isUnic ==false){
                string query = ' Where ';

                for(string fieldName: fieldsToValue.keySet()){
                    system.debug('field name is ' + fieldName + ', value is ' +  fieldsToValue.get(fieldName));
                    string campo = fieldName.contains('__c')==false?fieldName+'__c':fieldName;
                    system.debug('Campo ' +campo);
                    query += campo + ' = ';
                    query += '\'' + fieldsToValue.get(fieldName) +'\'' + ' AND ';
                }
                system.debug('vamos a remover el ultimo and');
                query= query.removeEnd(' AND ');
                system.debug(query);
                return seleccion + desde + query;
            }else {
                string query = ' Where ';

                query += 'Process_Name__c LIKE ' + '\'%'+objeto.getSObjectType() + ' ' + processName + ' Unico%'+ '\'' ;
                
                return seleccion + desde + query;
            } */
      /*       
        }else if(processName == String.valueOf(objeto.getSObjectType())){
            Map<String, Object> fieldsToValue = objeto.getPopulatedFieldsAsMap();
            if(isUnic ==false){
                string query = ' Where ';
                for(string fieldName: fieldsToValue.keySet()){
                    system.debug('field name is ' + fieldName + ', value is ' +  fieldsToValue.get(fieldName));
                    string campo = fieldName.contains('__c')==false?fieldName+'__c':fieldName;
                    query += campo + ' = ';
                    query += '\'' + fieldsToValue.get(fieldName) +'\'  AND ';
                }

                query += 'Process_Name__c LIKE ' + '\'%'+objeto.getSObjectType()+'\'';
                return seleccion + desde + query;
            }else{
                string query = ' Where ';
                query += 'Process_Name__c LIKE ' + '\'%'+objeto.getSObjectType() + ' Unico%'+ '\'' ;
                return seleccion + desde + query;
            }
             
        } */
     /*    }
        return null;
    }
 */

    @AuraEnabled
    public static string getUserFields(){
        string userId = UserInfo.getUserId();
        list<User> usuario = [Select Name, EmployeeNumber from User where Id =:userId];
        if(usuario.size()>0){
            return JSON.serialize(usuario[0]);
        }

        return null;
    }

    @AuraEnabled
    public static SObject getRecordNameById(string recordId, string apiName){
        List<SObject> objecto = Database.query('Select Name From ' + apiName + ' Where Id=' + '\''+ recordId + '\'');
        return objecto[0];
    }
}