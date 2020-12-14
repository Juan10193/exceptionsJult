public without sharing class Takedown_CA_VS_ST_Table_Service_cls {
    public id recordId {get;set;}
    
    public Takedown_CA_VS_ST_Table_Service_cls(id recordId){
        this.recordId = recordId;        
    }
    public Takedown_CA_VS_ST_Table_Wrapper_cls.Table make_Wrapper_PricingVSPricing(){
        Takedown_CA_VS_ST_Table_Wrapper_cls.Table wrapper_Table = new Takedown_CA_VS_ST_Table_Wrapper_cls.Table();
        Takedowns_Contingency_plan__c takedown_CP = Data_Access_WOS_Takedowns_CP_cls.getAllFields(this.recordID);
        if(takedown_CP != null){
            String pq_Name = takedown_CP.TKD_rb_Pricin_CA__c == null ? null : takedown_CP.TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c == null ? null : takedown_CP.TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c;
            SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pqCA = Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(pq_Name);
            system.debug('pqCA ' + pqCA);
            id pq_id = takedown_CP.Annex_Pricing_SuperTrump__c == null ? null : takedown_CP.Annex_Pricing_SuperTrump__c;
            SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pqST = Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(pq_id);
            system.debug('pqST ' + pqST);
            //Opportunity op_pqCA = Data_Access_WOS_Opportunity_cls.getOpportunityAllfields(pqCA.IST_Opportunity);
            //Opportunity op_pqST = Data_Access_WOS_Opportunity_cls.getOpportunityAllfields(pqST.IST_Opportunity);
            //wrapper_Table = makeTable(Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(pq_Name), op_pqCA, Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(pq_id), op_pqST);
            wrapper_Table = makeTable(Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByName(pq_Name), Data_Access_WOS_IST_SP_Pricing_Quote.getAllFieldsByID(pq_id));             
        }
		return wrapper_Table;        
        
    }
    //public Takedown_CA_VS_ST_Table_Wrapper_cls.Table makeTable(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingCA, Opportunity op_pqCA, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingPQ, Opportunity op_pqST){
    public Takedown_CA_VS_ST_Table_Wrapper_cls.Table makeTable(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingCA, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields PricingPQ){
    	Takedown_CA_VS_ST_Table_Wrapper_cls.Table wrapper_Table = new Takedown_CA_VS_ST_Table_Wrapper_cls.Table();
        List<Takedown_CA_VS_ST_Table_Wrapper_cls.Row> row = new List<Takedown_CA_VS_ST_Table_Wrapper_cls.Row>();
        system.debug('PricingCA ' + PricingCA);
        row.add(makeRow('Product', PricingCA.Product, PricingPQ.Product, '=', getValidation(PricingCA.Product, PricingPQ.Product, null, null, '=')));
        row.add(makeRow('Currency',PricingCA.CurrencyIsoCode, PricingPQ.CurrencyIsoCode, '=', getValidation(PricingCA.CurrencyIsoCode, PricingPQ.CurrencyIsoCode, null, null, '=')));
        row.add(makeRow('Amount to Finance K', String.valueof(PricingCA.IST_Cost), String.valueof(PricingPQ.IST_Cost),'>=', getValidation(null, null,PricingCA.IST_Cost, PricingPQ.IST_Cost, '>=')));
        row.add(makeRow('Term in Months', String.valueof(PricingCA.IST_Term), String.valueof(PricingPQ.IST_Term), '<=', getValidation(null, null, PricingCA.IST_Term, PricingPQ.IST_Term, '<=')));
        row.add(makeRow('Equipment to Finance', PricingCA.Opportunity_Collateral, PricingPQ.Opportunity_Collateral, '',''));
        row.add(makeRow('ARR/ADV', PricingCA.Payment_Timing, PricingPQ.Payment_Timing, '=', getValidation(PricingCA.Payment_Timing, PricingPQ.Payment_Timing, null, null, '=')));
        /*row.add(makeRow('Low-High/High-Low'));
        row.add(makeRow('L-H Description'));*/
        row.add(makeRow('Advance Payment %', String.valueof(getAdvancePayment(PricingCA)), String.valueof(getAdvancePayment(PricingPQ)), '>=', getValidation(null,null, getAdvancePayment(PricingCA), getAdvancePayment(PricingPQ), '>=')));
        row.add(makeRow('Frequency (Monthly/Quartely)', PricingCA.IST_Periodicity, PricingPQ.IST_Periodicity, '=', getValidation(PricingCA.IST_Periodicity, PricingPQ.IST_Periodicity, null, null, '=')));
        /*row.add(makeRow('Progress Payments(M)'));
        row.add(makeRow('Progress Description'));
        row.add(makeRow('Lock Fee %'));

        row.add(makeRow('Model, Asset & Return Condition', PricingCA.Product,PricingPQ.Product,'test','symbol'));
        row.add(makeRow('SL&B YES/NO'));
        row.add(makeRow('Remarketing Fee %'));
        row.add(makeRow('Used/New'));
        row.add(makeRow('EFA'));
        row.add(makeRow('Boot Collateral Type'));*/
        row.add(makeRow('EBO',String.valueof(PricingCA.EBO_Active), String.valueof(PricingPQ.EBO_Active), '=', getValidation(String.valueof(PricingCA.EBO_Active), String.valueof(PricingPQ.EBO_Active), null, null, '=')));
        /*row.add(makeRow('EBO Description'));
        row.add(makeRow('Grace Period (M)'));
        row.add(makeRow('Type of Grace Period'));
        row.add(makeRow('Split Trac %'));
        row.add(makeRow('Trac %'));
        row.add(makeRow('Prom Note'));

        row.add(makeRow('EOL Option', PricingCA.Product,PricingPQ.Product,'test','symbol'));*/
        row.add(makeRow('Expense ANI', String.valueof(PricingCA.Expense_ANI), String.valueof(PricingPQ.Expense_ANI), '>=',getValidation(null,null,PricingCA.Expense_ANI,PricingPQ.Expense_ANI,'>=')));//mayor o igual
        row.add(makeRow('BookYield',String.valueof(PricingCA.BookYield), String.valueOf(PricingPQ.BookYield), '<=', getValidation(null, null, PricingCA.BookYield,PricingPQ.BookYield, '<=')));
        row.add(makeRow('ROI (with insurance) %',String.valueOf(PricingCA.Economic_ROI),String.valueOf(PricingPQ.Economic_ROI),'<=',getValidation(null,null,PricingCA.Economic_ROI,PricingPQ.Economic_ROI,'<=')));
        //row.add(makeRow('ROI (no insurance) %',String.valueOf(PricingCA.Economic_ROI),String.valueOf(PricingPQ.Economic_ROI),'<=',getValidation(null,null,PricingCA.Economic_ROI,PricingPQ.Economic_ROI,'<=')));
        row.add(makeRow('Opening Fee %',String.valueOf(PricingCA.Opening_Fee),String.valueOf(PricingPQ.Opening_Fee),'<=',getValidation(null,null,PricingCA.Opening_Fee,PricingPQ.Opening_Fee,'<=')));
        row.add(makeRow('SD',String.valueOf(PricingCA.Security_Deposit),String.valueOf(PricingPQ.Security_Deposit),'<=',getValidation(null,null,PricingCA.Security_Deposit,PricingPQ.Security_Deposit,'<=')));
        row.add(makeRow('SD%',String.valueOf(PricingCA.Security_Deposit_Percentage),String.valueOf(PricingPQ.Security_Deposit_Percentage),'<=',getValidation(null,null,PricingCA.Security_Deposit_Percentage,PricingPQ.Security_Deposit_Percentage,'<=')));
        /*
        row.add(makeRow('SD Comment'));*/
        row.add(makeRow('Rate (fixed-floating)',PricingCA.Rate_Type,PricingPQ.Rate_Type,'',''));
        row.add(makeRow('Rate %', String.valueof(getRatePersent(PricingCA)), String.valueof(getRatePersent(PricingPQ)), '<=', getValidation(null, null, getRatePersent(PricingCA), getRatePersent(PricingPQ), '<=' )));
        row.add(makeRow('RV %', String.valueof(getRVPersent(PricingCA)), String.valueof(getRVPersent(PricingPQ)), '>=', getValidation(null, null, getRVPersent(PricingCA), getRVPersent(PricingPQ), '>=' )));
        
        row.add(makeRow('Balloon/Bullet Payment', String.valueof(PricingCA.IST_Balloon), String.valueof(PricingPQ.IST_Balloon), '=',  getValidation(null, null, PricingCA.IST_Balloon, PricingPQ.IST_Balloon, '=')));
        
        row.add(makeRow('P option %',String.valueof(getPOption(PricingCA)), String.valueof(getPOption(PricingPQ)), '=', getValidation(null, null, getPOption(PricingCA), getPOption(PricingPQ), '=')));
        row.add(makeRow('Last Update',dateToStringFormatDate(PricingCA.LastModifiedDate), dateToStringFormatDate(PricingPQ.LastModifiedDate), '', ''));
        wrapper_Table.rows = row;
        
        
        return wrapper_Table;
    }
    /*public string getFormatedNumberOnString(string Currency, double numberToFormate){
        List<String> args = new String[]{'0','number','###,###,##0.00'};
        String FormatedNumber = String.format(numberToFormate.format(), args);
        System.debug('USD ' + FormatedNumber);
        
        return FormatedNumber;
    }*/
    public double getAdvancePayment(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing){
    	return pricing.Advance_Payments == 0 ? pricing.Advance_Payment_Loan : pricing.Advance_Payments;    
    }
    public double getPOption(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing){
        double RatePersent = 0;
        switch on pricing.IST_TemplateName {
                when 'Quasi' {		// when block 1
                    RatePersent = pricing.Residual_Value;
                }
                when else {		  // default block, optional
                    RatePersent = null;
                }
            }
        return RatePersent;
        
    }
    public double getRatePersent(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing){
        double RatePersent = 0;
        switch on pricing.IST_TemplateName {
                when 'EC Quasi Lease' {		// when block 1
                    RatePersent = pricing.Full_Term_Rate;
                }	
                when 'EC Loan' {		// when block 2
                    
                    RatePersent = pricing.FulltermRatewithresidual; 
                }
                when else {		  // default block, optional
                    RatePersent = pricing.Full_Term_Rate;
                }
            }
        return RatePersent;
        
    }
     public double getRVPersent(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricing){
        double RatePersent = 0;
        switch on pricing.Product {
                when 'True' {		// when block 1
                    RatePersent = pricing.Residual_Value;
                }	
                when 'Fleet' {		// when block 2
                    
                    RatePersent = pricing.Residual_Value; 
                }
            	when 'TF' {		// when block 2
                    
                    RatePersent = pricing.Residual_Value; 
                }
                when else {		  // default block, optional
                    RatePersent = null;
                }
            }
        return RatePersent;
        
    }
    public Takedown_CA_VS_ST_Table_Wrapper_cls.Row makeRow(String field, String dataPricingCA, String dataPricingST, String evaluation, String symbol){
    	Takedown_CA_VS_ST_Table_Wrapper_cls.Row wrapper_Row = new Takedown_CA_VS_ST_Table_Wrapper_cls.Row();
        wrapper_Row.field = field;
        wrapper_Row.dataPricingCA = dataPricingCA;
        wrapper_Row.dataPricingST = dataPricingST;
        wrapper_Row.evaluation = evaluation;
        wrapper_Row.symbol = symbol;
        return wrapper_Row;
    }
    public string getValidation(string stringValue_CA, string stringValue_ST, double doubleValue_CA, double doubleValue_ST, string evaluator){
        string valitation_value;
        string approved = 'action:approval';
        string rejected = 'action:close';
        if(String.isNotEmpty(stringValue_CA) && String.isNotEmpty(stringValue_ST)){
            valitation_value = stringValue_CA.equals(stringValue_ST) ? approved : rejected;            
        } else if(doubleValue_CA != null && doubleValue_ST != null){
            switch on evaluator {
                when '=' {		// when block 1
                	valitation_value = doubleValue_CA == doubleValue_ST ? approved : rejected;   
                }	
                when '<=' {		// when block 2
                    valitation_value = doubleValue_CA <= doubleValue_ST ? approved : rejected; 
                }
                when '>=' {		// when block 3
                     valitation_value = doubleValue_CA >= doubleValue_ST ? approved : rejected;
                }
                when '<' {		// when block 3
                    valitation_value = doubleValue_CA < doubleValue_ST ? approved : rejected;
                }
                when '>' {		// when block 3
                    valitation_value = doubleValue_CA > doubleValue_ST ? approved : rejected;
                }
                when else {		  // default block, optional
                    valitation_value = rejected;
                }
            }
            
        }
        return valitation_value;
        
    }
    public static string dateToStringFormatDate(DateTime fecha){
        return fecha != null ? String.valueof(DateTime.newInstance(fecha.year(),fecha.month(),fecha.day()).format('dd/MM/YYYY')) : '';        
    }
    

}