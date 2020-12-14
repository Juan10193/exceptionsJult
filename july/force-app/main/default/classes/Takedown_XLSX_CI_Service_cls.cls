public class Takedown_XLSX_CI_Service_cls {
    public Takedown_Wrapper_Contract_Import_cls.Contract_Import makeContractImport(id TakedownId){
        system.debug(LoggingLevel.INFO,'Inicia makeContractImport');
        Takedowns_Contingency_plan__c takedownCP  = Data_Access_WOS_Takedowns_CP_cls.getAllFields(TakedownId);  
        List<Asset> listTakedownInvoices = Data_Access_Assets_cls.getAssetsByTakedownId(takedownCP.id);
        SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper = new SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields(); 
        Takedown_Wrapper_Contract_Import_cls.Contract_Import contractImport = new Takedown_Wrapper_Contract_Import_cls.Contract_Import(); 
        if(TakedownCP.Annex_Pricing_SuperTrump__c != null){
        	pricing_Quote_Wrapper = Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(TakedownCP.Annex_Pricing_SuperTrump__c);
            set<id> setRentID = new set<id>();
            for(IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields rentWrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper){
            	setRentID.add(rentWrapper.recordID);    
            }
            
            set<id> setLoanID = new set<id>();
            for(IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields loanWrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper){
            	setLoanID.add(loanWrapper.recordID);    
            }
            pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper = Data_Access_WOS_IST_ST_PQ_Rent_cls.getAllFieldsBySetID(setRentID);
            pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper = Data_Access_WOS_IST_ST_PQ_Loan_cls.getAllFieldsBySetID(setLoanID);
        
        
        
        contractImport.listHeaders = getHeaderData(takedownCP,pricing_Quote_Wrapper);
        List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields = getFeeData(pricing_Quote_Wrapper);
        contractImport.listLines = getLinesData(listLinesFields, listTakedownInvoices,pricing_Quote_Wrapper,takedownCP);
        //contractImport.listLines = putContractNumber(contractImport.listLines);
        getPayments(contractImport.listLines, pricing_Quote_Wrapper);
        contractImport.listLines = putContractNumber(contractImport.listLines);
            
        }
        system.debug('pudo');
        return contractImport;
        
    }
    public List<Takedown_Wrapper_Contract_Import_cls.Headers> getHeaderData(Takedowns_Contingency_plan__c takedownCP, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper){
    	List<Takedown_Wrapper_Contract_Import_cls.Headers> listHeaderFields = new List<Takedown_Wrapper_Contract_Import_cls.Headers>();
        Takedown_Wrapper_Contract_Import_cls.Headers Headers = new Takedown_Wrapper_Contract_Import_cls.Headers();
        	Headers.CONTRACT_NUMBER				= '1';
        	Headers.LEGAL_ENTITY				= Takedown_XLS_CI_Helper_cls.getLegalEntity(takedownCP.CPL_ls_Operation_Unit__c);
        	Headers.OPERATING_UNIT				= takedownCP.CPL_ls_Operation_Unit__c;
            Headers.CONTRACT_DESCRIPTION 		= takedownCP.name;
            Headers.CURRENCY_CODE 				= takedownCP.CurrencyIsoCode;
            Headers.CURRENCY_CONVERSION_DATE 	= Takedown_XLS_CI_Helper_cls.dateToStringFormatDate(date.valueof(takedownCP.CreatedDate));
            Headers.CURRENCY_CONVERSION_TYPE	= 'User';
            Headers.CURRENCY_CONVERSION_RATE	= takedownCP.CPL_nu_TD_Echange_Rate__c;
        	Headers.TERM 						= Pricing_Quote_Wrapper.IST_Term;
        	Headers.EFFECTIVE_FROM				= Takedown_XLS_CI_Helper_cls.stringToStringFormatDate(getEffectiveFrom(pricing_Quote_Wrapper));
        	Headers.EXPECTED_DELIVERY_DATE		= Headers.EFFECTIVE_FROM;
        	Headers.ACCEPTANCE_DATE				= Headers.EFFECTIVE_FROM;
        	Headers.DATE_SIGNED					= Headers.EFFECTIVE_FROM;
        	Headers.LEGACY_NUMBER				= takedownCP.CPL_tx_OLFM_Contract_Number__c;
        	Headers.SALES_REP					= takedownCP.CLI_rb_Inside_Sales_Owner__r.name;
        	Headers.CUSTOMER_PO					= 'x';
        	Headers.CONTRACT_TEMPLATE			= Takedown_XLS_CI_Helper_cls.getContractTemplate(takedownCP.CPL_ls_Product__c);
        	//Headers.FINANCE_PRODUCT				=
        	Headers.CUSTOMER_NAME 				= takedownCP.Customer_Name__r.name;
        	//Headers.BILL_TO_SITE_LOCATION		=
        	Headers.LINEA_DE_NEGOCIO			= takedownCP.Line_of_Business__c;
        	Headers.NUMERO_DEL_DOCUMENTO_LEGAL	= takedownCP.Contract_Annex_Number__c;
        	Headers.YIELD						= Pricing_Quote_Wrapper.BookYield;
        	Headers.PRODUCTO					= takedownCP.CPL_ls_Product__c;
        	//Headers.CALIFICATION_DE_CREDITO
        	//Headers.NUMERO_DE_ACTA
        	//Headers.FECHA_DE_LA_NOTARIA
        	//Headers.EVERGREEN_ELIGIBLE_FLAG
        	//Headers.EARLY_TERMINATION_PURCHASE_AMOUNT
        	//Headers.END_OF_TERM_PURCHASE_AMOUNT
        	//Headers.INSURANCE_POLICY_NUMBER
        	//Headers.QUOTE_EFFECTIVE_FROM
        	//Headers.QUOTE_EFFECTIVE_TO
        	//Headers.INSURANCE_EFFECTIVE_FROM
        	//Headers.LOCATION
        	//Headers.LESSOR_INSURED
        	//Headers.LESSOR_PAYEE
        	//Headers.INSURANCE_PROVIDER
        	//Headers.INSURANCE_PAYMENT_FREQUENCY
        	//Headers.INSURANCE_TERM
        	//Headers.INSURANCE_ADJUSTMENT
        	//Headers.INSURANCE_SALESPERSON
        	//Headers.MULTI_ANNUAL_POLICY
        	//Headers.CONTRACT_IMPORT_STATUS
        	//Headers.PREFUNDING_YN
        	//Headers.VAR_INDEX_NAME
        	//Headers.VAR_BASE_RATE
        	//Headers.VAR_ADDR_RATE
        	//Headers.DAYS_IN_YEAR
        	//Headers.DAYS_IN_MONTH
        system.debug('Headers ' + Headers);
        listHeaderFields.add(Headers);
        return listHeaderFields;
    }
    public List<Takedown_Wrapper_Contract_Import_cls.Lines> getFeeData(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper){        
        List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields = new List<Takedown_Wrapper_Contract_Import_cls.Lines>();
        try{
            
        
        for(IST_SP_PQ_Expense_Fee_Wrapper_cls.query_All_Fields Expense_Fee : pricing_Quote_Wrapper.list_SP_PQ_Expense_Fee_Wrapper){
            if(Expense_Fee.IST_Amount > 0){
            	Takedown_Wrapper_Contract_Import_cls.Lines newLine = new Takedown_Wrapper_Contract_Import_cls.Lines();
                //Takedown_Wrapper_Contract_Import_cls.SuperTrump_FEE SuperTrump_FEE = new Takedown_Wrapper_Contract_Import_cls.SuperTrump_FEE();
                newLine.FEE_NAME = Expense_Fee.IST_Description;
                newLine.FEE_TYPE = 'EXPENSE';
                newLine.FEE_AMOUNT = String.valueof(Expense_Fee.IST_Amount);
                listLinesFields.add(newLine);    
            }  
        }
            //for(IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields Income_Fee : Data_Access_WOS_IST_SP_PQ_Income_Fee.getIncome_FeeByPQ(this.TakedownCP.Annex_Pricing_SuperTrump__c)){
            for(IST_ST_PQ_Income_Fee_Wrapper_cls.query_All_Fields Income_Fee : pricing_Quote_Wrapper.list_IST_ST_PQ_Income_Fee_Wrapper){
                if(Income_Fee.IST_Amount > 0){
                	Takedown_Wrapper_Contract_Import_cls.Lines newLine = new Takedown_Wrapper_Contract_Import_cls.Lines();
                    newLine.FEE_NAME = Income_Fee.IST_Description;
                    newLine.FEE_TYPE = 'INCOME';
                    newLine.FEE_AMOUNT = String.valueof(Income_Fee.IST_Amount);
                    listLinesFields.add(newLine);      
                }                              
            }
            //for(ST_PQ_Specified_Security_Deposit__c Specified_Security_Deposit : Data_Access_WOS_Spe_Security_Deposit.getSpe_Security_Deposit(this.TakedownCP.Annex_Pricing_SuperTrump__c)){
            for(ST_PQ_SSDeposit_Wrapper_cls.query_All_Fields Specified_Security_Deposit : pricing_Quote_Wrapper.list_ST_PQ_SSDeposit_Wrapper){
                if(Specified_Security_Deposit.Amount > 0){
                	Takedown_Wrapper_Contract_Import_cls.Lines newLine = new Takedown_Wrapper_Contract_Import_cls.Lines();
                    newLine.FEE_NAME = Specified_Security_Deposit.Name;
                    newLine.FEE_TYPE = 'SECURITY DEPOSIT';
                    newLine.FEE_AMOUNT = String.valueof(Specified_Security_Deposit.Amount);
                    listLinesFields.add(newLine);    
                }                 
        }
            }catch(Exception e){
            system.debug('e ' + e);
                system.debug('e ' + e.getLineNumber());
        }
		return listLinesFields;        
    }   
    public List<Takedown_Wrapper_Contract_Import_cls.Lines> getLinesData(List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields, List<Asset> listTakedownInvoices, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper, Takedowns_Contingency_plan__c takedownCP){    
        integer cont = 0;
        for(Asset activo : listTakedownInvoices){
            for(integer i=0 ; i<activo.Quantity ;i++){
                cont = cont+1;
                Takedown_Wrapper_Contract_Import_cls.Lines newLine = new Takedown_Wrapper_Contract_Import_cls.Lines();
                newLine.CONTRACT_NUMBER 		= '1';
                //newLine.FEE_NAME 
                //newLine.FEE_TYPE  
                //newLine.FEE_AMOUNT         
                newLine.ASSET_NUMBER 			= String.valueof(cont); 
                newLine.ASSET_DESCRIPTION 		= Takedown_XLS_CI_Helper_cls.removeDoubleQuotationMarks(activo.description); 
                //newLine.CURRENCY_CONVERSION_TYPE 
                newLine.SERIAL_NUMBER 			= Takedown_XLS_CI_Helper_cls.removeDoubleQuotationMarks(activo.SerialNumber);
                newLine.ITEM_NUMBER 			= ''; 
                //newLine.ASSET_USAGE_FOR_TAX               
                newLine.UNITS 					= String.valueof(integer.valueof(activo.Quantity));
                newLine.UNIT_COST 				= activo.TDK_dv_Unit_cost__c;
                newLine.MODEL 					= Takedown_XLS_CI_Helper_cls.removeDoubleQuotationMarks(activo.TKD_tx_Model__c);
                newLine.MANUFACTURER 			= Takedown_XLS_CI_Helper_cls.removeDoubleQuotationMarks(activo.TKD_tx_brand__c); 
                newLine.YEAR_OF_MANUFACTURE 	= activo.TKD_tx_model_year__c; 
                newLine.EXPECTED_FUNDING_DATE 	= Takedown_XLS_CI_Helper_cls.dateToStringFormatDate(takedownCP.CPL_da_Funding_Date__c); 
                newLine.IN_SERVICE_DATE 		= String.valueof(activo.TKD_fh_real_delivery_date__c);         
                newLine.RESIDUAL_AMOUNT 		= String.valueof(pricing_Quote_Wrapper.Residual_Value);
                newLine.GUARANTOR 				= pricing_Quote_Wrapper.Residual_Guarantee_Type; 
                newLine.GUARNTEED_AMOUNT 		= String.valueof(pricing_Quote_Wrapper.Total_Residual_Guaranteed_Amount);
                //newLine.SUPPLIER 				= activo.TKD_rb_takedown_Invoice__r.TKD_rb_Supplier__r.TKD_at_name__c; 
                //newLine.SUPPLIER_SITE 
                newLine.SUPPLIER_INVOICE 		= String.valueof(activo.TKD_rb_takedown_Invoice__r.name);
                //newLine.SUPPLIER_INVOICE_DATE 	= String.valueof(Takedown_XLS_CI_Helper_cls.dateToStringFormatDate(activo.TKD_rb_takedown_Invoice__r.createddate));
                newLine.VEHICLE_IDENTIFIER 		= activo.TKD_tx_plates__c; 
                newLine.IMPORT_DATE 			= String.valueOf(activo.TKD_fh_imported_on__c);
                //newLine.IMPORT_CERTIFICATE 
                //newLine.SHIPPING_NUMBER         
                //newLine.INVOICE_DESCRIPTION 
                //newLine.IMPORT_ADDRESS 
                //newLine.IMPORT_INVOICE 
                //newLine.SHIPPING_NAME 
                //newLine.INSTALL_AT_SITE_LOCATION  
                //newLine.FIXED_ASSETS_LOCATION                
                /*newLine.SUBSIDY_NAME 
                newLine.SUBSIDY_AMOUNT 
                newLine.INSURANCE_REBATE_AMOUNT 
                newLine.DOWNPAYMENT_RECEIVER_CODE 
                newLine.CAPITALIZE_DOWN_PMT 
                newLine.DOWNPAYMENT_AMOUNT        
                newLine.INTERIM_RENT_START_DATE 
                newLine.INTERIM_RENT_AMOUNT */
                newLine.PAYMENT_FREQUENCY 		= activo.TKD_tx_payment_frecuency__c;
                newLine.PAYMENT_ORDER 			= activo.TKD_tx_payment_order__c; 
                newLine.PERIOD 					= activo.TKD_tx_period__c;
                //newLine.PAYMENT_AMOUNT = String.valueof(activo.TKD_dv_payment_amount__c);
                newLine.ARREARS_FLAG  			= activo.TKD_tx_arrears__c;
                newLine.PAYMENT_TYPE 			= activo.TKD_tx_payment_type__c;
               /* newLine.EVERGREEN_PERIOD         
                newLine.EVERGREEN_FREQUENCY 
                newLine.EVERGREEN_AMOUNT */
                listLinesFields.add(newLine);
                
            }
            
            
        }
        return listLinesFields;
    }
    public List<Takedown_Wrapper_Contract_Import_cls.Lines> getPayments(List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper){
        //paso uno, cuenta los activos
        integer paymentOrder = 0;
        if(pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper.size() > 0){
        	for(IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields ST_PQ_Rent_Wrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper){
                for(ST_PQ_Rent_CFS_Wrapper_cls.query_All_Fields PQ_Rent_CFS_Wrapper : ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_CFS_Wrapper){
                    if(PQ_Rent_CFS_Wrapper.Num_Pmts != null || PQ_Rent_CFS_Wrapper.Num_Pmts > 0){
                        paymentOrder = paymentOrder +1;
                    	listLinesFields = assetLevelComputation(listLinesFields, PQ_Rent_CFS_Wrapper.Num_Pmts, PQ_Rent_CFS_Wrapper.Amount, paymentOrder, PQ_Rent_CFS_Wrapper.Period, PQ_Rent_CFS_Wrapper.Timing);    
                    }  
                }    
            }
        } else if(pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper.size() > 0){
            for(IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields ST_PQ_Loan_Wrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper){
                for(ST_PQ_Loan_CFS_Wrapper_cls.query_All_Fields PQ_Loan_CFS_Wrapper : ST_PQ_Loan_Wrapper.list_ST_PQ_Loan_CFS_Wrapper){
                	if(PQ_Loan_CFS_Wrapper.Num_Pmts != null || PQ_Loan_CFS_Wrapper.Num_Pmts > 0){
                        paymentOrder = paymentOrder +1;
                        listLinesFields = assetLevelComputation(listLinesFields, PQ_Loan_CFS_Wrapper.Num_Pmts, PQ_Loan_CFS_Wrapper.Amount, paymentOrder, PQ_Loan_CFS_Wrapper.Period, PQ_Loan_CFS_Wrapper.Timing);        
                    }
                }    
            }
            
        }
        return listLinesFields;        
    }
    public List<Takedown_Wrapper_Contract_Import_cls.Lines> putContractNumber(List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields){ 
        for(Takedown_Wrapper_Contract_Import_cls.Lines line : listLinesFields){
        	line.CONTRACT_NUMBER = '1';
        }
        return listLinesFields;        
    }
    public string getEffectiveFrom(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing_Quote_Wrapper){
        string effectiveFrom;
        boolean effectiveFromObtained = false;
        if(pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper.size() > 0){            
            for(IST_ST_PQ_Rent_Wrapper_cls.query_All_Fields ST_PQ_Rent_Wrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Rent_Wrapper){
                if(effectiveFromObtained == false){
                	for(ST_PQ_Rent_ASS_Wrapper_cls.query_All_Fields PQ_Rent_ASS_Wrapper : ST_PQ_Rent_Wrapper.list_ST_PQ_Rent_ASS_Wrapper){
                        if(PQ_Rent_ASS_Wrapper.Step == 2) {
                            effectiveFrom = PQ_Rent_ASS_Wrapper.Amort_Date;  
                            effectiveFromObtained = true;
                            break;
                        }  
                    }    
                } else {
                    break;
                }            	    
            }            
        } else if(pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper.size() > 0){
        	for(IST_ST_PQ_Loan_Wrapper_cls.query_All_Fields ST_PQ_Loan_Wrapper : pricing_Quote_Wrapper.list_IST_ST_PQ_Loan_Wrapper){
            	if(effectiveFromObtained == false){
                	for(ST_PQ_Loan_ASS_Wrapper_cls.query_All_Fields PQ_Loan_ASS_Wrapper : ST_PQ_Loan_Wrapper.list_ST_PQ_Loan_ASS_Wrapper){
                        if(PQ_Loan_ASS_Wrapper.Step == 2) {
                            effectiveFrom = PQ_Loan_ASS_Wrapper.Amort_Date;  
                            effectiveFromObtained = true;
                            break;
                        }  
                    }    
                } else {
                    break;
                }    
                
            }
        }
        return effectiveFrom;
    }
    public List<Takedown_Wrapper_Contract_Import_cls.Lines> assetLevelComputation(List<Takedown_Wrapper_Contract_Import_cls.Lines> listLinesFields, integer Num_Pmts, double contractRent, integer paymentOrder, string paymentFrecuency, string timing){
        double totalCostFromUnits = 0;
        //Esto se puede hacer solo una vez
        for(Takedown_Wrapper_Contract_Import_cls.Lines line : listLinesFields){
            if(line.ASSET_NUMBER != null){
                totalCostFromUnits = totalCostFromUnits + line.UNIT_COST; 
            }                       
        }
        for(Takedown_Wrapper_Contract_Import_cls.Lines line : listLinesFields){
            system.debug('line.UNIT_COST ' + line.UNIT_COST);
            system.debug('line.PAYMENT_AMOUNT ' + line.PAYMENT_AMOUNT);
            if(line.ASSET_NUMBER != null){
                decimal assetPercentage = line.UNIT_COST / totalCostFromUnits;
                decimal assetAllDecimal = contractRent * assetPercentage;
                line.PAYMENT_AMOUNT = assetAllDecimal.setScale(2, RoundingMode.HALF_UP);
                line.PERIOD = String.valueof(Num_Pmts);
                line.PAYMENT_ORDER = string.valueOf(paymentOrder);
                line.PAYMENT_FREQUENCY = paymentFrecuency;
                if(timing.equals('Arrears')){
                	line.ARREARS_FLAG = 'Y';   
                } else {
                    line.ARREARS_FLAG = 'N';
                }
            }  
            system.debug('line.PAYMENT_AMOUNT ' + line.PAYMENT_AMOUNT);
        }
        return listLinesFields;        
    }
}