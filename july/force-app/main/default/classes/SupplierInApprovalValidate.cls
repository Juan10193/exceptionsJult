public class SupplierInApprovalValidate {
	
    public void isAutoApprovable(Map<Id, Supplier_in_approval__c> newMapSupplierInaApproval, Map<Id, Supplier_in_approval__c>oldMapSupplierInaApproval ){
        Map<Id, Supplier_in_approval__c> supinapsApproved =New Map<Id, Supplier_in_approval__c>([SELECT Id,Dias_aprobado__c,Account_statement_date__c,Last_Approved_supplier_date__c,Suppliers_Approval_AMAG__c, (SELECT Id,Name, TKD_tx_Vat_Registration_Num__c FROM Suppliers__r) 
                                                FROM Supplier_in_approval__c WHERE  Dias_aprobado__c <180 AND Last_Approved_supplier_date__c =NULL ORDER BY Dias_aprobado__c ASC ]);
       
       list<Bank_Account__c> banks= [Select Id, TKD_rb_Site__r.Supplier__r.TKD_pd_Supplier_in_approval__c, Name,
                                                              Bank_Account_Currency__c, SR_tx_Country__c,SR_tx_Bank_Name__c,Tipo_BIC__c,
                                                 Codigo_BIC__c, SR_ls_Specific_intermediary_bank__c, Nombre_Banco_intermediadio__c,Tipo__c,
                                                 Codigo__c from Bank_Account__c 
                                                               where TKD_rb_Site__r.Supplier__r.TKD_pd_Supplier_in_approval__c IN:supinapsApproved.keySet()];
        
        Map<String, Datetime> RFCSApproved = new Map<String, Datetime>();

        if(supinapsApproved.size()>0){
            for (Id suppinAppId : supinapsApproved.keySet()) {
                for(Supplier__c supp: supinapsApproved.get(suppinAppId).Suppliers__r){
                    RFCSApproved.put(supp.TKD_tx_Vat_Registration_Num__c, supinapsApproved.get(suppinAppId).Account_statement_date__c );
                }
            }
        }
        
       
        set<Id> newSuppsInAppIds = new set<Id>();
       
        for(Id suppinAppId: newMapSupplierInaApproval.keySet() ){
            if(newMapSupplierInaApproval.get(suppinAppId).tkd_ls_Stage_Supplier__c=='IN PROCESS'
            && (oldMapSupplierInaApproval.get(suppinAppId).tkd_ls_Stage_Supplier__c =='NEW' || oldMapSupplierInaApproval.get(suppinAppId).tkd_ls_Stage_Supplier__c =='APPROVED' || oldMapSupplierInaApproval.get(suppinAppId).tkd_ls_Stage_Supplier__c =='REJECTED')){
                newSuppsInAppIds.add(suppinAppId);
            }
        }

        list<Supplier_in_approval__c> suppliersInAppsToValidate = [SELECT Id,Dias_aprobado__c,Account_statement_date__c,Last_Approved_supplier_date__c,Suppliers_Approval_AMAG__c, tkd_Auto_approve_suppliers__c, 
        (SELECT Id, TKD_tx_Vat_Registration_Num__c FROM Suppliers__r) FROM Supplier_in_approval__c WHERE Id IN:newSuppsInAppIds];
		
         list<Bank_Account__c> bankstovalidate= [Select Id, TKD_rb_Site__r.Supplier__r.TKD_pd_Supplier_in_approval__c, Name,
                                                              Bank_Account_Currency__c,SR_tx_Country__c,SR_tx_Bank_Name__c,Tipo_BIC__c,
                                                 Codigo_BIC__c, SR_ls_Specific_intermediary_bank__c, Nombre_Banco_intermediadio__c,Tipo__c,
                                                 Codigo__c
                                                 from Bank_Account__c 
                                                               where TKD_rb_Site__r.Supplier__r.TKD_pd_Supplier_in_approval__c IN:newSuppsInAppIds];
        
        List<Supplier_in_approval__c> autoApprovedSuppliers = new List<Supplier_in_approval__c>();
		set<id> cominos = new set<id>();
        if(suppliersInAppsToValidate.size()>0){
            for (Supplier_in_approval__c suppInApp : suppliersInAppsToValidate) {
                Boolean autoApproved = true;
                Datetime lastAutoApprovedDate;
    
                for (Supplier__c supp : suppInApp.Suppliers__r) {
                    if(!RFCSApproved.keySet().contains(supp.TKD_tx_Vat_Registration_Num__c)){ autoApproved = false;}
                    else{
                        suppInApp.Last_Approved_supplier_date__c = RFCSApproved.get(supp.TKD_tx_Vat_Registration_Num__c);
                        for (Bank_Account__c bnkovalidate:bankstovalidate){
                            if(bnkovalidate.TKD_rb_Site__r.Supplier__r.TKD_pd_Supplier_in_approval__c == suppInApp.Id){
                                set<Id>coincidences = new set<Id>();
                                for(Bank_Account__c bnkCompare:banks){
                                    if(bnkCompare.Name==bnkovalidate.Name && bnkCompare.Bank_Account_Currency__c ==bnkovalidate.Bank_Account_Currency__c && bnkCompare.SR_tx_Country__c == bnkovalidate.SR_tx_Country__c && bnkCompare.SR_tx_Bank_Name__c == bnkovalidate.SR_tx_Bank_Name__c && bnkCompare.Tipo_BIC__c == bnkovalidate.Tipo_BIC__c && bnkCompare.Codigo_BIC__c == bnkovalidate.Codigo_BIC__c && bnkCompare.Tipo__c == bnkovalidate.Tipo__c && bnkCompare.Codigo__c ==bnkovalidate.Codigo__c ){
                                        coincidences.add(bnkCompare.Id);
                                    }
                                }
                                if(coincidences.size() ==0){autoApproved = false; suppInApp.Last_Approved_supplier_date__c = null;}
                            }
                        }
                       
                    }
                }
                
                
                
                if(autoApproved){
        			suppInApp.tkd_Auto_approve_suppliers__c = autoApproved;
                    suppInApp.Supplier_sent__c = true;
                	autoApprovedSuppliers.add(suppInApp);
                    cominos.add(suppInApp.Id);
                }
                
            }
        }

        if(autoApprovedSuppliers.size()>0){
            update autoApprovedSuppliers;
            if(cominos.size()>0){
            	TKD_SaveSuppliersORA.saveSuppliers(cominos);
            }
            
        }
    }
}