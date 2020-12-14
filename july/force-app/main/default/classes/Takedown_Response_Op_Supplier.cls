/**
 * @File Name          : Takedown_Response_Op_Supplier.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 09-29-2020
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/8/2019 20:09:32   eduardo.amiens@outlook.com     Initial Version
**/
public class Takedown_Response_Op_Supplier {
    public static list<Supplier__c> upsertSupplier(Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier responseDetSearchKnownSupplier, id takedownID){
        Supplier_in_approval__c supplierInApproval = [SELECT id, TKD_rb_SupplierInApproval__r.CPL_ls_Operation_Unit__c FROM Supplier_in_approval__c where TKD_rb_SupplierInApproval__c = :takedownID];
        map<string,Supplier__c> mapSuppliers = new map<string,Supplier__c>();
        list<Supplier__c> listSupplier = new list<Supplier__c>();
        list<TKD_Site__c> listSite = new list<TKD_Site__c>();
        list<Contact> listContact = new list<Contact>();
        list<Bank_Account__c> listBankAccount = new list<Bank_Account__c>(); 
        for(Takedown_Wrapper_DetSearchKnownSuppliers.Supplier supplier : responseDetSearchKnownSupplier.suppliers.supplier){            
        	Supplier__c newSupplier = new Supplier__c();
            newSupplier.name = supplier.vendorName;
            newSupplier.TKD_tx_Vendor_name_alternative__c = supplier.vendorNameAlt;
            newSupplier.TKD_tx_Vat_Registration_Num__c = supplier.vatRegistrationNum;  
            //newSupplier.TKD_tx_Supplier_Unique_ID__c = takedownID + supplier.vatRegistrationNum; 
            newSupplier.TKD_Vendor_ID__c = String.valueOf(supplier.vendorId) + takedownID;
            newSupplier.TKD_pd_Supplier_in_approval__c = supplierInApproval.id;
            newSupplier.Nacionalidad__c= supplier.attribute3;
            newSupplier.TKD_ls_Pais_de_residencia__c=supplier.attribute2;
            newSupplier.TKD_ls_Tipo_de_tercero__c= supplier.attribute1;
            newSupplier.Categoria__c= supplier.attributeCategory;
            mapSuppliers.put(newSupplier.TKD_Vendor_ID__c, newSupplier);
            //listSupplier.add(newSupplier);
            if(supplier.sites != null){
            	for(Takedown_Wrapper_DetSearchKnownSuppliers.Site site : supplier.sites.site){  
                    if(supplierInApproval.TKD_rb_SupplierInApproval__r.CPL_ls_Operation_Unit__c.equals(site.organizationName)){           
                        TKD_Site__c newSite = new TKD_Site__c();
                        newSite.name = site.vendorSiteCode;
                        newSite.Tkd_at_Address_line_1__c = site.addressLine1;
                        newSite.Tkd_at_Address_line_2__c = site.addressLine2;
                        newSite.Tkd_tx_Country__c = site.country;
                        newSite.Tkd_ls_Org_Name__c = site.organizationName;
                        newSite.tkd_tf_phone__c = site.phone;
                        newSite.Tkd_tx_City__c = site.city;
                        newSite.TKD_ls_State__c = site.state;
                        newSite.Tkd_tx_Zip__c = site.zip;
                        newSite.SR_ls_Currency__c = site.paymentCurrencyCode;
                        newSite.inactiveDate__c = site.inactiveDate;
                        newSite.TKD_Vendor_Site_ID__c = String.valueof(site.vendorSiteId) + takedownID;
                        newSite.TKD_Vendor_ID__c = String.valueof(site.vendorId) + takedownID;
                        newSite.TKD_Vat_code__c = site.vatCode; //Add
                        newSite.CurrencyIsoCode = site.paymentCurrencyCode; //Add
                        newSite.primaryPaySiteFlag__c = site.primaryPaySiteFlag =='Y'?true:false;
                        newSite.Pay_Site_Flag__c = site.paySiteFlag =='Y'?true:false;
                        listSite.add(newSite);
                        if(site.accounts != null)
                        for(Takedown_Wrapper_DetSearchKnownSuppliers.account account : site.accounts.account){
                            Id BankAccountRecordTypeId = Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
                            Bank_Account__c bankAccount = new Bank_Account__c(); 
                            bankAccount.Bank_Account_Name__c = String.valueOf(account.bankAccountName);
                            bankAccount.SR_tx_Bank_Name__c = account.bankName;                            
                            bankAccount.Bank_Account_Currency__c = account.curency;
                            bankAccount.Name = account.bankAccountNum;
                            bankAccount.Tipo_BIC__c = account.attribute1;
                            bankAccount.Codigo_BIC__c = account.attribute2;
                            bankAccount.Nombre_Banco_intermediadio__c =  account.attribute3;
                            bankAccount.Tipo__c = account.attribute4;
                            bankAccount.Codigo__c = account.attribute5;
                            bankAccount.SR_tx_Country__c = account.countryCode;
                            bankAccount.RecordTypeId = BankAccountRecordTypeId;
                            bankAccount.TKD_Vendor_Site_ID__c = String.valueof(account.vendorSiteId) + takedownID;
                            bankAccount.Contexto__c = account.attributeCategory;
                            bankAccount.TKD_tx_OraclebankId__c = String.valueOf(account.bankId);
                            bankAccount.Pago_a_Cuenta_Concentradora__c = account.attribute6;
                            bankAccount.Pago_a_Cta_Concentradora_RN__c =  account.attribute7;
                            listBankAccount.add(bankAccount);
                        }
                        if(site.contacts != null)
                        for(Takedown_Wrapper_DetSearchKnownSuppliers.Contact contact : site.contacts.contact){
                            Id ContactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Supplier Contact').getRecordTypeId();
                            Contact newContact = new Contact();
                            newContact.FirstName = contact.personFirstName;
                            newContact.LastName = contact.personLastName;
                            newContact.Phone = contact.phone;
                            newContact.Email = contact.emailAddress;
                            newContact.SR_tf_Phone_area_code__c = contact.areaCode;
                            newContact.RecordTypeId = ContactRecordTypeId;
                            newContact.inactiveDate__c = contact.inactiveDate;
                            newContact.TKD_Vendor_Site_ID__c = String.valueof(contact.vendorSiteId) + takedownID;
                            listContact.add(newContact);
                        }
                    } else {
                        system.debug('Se omitió un site ya que no coinciden los organization name');
                    }
                }    
            }            
        }  
        listSupplier = upsertSupplier(mapSuppliers);
        listSite = insertSite(listSupplier, listSite);
        insertAccount(listSite, listBankAccount);
        insertContact(listSite,listContact);
        return listSupplier;
    }
    public static list<Supplier__c> upsertSupplier(map<string,Supplier__c> mapSuppliers){
        list<Supplier__c> listSupplier = new list<Supplier__c>();
        listSupplier = mapSuppliers.values();
        Schema.SObjectField TKD_Vendor_ID = Supplier__c.Fields.TKD_Vendor_ID__c;
        list<Database.UpsertResult> resulOperation = Database.upsert(listSupplier, TKD_Vendor_ID, false);
        for(Database.UpsertResult upsertResult : resulOperation){
        	if (upsertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Supplier. ID: ' + upsertResult.getId());
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : upsertResult.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Supplier fields that affected this error: ' + err.getFields());
                }
            }    
        }
		return listSupplier;        
    }
    public static list<TKD_Site__c> insertSite(list<Supplier__c> listSupplier, list<TKD_Site__c> listSite){
        for(TKD_Site__c site : listSite){
            for(Supplier__c supplier : listSupplier){
                if(supplier.TKD_Vendor_ID__c.equals(site.TKD_Vendor_ID__c)){
                    site.Supplier__c = supplier.id;                    
                }    
            }
        }
        //list<Database.SaveResult> resulOperation = Database.insert(listSite, false );
        Schema.SObjectField TKD_Vendor_Site_ID = TKD_Site__c.Fields.TKD_Vendor_Site_ID__c;
        list<Database.UpsertResult> resulOperation = Database.upsert(listSite, TKD_Vendor_Site_ID, false );
        for(Database.UpsertResult upsertResult : resulOperation){
        	if (upsertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + upsertResult.getId());
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : upsertResult.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Site fields that affected this error: ' + err.getFields());
                }
            }    
        }
		return listSite;       
    }
    public static void insertAccount(list<TKD_Site__c> listSite,list<Bank_Account__c> listBankAccount){
        map<string, Bank_Account__c> mapBank_Account = new map<string, Bank_Account__c>();
        set<id> siteId = new set<id>();
        for(Bank_Account__c BankAccount : listBankAccount){
            for(TKD_Site__c Site : listSite){
                if(Site.TKD_Vendor_Site_ID__c.equals(BankAccount.TKD_Vendor_Site_ID__c)){
                    BankAccount.TKD_rb_Site__c = Site.Id; 
                    mapBank_Account.put(BankAccount.Name,BankAccount);     
                    siteId.add(Site.Id);
                }    
            }
        }
        for(Bank_Account__c Bank_Account : [SELECT Id, Name FROM Bank_Account__c 
                                            WHERE TKD_rb_Site__c in :siteId and Name in :mapBank_Account.keySet()]){
            mapBank_Account.remove(Bank_Account.Name);                                              
        }

        list<Database.SaveResult> resulOperation = Database.insert(mapBank_Account.values(), false );
        //list<Database.SaveResult> resulOperation = Database.insert(listBankAccount, false );
        for(Database.SaveResult insertResult : resulOperation){
        	if (insertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Bank Account. ID: ' + insertResult.getId());
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : insertResult.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Bank Account fields that affected this error: ' + err.getFields());
                }
            }    
        }        
    }
    public static void insertContact(list<TKD_Site__c> listSite, list<Contact> listContact){
        for(Contact contact : listContact){
            for(TKD_Site__c Site : listSite){
                if(Site.TKD_Vendor_Site_ID__c.equals(contact.TKD_Vendor_Site_ID__c)){
                    contact.TKD_rb_Site__c = Site.id;               
                }    
            }
        }
        list<Database.SaveResult> resulOperation = Database.insert(listContact, false );
        for(Database.SaveResult insertResult : resulOperation){
        	if (insertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Contact. ID: ' + insertResult.getId());
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : insertResult.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Contact fields that affected this error: ' + err.getFields());
                }
            }    
        }        
    }

    public static Supplier__c insertNonOracleSuppleir(string name, string rfc, id takedownID){
        Supplier_in_approval__c supplierInApproval = [SELECT id, Name, (Select id, Name, TKD_tx_Vat_Registration_Num__c from Suppliers__r) 
                                                    FROM Supplier_in_approval__c  
                                                        where TKD_rb_SupplierInApproval__c = :takedownID];
        boolean supplierAlredyCreated = false;
        for(Supplier__c supplier : supplierInApproval.Suppliers__r){
            if(supplier.TKD_tx_Vat_Registration_Num__c.equals(rfc)){
                supplierAlredyCreated = true;   
            }
        }
        Supplier__c newSupplier = new Supplier__c();
        if(!supplierAlredyCreated){
            newSupplier.name = name;
            newSupplier.TKD_tx_Vat_Registration_Num__c = rfc;  
            newSupplier.TKD_pd_Supplier_in_approval__c = supplierInApproval.id;
            newSupplier.TKD_un_oracleSupplier__c = 1;
            
            Database.SaveResult resulOperation = Database.insert(newSupplier, false );
                if (resulOperation.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted Site. ID: ' + resulOperation.getId());
                } else {
                    newSupplier = null;
                    // Operation failed, so get all errors                
                    for(Database.Error err : resulOperation.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Site fields that affected this error: ' + err.getFields());
                    }
                }
        }
        return newSupplier;  
    }

}