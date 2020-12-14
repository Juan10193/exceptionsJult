public class Takedown_Controller_modalInvoice {
     @AuraEnabled  
    public static  void onSaveInvoice(String recordId,String idSupplierSelect ,String rfcSupplierSelect, String nameSupplierSelect,  List<Takedown_Invoice__c> lstInvoicesSelected){
        System.debug('::::: Metodo OnSaveInvoice Mod :::::');
        System.debug('lstInvoicesSelected INV: '+ lstInvoicesSelected);
        System.debug('recordId  : '+ recordId);
        System.debug('idSupplierSelect  : '+ idSupplierSelect);
        System.debug('rfcSupplierSelect : '+ rfcSupplierSelect);
        System.debug('nameSupplierSelect : '+ nameSupplierSelect);
        
        updateInvoices(rfcSupplierSelect,recordId);

        List<Takedown_Invoice__c>  lstInvoiceUpdate = lstInvoicesSelected;
        System.debug('lstInvoiceUpdate ' + lstInvoiceUpdate);        
        for(Takedown_Invoice__c invoice : lstInvoiceUpdate){
            invoice.Id = invoice.Id; 
            invoice.TKD_txt_RFC__c = rfcSupplierSelect;
            invoice.TKD_tx_Supplier_name__c = nameSupplierSelect;
            invoice.TKD_rb_Supplier__c= idSupplierSelect; 
            System.debug('lstInvoiceUpdate: '+ lstInvoiceUpdate);
        }

        try {
            upsert lstInvoiceUpdate;
            System.debug('Se actualizo con exito Lista Actuaalizada: '+ lstInvoiceUpdate );
        } catch (DmlException e) {
            System.debug('Ocurrio un error en el metodo: updateStatusSupplier' + e);
        }  
    }
    
    @AuraEnabled
    public static void updateInvoices(String rfcSupplierSelect, String recordId ){
        List<Takedown_Invoice__c> lstInvoices = [SELECT Id,TKD_txt_RFC__c,TKD_tx_Supplier_name__c, TKD_rb_Supplier__c FROM Takedown_Invoice__c where TKD_pd_Takedown_CP__c=: recordId and  TKD_txt_RFC__c=: rfcSupplierSelect];
        System.debug('lstInvoices:' + lstInvoices );
        for( Takedown_Invoice__c inv : lstInvoices ){
            inv.Id = inv.Id; 
            inv.TKD_txt_RFC__c = null;
            inv.TKD_tx_Supplier_name__c = null;
            inv.TKD_rb_Supplier__c = null;           
        }
         try {
            upsert lstInvoices;
            System.debug('Se actualizo con exito: '+ lstInvoices );
        } catch (DmlException e) {
            System.debug('Ocurrio un error en el metodo: updateInvoices' + e);
        }          
    }
    
    @AuraEnabled  
    public static  List<Takedown_Supplier_Site> getAllSupplierTblAmlHits(String recordId){
        return Takedown_Controller_tableAmlHits.getAllSupplierTblAmlHits(recordId);
    }

}