public with sharing class LMM_Controller_Takedown {
    
    public Takedowns_Contingency_plan__c Tkdparent      {get;set;}
    public string 		                 TkdId	        {get;set;}
    public  List<Supplier__c> SupplierinTkd {get;set;}
    public date fechaFT {get;set;}
    public string ownerName {get;set;}
    public string customerName {get;set;}
    public boolean validationRule {get;set;}
    public string dynamicContentType {get;set;}
    public final string contentTypeXLS = 'application/vnd.ms-excel#FormatoTesoreria.xls';

     public LMM_Controller_Takedown(ApexPages.StandardController stdController) {
        Takedowns_Contingency_plan__c Tkdparent = (Takedowns_Contingency_plan__c)stdController.getRecord();
        this.TkdId = Tkdparent.id;
        try{
            
             //this.TkdId =  (String)System.currentPageReference().getParameters().get('TkdId');
             CargaTakedown();
             CargaSuppliersTkd();
             this.ownerName = (this.Tkdparent.Owner.Name).toUpperCase();
             this.customerName = (this.Tkdparent.CPL_rb_Entity_Name_CP__r.Name).toUpperCase();
             this.fechaFT = Date.today();
                              
                               
        } Catch(Exception e){
                system.debug(e.getMessage());
            }
    }

    /*public LMM_Controller_Takedown(){
        
    }*/
     

        public void CargaTakedown(){
        try{
            this.Tkdparent = [Select Id,OwnerId,Owner.Name,CPL_rb_Entity_Name_CP__c,CPL_rb_Entity_Name_CP__r.Name,Name,
                                     CurrencyIsoCode,CPL_da_Funding_Date__c,TDAmount__c,CPL_ls_Operation_Unit__c,TKD_ls_takedown_stage__c
                                 FROM Takedowns_Contingency_plan__c  
                                 where Id =:this.TkdId][0];    
            //Valida el stage 
            if(string.isNotEmpty(this.Tkdparent.TKD_ls_takedown_stage__c) 
               && (!this.Tkdparent.TKD_ls_takedown_stage__c.equals('Canceled') 
                  )
              ){
                   this.dynamicContentType = this.contentTypeXLS;
                   this.validationRule = true;
              } else {
                  this.validationRule = false;
                  this.dynamicContentType = '';
              }
            
        }
            Catch(Exception e)
            {
                system.debug(e.getMessage());
            }
    }
    
    
        public void CargaSuppliersTkd(){
          this.SupplierinTkd = new list<Supplier__c>();
        try{ 
            this.SupplierinTkd =[Select Id, Name, CurrencyIsoCode,TKD_tx_Vendor_Name__c, TKD_tx_Vat_Registration_Num__c, TKD_tx_Supplier_Unique_ID__c, 
                                        TKD_pd_Supplier_in_approval__c,TKD_Monto_Invoice__c, 
                                        TKD_un_oracleSupplier__c,
                                       (Select Supplier__c, Tkd_ls_Org_Name__c, TKD_Vendor_Site_ID__c,TKD_Vat_code__c,
                                               CurrencyIsoCode, Name, Id from Sites__r),
                                       (SELECT Id,Name,LMM_nu_Total_assets_cost__c FROM Takedown_Invoices1__r)
                                from Supplier__c
                                where TKD_pd_Supplier_in_approval__r.TKD_rb_SupplierInApproval__c =:TkdId];
            
                        for(Supplier__c sp : SupplierinTkd){
                            
                            decimal suma =0;
                            for(Takedown_Invoice__c invoices : sp.Takedown_Invoices1__r){
                                suma +=invoices.LMM_nu_Total_assets_cost__c;
                            }
                            if(sp.Sites__r.size()>0 && sp.Sites__r.get(0).TKD_Vat_code__c.trim()=='AP_IVA_16'){
                                suma=suma*1.16;
                            }
                             
                            sp.TKD_Monto_Invoice__c = suma;
                        }
            
                          
        }

        Catch(Exception e)
        {
            System.debug(e.getMessage());
        }
            
    }
    
    
}