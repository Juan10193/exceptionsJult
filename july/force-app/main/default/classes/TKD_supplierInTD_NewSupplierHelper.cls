/**
 * @File Name          : TKD_supplierInTD_NewSupplierHelper.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 1/4/2020 2:01:33
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    17/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TKD_supplierInTD_NewSupplierHelper {
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

    public Supplier_in_approval__c supplierInApproval {get;set;}
    public TKD_supplierInTD_NewSupplierWrapper.Supplier supplierDetail {get;set;} 
    public id takedownID {get;set;}

    public map<string,string> mapApiLabelSupplierNationality {get;set;}
    public map<string,string> mapApiLabelSupplierThirdPartyType {get;set;}
    public map<string,string> mapApiLabelSupplierResidenceCountry {get;set;}

    public map<string,string> mapApiLabelSiteCountry {get;set;}
    public map<string,string> mapApiLabelSiteState {get;set;}
    public map<string,string> mapApiLabelSiteCurrencyISOCode {get;set;}

    public list<string> listErrors                      {get;set;}
    public list<Supplier__c> listSupplierRollBack        {get;set;}
    public list<Bank_Account__c> listBankAccountRollBack {get;set;} 
    public list<Contact> listContactRollBack             {get;set;} 
    
    
    
    public TKD_supplierInTD_NewSupplierHelper(id takedownID, TKD_supplierInTD_NewSupplierWrapper.Supplier supplierDetail){
    	this.supplierInApproval = [SELECT id FROM Supplier_in_approval__c where TKD_rb_SupplierInApproval__c = :takedownID];    
    	this.supplierDetail = supplierDetail;
        this.takedownID = takedownID;
        
        this.mapApiLabelSupplierNationality = mapSupplierNationality();
        this.mapApiLabelSupplierThirdPartyType = mapSupplierThirdPartyType();
        this.mapApiLabelSupplierResidenceCountry = mapSupplierResidenceCountry();
        this.mapApiLabelSiteCurrencyISOCode = mapSiteCurrencyISOCode();

        this.mapApiLabelSiteCountry = mapCountry(); 
        this.mapApiLabelSiteState = mapSiteState();

        this.listErrors = new list<string>();
        this.listSupplierRollBack = new list<Supplier__c>();
        this.listBankAccountRollBack = new list<Bank_Account__c>();
        this.listContactRollBack = new list<Contact>();

    }
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @return Supplier__c 
    **/
    public Supplier__c insertSupplier(){
        Supplier__c supplier = new Supplier__c();
        supplier.Name = this.supplierDetail.Name;
        supplier.TKD_tx_Vendor_name_alternative__c = this.supplierDetail.TKD_tx_Vendor_name_alternative;
        supplier.TKD_tx_Vat_Registration_Num__c = this.supplierDetail.TKD_tx_Vat_Registration_Num;
        supplier.TKD_tx_Supplier_Unique_ID__c = this.takedownID + this.supplierDetail.TKD_tx_Vat_Registration_Num;
        supplier.TKD_pd_Supplier_in_approval__c = this.supplierInApproval.id; 
        //supplier.TKD_ls_Tipo_de_tercero__c = this.mapApiLabelSupplierThirdPartyType.get(this.supplierDetail.TKD_ls_Tipo_de_tercero); 
        //supplier.Nacionalidad__c = this.mapApiLabelSupplierNationality.get(this.supplierDetail.Nacionalidad); 
        //supplier.TKD_ls_Pais_de_residencia__c = this.mapApiLabelSupplierResidenceCountry.get(this.supplierDetail.TKD_ls_Pais_de_residencia); 
        //supplier.Categoria__c = 'DIOT';
        if(supplier.Name =='' || supplier.TKD_tx_Vat_Registration_Num__c=='' || supplier.TKD_tx_Vendor_name_alternative__c==''){
            throw new OtherException('Error in insert Supplier: Please fill Name, Vendor Name Alt and Vat Registration Num');
        }
        Database.SaveResult resulOperation = Database.insert(supplier, true );
       	if (resulOperation.isSuccess()) {
        	// Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully inserted Supplier. ID: ' + resulOperation.getId());
            Supplier__c newSupplier = new Supplier__c(id=resulOperation.getId());
            listSupplierRollBack.add(newSupplier);
        } else {
        	// Operation failed, so get all errors                
            for(Database.Error err : resulOperation.getErrors()) {
                listErrors.add(err.getMessage());
            	System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Supplier fields that affected this error: ' + err.getFields());
                throw new OtherException('Error in insert Supplier' + err.getMessage());
            }
        }    
     
        return supplier;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @param Supplier__c supplier 
    * @return map<TKD_supplierInTD_NewSupplierWrapper.Site, TKD_Site__c> 
    **/
    public map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c> insertSites(Supplier__c supplier){
        map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c> mapSiteSiteWrapper = new map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c>(); 
        
        for(TKD_supplierInTD_NewSupplierWrapper.Site site : supplierDetail.sites){
        	TKD_Site__c newSite = new TKD_Site__c();
            newSite.Tkd_at_Address_line_1__c = site.Tkd_at_Address_line_1;
            newSite.Tkd_at_Address_line_2__c = site.Tkd_at_Address_line_2;
            newSite.TKD_tx_Country__c = this.mapApiLabelSiteCountry.get(site.TKD_tx_Country);
            newSite.Tkd_ls_Org_Name__c = site.Tkd_ls_Org_Name;
            newSite.tkd_tf_phone__c = site.tkd_tf_phone;
            newSite.Tkd_tx_City__c = site.Tkd_tx_City;
            newSite.TKD_ls_State__c = this.mapApiLabelSiteState.get(site.TKD_ls_State);
            newSite.Tkd_tx_Zip__c = site.Tkd_tx_Zip;
            newSite.TKD_Vat_code__c = site.TKD_Vat_code;
            //newSite.Pay_Site_Flag__c = site.Pay_Site_Flag;
            //newSite.primaryPaySiteFlag__c = site.primaryPaySiteFlag;
            newSite.Name = site.Name;
            newSite.CurrencyIsoCode = this.mapApiLabelSiteCurrencyISOCode.get(site.currencyIso);
            newSite.Supplier__c = supplier.id;
            mapSiteSiteWrapper.put(site,newSite);  
        }
        list<Database.SaveResult> resulOperation = Database.insert(mapSiteSiteWrapper.values(), true );
        for(Database.SaveResult insertResult : resulOperation){
        	if (insertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Site. ID: ' + insertResult.getId());
                
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : insertResult.getErrors()) {
                    listErrors.add(err.getMessage());
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Site fields that affected this error: ' + err.getFields());
                }
            }    
        } 
     
        return mapSiteSiteWrapper;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @param map<TKD_supplierInTD_NewSupplierWrapper.Site TKD_Site__c> mapSiteSiteWrapper 
    * @return void 
    **/
    public void insertContact(map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c> mapSiteSiteWrapper){
        Id ContactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Supplier Contact').getRecordTypeId();
        list<Contact> listContact = new list<Contact>();
        for(TKD_supplierInTD_NewSupplierWrapper.Site site : mapSiteSiteWrapper.keySet()){
            if(site.supplierContact != null)
                for(TKD_supplierInTD_NewSupplierWrapper.SupplierContact supplierContact : site.supplierContact){
                    Contact newContact = new Contact();
                    newContact.FirstName = supplierContact.firstName;
                    newContact.LastName = supplierContact.lastName;
                    newContact.Phone = supplierContact.Phone;
                    newContact.Email = supplierContact.emailAddress;
                    newContact.RecordTypeId = ContactRecordTypeId;
                    newContact.TKD_rb_Site__c = mapSiteSiteWrapper.get(site).id;
                    listContact.add(newContact);                     
                }        	            
        }
       	list<Database.SaveResult> resulOperation = Database.insert(listContact, false );
        for(Database.SaveResult insertResult : resulOperation){
        	if (insertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted Contact. ID: ' + insertResult.getId());
                Contact cont = new Contact(id=insertResult.getId());
                listContactRollBack.add(cont);
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : insertResult.getErrors()) {
                    listErrors.add(err.getMessage());
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Contact fields that affected this error: ' + err.getFields());
                }
            }    
        }
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @param map<TKD_supplierInTD_NewSupplierWrapper.Site TKD_Site__c> mapSiteSiteWrapper 
    * @return void 
    **/
    public void insertBankAccount(map<TKD_supplierInTD_NewSupplierWrapper.Site,TKD_Site__c> mapSiteSiteWrapper){
        Id BankAccountRecordTypeId = Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName().get('Supplier Account').getRecordTypeId();
        list<Bank_Account__c> listBankAccount = new list<Bank_Account__c>();
        for(TKD_supplierInTD_NewSupplierWrapper.Site site : mapSiteSiteWrapper.keySet()){
            if(site.bankAccount != null)
                for(TKD_supplierInTD_NewSupplierWrapper.BankAccount supplierBankAccount : site.bankAccount){                    
                    Bank_Account__c bankAccount = new Bank_Account__c(); 
                    bankAccount.Bank_Name__c = supplierBankAccount.Bank_Name;
                    bankAccount.Bank_Account_Currency__c = supplierBankAccount.Bank_Account_Currency;
                    bankAccount.name = supplierBankAccount.Name;
                    bankAccount.Bank_Account_Name__c = String.valueof(supplierBankAccount.Bank_Account_Name);       
                    bankAccount.RecordTypeId = BankAccountRecordTypeId;
                    bankAccount.TKD_rb_Site__c = mapSiteSiteWrapper.get(site).id;
                    bankAccount.Contexto__c = supplierBankAccount.Contexto;
                    bankAccount.Tipo_BIC__c = supplierBankAccount.Tipo_BIC;
                    bankAccount.Codigo_BIC__c = supplierBankAccount.Codigo_BIC;
                    bankAccount.Nombre_Banco_intermediadio__c = supplierBankAccount.Nombre_Banco_intermediadio;
                    bankAccount.Tipo__c = supplierBankAccount.Tipo;
                    bankAccount.Codigo__c = supplierBankAccount.Codigo;
                    //bankAccount.Pago_a_Cuenta_Concentradora__c = supplierBankAccount.Pago_a_Cuenta_Concentradora;
                    //bankAccount.Pago_a_Cta_Concentradora_RN__c = supplierBankAccount.Pago_a_Cta_Concentradora_RN;
                    listBankAccount.add(bankAccount);                     
                }        	            
        }
           list<Database.SaveResult> resulOperation = Database.insert(listBankAccount, true );
        for(Database.SaveResult insertResult : resulOperation){
        	if (insertResult.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted bankAccount. ID: ' + insertResult.getId());
                Bank_Account__c newBankAccount = new Bank_Account__c(id=insertResult.getId());
                listBankAccountRollBack.add(newBankAccount);
            } else {
                // Operation failed, so get all errors                
                for(Database.Error err : insertResult.getErrors()) {
                    listErrors.add(err.message);
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Bank Account fields that affected this error: ' + err.getFields());
                }
            }    
        }
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @return map<string, string> 
    **/
    public static map<string,string> mapCountry(){
        system.debug(LoggingLevel.INFO, 'Inicia mapCountry');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.TKD_tx_Country__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapApiLabelSiteCountry = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapApiLabelSiteCountry.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapApiLabelSiteCountry;
    }
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 17/12/2019 
    * @return map<string, string> 
    **/
    public static map<string,string> mapSiteState(){
        system.debug(LoggingLevel.INFO, 'Inicia mapSiteState');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.TKD_ls_State__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapApiLabelSiteState = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapApiLabelSiteState.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapApiLabelSiteState;
    }
   
    public static map<string,string> mapSupplierNationality(){
        system.debug(LoggingLevel.INFO, 'Inicia mapSupplierNationality');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Supplier__c.Nacionalidad__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapApiLabelSupplierNationality = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapApiLabelSupplierNationality.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapApiLabelSupplierNationality;
    }
    public static map<string,string> mapSupplierThirdPartyType(){
        system.debug(LoggingLevel.INFO, 'Inicia mapSupplierThirdPartyType');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Supplier__c.TKD_ls_Tipo_de_tercero__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapApiLabelSupplierThirdPartyType = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapApiLabelSupplierThirdPartyType.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapApiLabelSupplierThirdPartyType;
    }
    public static map<string,string> mapSupplierResidenceCountry(){
        system.debug(LoggingLevel.INFO, 'Inicia mapSupplierResidenceCountry');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Supplier__c.TKD_ls_Pais_de_residencia__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapApiLabelSupplierResidenceCountry = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapApiLabelSupplierResidenceCountry.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapApiLabelSupplierResidenceCountry;
    }
    public static map<string,string> mapSiteCurrencyISOCode(){
        system.debug(LoggingLevel.INFO, 'Inicia mapSiteCurrencyISOCode');
        List<String> pickListValuesList = new List<String>();
        Schema.DescribeFieldResult fieldResult = TKD_Site__c.CurrencyIsoCode.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string,string> mapCurrencyISOCode = new map<string,string>();
        for( Schema.PicklistEntry pickListVal : ple){
            mapCurrencyISOCode.put(pickListVal.getLabel(),pickListVal.getValue());
            System.debug('Values in getValue: '+pickListVal.getValue());
            System.debug('Values in getLabel: '+pickListVal.getLabel());
        }  
        return mapCurrencyISOCode;
    }


    

}