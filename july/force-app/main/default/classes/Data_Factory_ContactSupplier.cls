@Istest
public class Data_Factory_ContactSupplier {
    public static Contact createSupplierContact(string firstName, string lastName, Id siteId){
        Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Supplier_Contact').getRecordTypeId();
        Contact con = new Contact();
        con.RecordTypeId = recordTypeId;
        con.Email = 'exampleContact@test.com';
        con.Phone = '8451021012';
        con.FirstName = firstName;
        con.LastName = lastName;
        con.Department ='Departament';
        con.TKD_rb_Site__c = siteId;
        insert con;
        return con;
    }
    public static Contact createNewSupplierContact(Id siteId){
        Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Supplier_Contact').getRecordTypeId();
        Contact con = new Contact();
        con.RecordTypeId = recordTypeId;
        con.Department = 'TI';
        con.CON_un_Phone_number_extension__c = 'ext 23';
        con.SR_tf_Phone_area_code__c = '234';
        con.Email = 'exampleContact@test.com';
        con.Phone = '8451021012';
        con.FirstName = 'Test first name';
        con.LastName = 'Test last name';
        con.Department ='Departament';
        con.TKD_rb_Site__c = siteId;
        insert con;
        return con;
    }
}