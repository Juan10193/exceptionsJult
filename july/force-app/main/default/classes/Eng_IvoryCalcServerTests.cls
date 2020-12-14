@IsTest
private class Eng_IvoryCalcServerTests {
    
    static testMethod void testParseCalculationFieldValue_Null(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, null));
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, null));
    }
    
    static testMethod void testParseCalculationFieldValue_AnyType_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.AnyType, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Base64_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Base64, '%%%$!!!+=+//'));
    }
    
    static testMethod void testParseCalculationFieldValue_Base64_Valid(){
        Blob value = Blob.valueOf('hello');
        System.assertEquals(value.toString(), ((Blob) Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Base64, System.EncodingUtil.base64Encode(value))).toString());
    }
    
    static testMethod void testParseCalculationFieldValue_Boolean_Invalid(){
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, 'aaaaa'));
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, '00000'));
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, '1'));
    }
    
    static testMethod void testParseCalculationFieldValue_Boolean_Valid(){
        System.assertEquals(true, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, 'true'));
        System.assertEquals(true, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, 'TrUe'));
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, 'false'));
        System.assertEquals(false, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Boolean, null));
    }
    
    static testMethod void testParseCalculationFieldValue_Combobox_Valid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.ComboBox, ''));
        System.assertEquals('happy day', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.ComboBox, 'happy day'));
    }
    
    static testMethod void testParseCalculationFieldValue_Currency_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, ''));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, '0ab'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, 'ab0'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, 'zero'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, '25.23L'));
    }
    
    static testMethod void testParseCalculatinoFieldValue_Currency_Valid(){
        System.assertEquals(25.23, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, '25.23'));
    }
    
    static testMethod void testParseCalculationFieldValue_DataCategoryGroupReference_Valid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DataCategoryGroupReference, ''));
        System.assertEquals('happy day', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DataCategoryGroupReference, 'happy day'));
    }
    
    static testMethod void testParseCalculationFieldValue_Date_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, 'March 3, 2015'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, '2015-02-29'));
    }
    
    static testMethod void testParseCalculationFieldValue_Date_Valid(){
        System.assertEquals(Date.valueOf('2016-02-29'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, 'D360:2016-02-30'));
        System.assertEquals(Date.valueOf('2015-02-28'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, 'D360:2015-02-30'));
        System.assertEquals(Date.valueOf('2015-02-28'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, 'D360:2015-02-28'));
        System.assertEquals(Date.valueOf('2015-02-28'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, '2015-02-28'));
        System.assertEquals(Date.valueOf('2016-02-29'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, '2016-02-29'));
        System.assertEquals(Date.valueOf('2014-02-28'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, 'D360:2014-02-29'));
        System.assertEquals(Date.valueOf('2014-02-01'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Date, '2014-02-01'));
    }
    
    static testMethod void testParseCalculationFieldValue_DateTime_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, '3:00 PM March 3, 2015'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, 'D360:2015-02-31'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, '2015-02-29'));
    }
    
    static testMethod void testParseCalculationFieldValue_DateTime_Valid(){
        System.assertEquals(DateTime.valueOf('2016-02-29 12:24:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, 'D360:2016-02-30 12:24:00'));
        System.assertEquals(DateTime.valueOf('2015-02-28 12:24:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, 'D360:2015-02-30 12:24:00'));
        System.assertEquals(DateTime.valueOf('2015-02-28 00:00:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, 'D360:2015-02-29 00:00:00'));
        System.assertEquals(DateTime.valueOf('2015-02-28 12:24:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, 'D360:2015-02-28 12:24:00'));
        System.assertEquals(DateTime.valueOf('2015-02-28 12:24:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, '2015-02-28 12:24:00'));
        System.assertEquals(DateTime.valueOf('2016-02-29 12:24:00'), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.DateTime, '2016-02-29 12:24:00'));
    }
    
    static testMethod void testParseCalculationFieldValue_Double_Invalid(){
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Double, '0ab'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Double, 'ab0'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Double, 'zero'));
    }
    
    static testMethod void testParseCalculationFieldValue_Email_Valid(){
        System.assertEquals('testuser@testing.com', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Email, 'testuser@testing.com'));
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Email, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_EncryptedString_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.EncryptedString, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Id_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Id, '0ab'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Id, 'abcdefghijklmnop'));
    }
    
    static testMethod void testParseCalculationFieldValue_Id(){
        Id oppId = Eng_IvoryTestServices.getFakeId(sObjectType.Opportunity);
        System.assertEquals(oppId, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Id, String.valueOf(oppId)));
    }
    
    static testMethod void testParseCalculationFieldValue_Integer_Invalid(){
        System.assertEquals(0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, '0ab'));
        System.assertEquals(0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, 'ab0'));
        System.assertEquals(0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, 'abc'));
        System.assertEquals(0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, '15.65'));
    }
    
    static testMethod void testParseCalculationFieldValue_Integer_Valid(){
        System.assertEquals(12, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, '12'));
        System.assertEquals(25000, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, '25000'));
    }
    
    static testMethod void testParseCalculationFieldValue_MultiPicklist_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.MultiPicklist, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Percent_Invalid(){
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, '0ab'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, 'ab0'));
        System.assertEquals(0.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, 'zero'));
    }
    
    static testMethod void testParseCalculationFieldValue_Percent_Valid(){
        System.assertEquals(87.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, '0.87'));
        System.assertEquals(1.0, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, '0.01'));
    }
    
    static testMethod void testParseCalculationFieldValue_Phone_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Phone, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Picklist_Invalid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Picklist, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Reference_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Reference, '0ab'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Reference, '123456789'));
    }
    
    static testMethod void testParseCalculationFieldValue_Reference_Valid(){
        DescribeSObjectResult describeObj = Schema.sObjectType.Opportunity;
        Id oppId = Eng_IvoryTestServices.getFakeId(describeObj);
        System.assertEquals(oppId, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Reference, String.valueOf(oppId)));
        
        oppId = Eng_IvoryTestServices.getFakeId(describeObj);
        System.assertEquals(oppId, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Reference, String.valueOf(oppId)));
    }
    
    static testMethod void testParseCalculationFieldValue_String_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_TextArea_Valid(){
        System.assertEquals('parsing accepts anything', Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.TextArea, 'parsing accepts anything'));
    }
    
    static testMethod void testParseCalculationFieldValue_Time_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, 'all values are invalid. this type is not supported'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '12:24'));
    }
    
    static testMethod void testParseCalculationFieldValue_Time_Valid(){
        System.assertEquals(Time.newInstance(12, 24, 12, 12), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '12:24:12.012'));
        System.assertEquals(Time.newInstance(12, 24, 12, 0), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '12:24:12'));
        System.assertEquals(Time.newInstance(12, 24, 12, 100), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '12:24:12.1000'));
        System.assertEquals(Time.newInstance(12, 25, 0, 0), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '12:24:60'));
        System.assertEquals(Time.newInstance(23, 59, 59, 0), Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Time, '2015-08-12 23:59:59'));
    }
    
    static testMethod void testParseCalculationFieldValue_URL_Invalid(){
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.URL, 'login.salesforce.com'));
        System.assertEquals(null, Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.URL, '/a/server/url'));
    }
    
    static testMethod void testParseCalculationFieldValue_URL_Valid(){
        String urlAsString = 'https://x-trump.com';
        Object parsedValue = Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.URL, urlAsString);
        System.assertEquals(new URL(urlAsString).toExternalForm(), ((URL)parsedValue).toExternalForm());
    }
}