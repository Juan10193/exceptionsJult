/**
 * @File Name          : TKD_Supplier_TableAMLHits_controller.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 17/12/2019 16:31:59
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TKD_Supplier_TableAMLHits_controller {
    /*@AuraEnabled  
    public static  List<TKD_Site__c> getSuppliers(String recordId){
        system.debug('Inicia getSuppliers');
        //List<Supplier_in_approval__c> Supplier_in_approval = Data_Access_SupplierInApproval.getSupplierInApprovalByTkdID(recordId);
        Takedowns_Contingency_plan__c takedown = Data_Access_Takedowns_CP_cls.getAllFieldsByID(recordId);
        return Data_Access_site.getSitDataBysupplierInApprovalID(takedown.Suppliers_in_approval__r.get(0).id);
    }*/
    @AuraEnabled  
    public static  List<Supplier__c> getSuppliers(String recordId){ 
        system.debug('getSuppliers  recordId' + recordId);
        Takedowns_Contingency_plan__c takedown = Data_Access_Takedowns_CP_cls.getAllFieldsByID(recordId); 
        system.debug('takedown ' + takedown);
        system.debug('takedown.Suppliers_in_approval__r.get(0).id ' + takedown.Suppliers_in_approval__r.get(0).id);
        system.debug('Data_Access_Supplier.getSuppliersAndSitesByid(takedown.Suppliers_in_approval__r.get(0).id) ' + Data_Access_Supplier.getSuppliersAndSitesByid(takedown.Suppliers_in_approval__r.get(0).id));      
        return Data_Access_Supplier.getSuppliersAndSitesByid(takedown.Suppliers_in_approval__r.get(0).id);
    }
    @AuraEnabled  
    public static  List<Takedown_Invoice__c> getInvoicesBysupplierSetID(list<id> setRecordId){
        //List<Takedown_Invoice__c> invoices = Data_Access_Takedown_Invoice_cls.getInvoicesBySuplierID(setRecordId);
        system.debug('setRecordId ' + setRecordId);
        
        return Data_Access_Takedown_Invoice_cls.getInvoicesBySuplierID(setRecordId);
    }
    @AuraEnabled  
    public static void deleteSupplier(string recordId){
        /*list<Bank_Account__c> listBankAccount = new list<Bank_Account__c>();
        list<Contact> listContacts = new list<Contact>(); 
        for(TKD_Site__c sites : Data_Access_Site.getSitDataBysupplier(recordId)){
            for(Bank_Account__c bankAccount : sites.Bank_Accounts__r){
                listBankAccount.add(bankAccount);
            }   
            for(Contact contacto : sites.Contacts__r){
                listContacts.add(contacto);
            }
        }
        if(DMLO_Supplier.deletSupplier(recordId)){
            DMLO_Bank_Account.deleteBankAccount(listBankAccount);    
            DMLO_Contact.deleteContact(listContacts); 
        }*/
        Supplier__c supplier = new Supplier__c();
        TKD_Site__c Site = new TKD_Site__c();
        list<Bank_Account__c> listBankAccount = new list<Bank_Account__c>();
        list<Contact> listContacts = new list<Contact>(); 
        for(TKD_Site__c sites : Data_Access_Site.getSiteDataByid(recordId)){
            supplier.id = sites.Supplier__c;
            Site.id = sites.id;
            for(Bank_Account__c bankAccount : sites.Bank_Accounts__r){
                listBankAccount.add(bankAccount);
            }   
            for(Contact contacto : sites.Contacts__r){
                listContacts.add(contacto);
            }
        }
        supplier = Data_Access_Supplier.getSuppliersAndSitesBySuppid(supplier.id);
        //OJO, si burras un supplier se borran sus sites ya que tienen una conexión master detail en donde supplier es el padre
        //pero no se borran los bank account ni los contacts por que estos tienen una conexión look up por eso se realizan operaciones de borrado independiente
        //La siguiente condición indica, si vas a eliminar el último site, no tiene caso se que mantenga vivo el supplier, por ende, lo elimina junto con sus sites
        //Si el supplier aún le quedan varios sites, pues solo elimina el site indicado con sus respectivos bank account y contacts
        if(supplier.Sites__r.size() == 1){
            DMLO_Supplier.deletSupplier(supplier);
            //DMLO_Site.deleteSite(Site); 
            DMLO_Bank_Account.deleteBankAccount(listBankAccount);    
            DMLO_Contact.deleteContact(listContacts); 
        } else {
            DMLO_Site.deleteSite(Site);
            DMLO_Bank_Account.deleteBankAccount(listBankAccount);    
            DMLO_Contact.deleteContact(listContacts); 
        }
    }

}