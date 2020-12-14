public class Helper_Upsert_CSV_cls {
    public List<String> listWithSustitutes {get;set;}
    public Map<String,String> mapWithSustitutes {get;set;}
    
    public void upsertCSVFileFinal(string csv, List<String> apiHeader, String sobjectName){   
        System.debug(LoggingLevel.INFO,'Inicia upsertCSVFile');
        try{
            schema.SObjectType sobjType = Schema.getGlobalDescribe().get(sobjectName);        
        	Map<String, Schema.sObjectField> sObjectFields = sobjType.getDescribe().fields.getMap();
            if(String.isNotEmpty(csv)){ 
                List<string> dirtyRow = new List<string>();
                dirtyRow = cleanCSV(csv);
                List<sObject> myList = new List<sObject>();
                for (Integer i=1,j=dirtyRow.size(); i<j; i++){
                  	String[] inputvalues = new String[]{};
                  	inputvalues = cleanRow(dirtyRow[i]); 
                  	sObject obj = createObject(sobjectName);
                    integer rowsize = inputvalues.size();
                    for(integer l=0;l<rowsize;l++){
                       String valueToWork;
                            valueToWork = inputvalues[l];
                       if(String.isNotBlank(valueToWork)){
                          obj = makeDynamicDML(sObjectFields, obj, apiHeader.get(l), valueToWork);
                       }else{
                          obj.put(apiHeader.get(l),null);
                       }
                   }
                   myList.add(obj);
               }
                update myList;
            }
              
        }catch(Exception e){
             System.debug('exception '+e);
             System.debug('exception '+e.getLineNumber());
            
        }
    }
    
    public sObject createObject(String typeName) {
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(typeName);
        if (targetType == null) {
            // throw an exception
        }        
        return targetType.newSObject(); 
    }
    
    public sobject makeDynamicDML(Map<String, Schema.SObjectField> sObjectFields, sObject obj, String fieldApiName, String value){
        System.debug(LoggingLevel.INFO,'Inicia makeDynamicDML');
        Schema.DisplayType valueType = sObjectFields.get(fieldApiName).getDescribe().getType();
        String svalue = (String)value;
        if(valueType == Schema.DisplayType.String || 
            valueType == Schema.DisplayType.TextArea ||
            valueType == Schema.DisplayType.Id ||
            valueType == Schema.DisplayType.Picklist ||
            valueType == Schema.DisplayType.Reference ||
            valueType == Schema.DisplayType.Phone ||
            valueType == Schema.DisplayType.Email ||
           valueType == Schema.DisplayType.URL){
           obj.put(fieldApiName, value);    
           } else if (valueType == Schema.DisplayType.Date){
            	obj.put(fieldApiName, Date.valueOf(svalue));    
            } else if(valueType == Schema.DisplayType.DateTime) {
                /*try{
                    System.debug( (DateTime)value);
                }catch(exception ex) {
                    system.debug(ex.getmessage());
                }*/
                String d1 = svalue;
                list<String> d2 = d1.split('-');
                list<integer> timeComponent = new list<integer>();
                timeComponent.add(Integer.valueOf(d2[0]));
                timeComponent.add(Integer.valueOf(d2[1]));
                timeComponent.add(Integer.valueOf(d2[2].left(2)));
                String t = d2[2].substringBetween('T','.');
                list<String> time1 = t.split(':');
                timeComponent.add(Integer.valueOf(time1[0]));
                timeComponent.add(Integer.valueOf(time1[1]));
                timeComponent.add(Integer.valueOf(time1[2]));
                Datetime dt = Datetime.newInstance(timeComponent[0],timeComponent[1],timeComponent[2],timeComponent[3],timeComponent[4],timeComponent[5]);
                obj.put(fieldApiName, dt);
            } else if (valueType == Schema.DisplayType.Percent || valueType == Schema.DisplayType.Currency){
            	obj.put(fieldApiName, svalue == '' ? null : Decimal.valueOf(svalue.trim()));    
            } else if (valueType == Schema.DisplayType.Double){
                obj.put(fieldApiName, svalue == '' ? null : Double.valueOf(svalue));                
            } else if (valueType == Schema.DisplayType.Integer){
                obj.put(fieldApiName, svalue == '' ? null : Integer.valueOf(svalue));                
            } else if (valueType == Schema.DisplayType.Base64){
                obj.put(fieldApiName, Blob.valueOf(svalue));                
            } else if (valueType == Schema.DisplayType.Boolean){
                boolean val = getDisplayTypeBoolean(svalue);
                obj.put(fieldApiName, val);                
            }else{
                obj.put(fieldApiName, svalue);                
            }
        System.debug(LoggingLevel.INFO,'Termina makeDynamicDML');
        return obj;
        
    } 
    public boolean getDisplayTypeBoolean(String value){
        return value == '' ? null : value.toUpperCase().equals('TRUE') ? true : false;
    }
    public List<String> cleanCSV(String csv){
        System.debug(LoggingLevel.INFO,'Inicia cleanCSV csv ' + csv);
        this.mapWithSustitutes = new map<String,String>();
        List<String> dirtyRow = new List<String>();
        this.listWithSustitutes = new List<String>();
        integer i = 0;
        while(true){
            if(csv.containsNone('"')){
                dirtyRow = csv.split('\n');
                break;
            } else{
                system.debug('Encontró un entre comillas ' + csv.substringBetween('"'));
                //string regex = '"' + csv.substringBetween('"') + '"';
                string regex = '"' + csv.substringBetween(',"','",') + '"';
                String remplace = '|' + i + '|';
                system.debug('remplace ' + remplace + ' regex ' + regex);
                this.mapWithSustitutes.put(remplace, regex);
                csv = csv.replace(regex, remplace);
                
                system.debug('lista de rows final this.mapWithSustitutes.get() ' + this.mapWithSustitutes.get(remplace));
            } 
            i++;
            if(i == 50){
              //  break;
            }
        }
        System.debug(LoggingLevel.INFO,'Termina cleanCSV');
        return dirtyRow;

    }
    public List<String> cleanRow(String dirtyRow){
        System.debug(LoggingLevel.INFO,'Inicia cleanRow');
        List<String> dirtyfield = new List<String>();
        dirtyfield = dirtyRow.split(',');
        
        List<String> cleanRow = new List<String>();
        
        for(String field : dirtyfield){
            system.debug('field ' + field);
            //String finalValue = this.mapWithSustitutes.get(field);
            String finalValue = '';
            
            if(this.mapWithSustitutes.containsKey(field)){
                
                finalValue = this.mapWithSustitutes.get(field);
                    //cleanRow.add(this.mapWithSustitutes.get(field));
                system.debug('this.mapWithSustitutes.key ' + field);
                system.debug('this.mapWithSustitutes.get(field) ' + this.mapWithSustitutes.get(field));
            } else {
            	finalValue = field;   
            }
            if(finalValue.contains('|escape|')){
            	finalValue = finalValue.replace('|escape|','"');                
            }
            cleanRow.add(finalValue);
        }
        system.debug('Se han limpiado las filas');
        System.debug(LoggingLevel.INFO,'Termina cleanRow');
        return cleanRow;
    }

}