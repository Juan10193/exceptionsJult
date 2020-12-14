public with sharing class Eng_IvoryCalcServer {
    
    public static Object parseCalculationFieldValue(Schema.DisplayType fieldType, String value){
        String fieldTypeName = fieldType.name().ToLowerCase();
        if (String.isEmpty(value) && fieldTypeName != 'boolean'){
            return null;
        }
        Object fieldValue = null;

        try{
            if (fieldTypeName == 'currency' || fieldTypeName == 'double' || fieldTypeName == 'percent' )
            {
                try {
                    fieldValue = Decimal.valueOf(value.trim());
                    if (fieldTypeName == 'percent'){
                        fieldValue = ((Decimal) fieldValue) * 100;
                    }
                }
                catch (System.TypeException e) {
                    fieldValue = 0.0;
                    throw e;
                }
            }
            else if (fieldTypeName == 'integer'){
                try{
                    fieldValue = Integer.valueOf(value.trim());
                }
                catch(System.TypeException e){
                    fieldValue = 0;
                    throw e;
                }
            }
            else if (fieldTypeName == 'boolean')
            {
                fieldValue = value == null ? false : Boolean.valueOf(value);
            }
            else if (fieldTypeName == 'date' || fieldTypeName == 'datetime')
            {
                String sDate = value.trim();
                boolean is360 = false;
                if (sDate.startsWith('D360:')) {
                    sDate = sDate.substring(5);
                    is360 = true;
                    if (sDate.contains('02-30') || sDate.contains('02-29')) {
                        String stringPattern = '(\\d+)-\\d+-\\d+';
                        if (fieldTypeName == 'datetime'){
                            stringPattern += '( \\d+:\\d+:\\d+(\\.\\d+)?)';
                        }
                        Matcher dateMatcher = Pattern.compile(stringPattern).matcher(value);
                        if (dateMatcher.find()){
                            Boolean isLeapYear = Date.isLeapYear(Integer.valueOf(dateMatcher.group(1)));
                            String monthDay;
                            if (isLeapYear){
                                monthDay = '-02-29';
                            }
                            else{
                                monthDay = '-02-28';
                            }
                            sDate = dateMatcher.group(1) + monthDay;
                            if (fieldTypeName == 'datetime'){
                                sDate += dateMatcher.group(2);
                            }
                        }
                    }
                }
                if (fieldTypeName == 'date'){
                    fieldValue = Date.valueOf(sDate);
                }
                else{
                    fieldValue = DateTime.valueOf(sDate);
                }
            }
            else if (fieldTypeName == 'base64'){
                fieldValue = System.EncodingUtil.base64Decode(value);
            }
            else if (fieldTypeName == 'reference' || fieldTypeName == 'id'){
                fieldValue = Id.valueOf(value);
            }
            else if (fieldTypeName == 'time'){
                Matcher timeMatcher = Pattern.compile('(\\d+):(\\d+):(\\d+)(\\.(\\d+))?').matcher(value);
                if (timeMatcher.find()){
                    Integer hours = Integer.valueOf(timeMatcher.group(1));
                    Integer minutes = Integer.valueOf(timeMatcher.group(2));
                    Integer seconds = Integer.valueOf(timeMatcher.group(3));
                    Decimal fraction = timeMatcher.group(5) != null ? Decimal.valueOf('0.' + timeMatcher.group(5)) : 0;
                    Integer milliseconds = (fraction * 1000).setScale(0, System.RoundingMode.HALF_UP).intValue();
                    fieldValue = Time.newInstance(hours, minutes, seconds, milliseconds);
                }
            }
            else if (fieldTypeName == 'url'){
                fieldValue = new URL(value);
            }
            else if (fieldTypeName == 'anytype'){
                System.debug(System.LoggingLevel.WARN, 'The display type "anytype" may not be parsed correctly. Value: ' + value.abbreviate(40));
                fieldValue = value;
            }
            else
            {
                // the value being stored is a string, but we don't know the source field type. Since we don't know, we
                // always have to check if this is a D360 date field encoding, and if it is, then remove the D360 prefix
                fieldValue = value.replaceFirst('^\\s*D360\\:', '');
            }
        }
        catch(Exception e){
            System.debug(System.LoggingLevel.ERROR, 'Error parsing a ' + fieldTypeName + '. Value: ' + value.abbreviate(40) + ', Error Message: ' + e.getMessage() + '\n' + e.getStackTraceString());
        }
        
        return fieldValue;
    }
}