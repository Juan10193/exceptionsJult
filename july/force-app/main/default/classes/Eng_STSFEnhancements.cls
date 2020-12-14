public with sharing class Eng_STSFEnhancements
{
    private Map<String, sObjectType> globalDescribe = Schema.getGlobalDescribe();
   
    public void ParseAndCreateEnhancements(String pobjId, String xmlOut)
    {
        CustomSTObjects customSTObjs = parse(xmlOut);
        CreateEnhancementObjects(pobjId, customSTObjs);
    }
    
    @TestVisible
    void CreateEnhancementObjects(String pobjId, CustomSTObjects customSTObjs)
    {
        CreateRentCashflows(customSTObjs.rentcashflows, pobjId);
        CreateLoanCashflows(customSTObjs.loancashflows, pobjId);
        CreatePerIncCashflows(customSTObjs.perinccashflows, pobjId);
        CreatePerExpCashflows(customSTObjs.perexpcashflows, pobjId);

        CreateRentAmortSchedule(customSTObjs.rentamortschedule, pobjId);
        CreateLoanAmortSchedule(customSTObjs.loanamortschedule, pobjId);

        CreateTVSchedule(customSTObjs.tvschedule, pobjId);
    }
    
    void CreateRentCashflows(List<CashflowStep> cfs, String pobjId)
    {
         List<string> fieldNames = new List<string>();
        
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('IST__stExternalID__c');
        sObjectType sObjType = IST__SuperTRUMP_PQ_Rent__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<IST__SuperTRUMP_PQ_Rent__c> rents = [Select Id, CurrencyIsoCode, IST__stExternalID__c From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId];
        
        if (rents.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Rent_Cash_Flow_Step__c.getSObjectType();
        
        Set<Id> rentIds = new Set<Id>();
        for (sObject rent : rents)
        {
            rentIds.Add(rent.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);
        
        // Get all the existing cashflow steps for the rents
        // related to the pobjId pricing quote.
        List<sObject> cashflows = [Select Id From ST_PQ_Rent_Cash_Flow_Step__c Where Rent__c In :rentIds];
        
        if (!cashFlows.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing cashflow steps before creating the new ones.
            delete cashflows;
        }
        
        if (!cfs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
        
            for (IST__SuperTRUMP_PQ_Rent__c rent : rents)
            {
                // Cashflow steps belonging to a particular rent will have a PID value
                // identical to the PID number in the stExternalID field of the rent,
                // e.g. 107 in "Z10001transactionrent107"
                integer PID = Eng_STCalculationIdService.getPid(rent, sObjectType.IST__SuperTRUMP_PQ_Rent__c.fields.IST__stExternalId__c.sObjectField);
                for (CashflowStep cf : cfs)
                {
                    if (cf.PID == PID)
                    {
                        ST_PQ_Rent_Cash_Flow_Step__c sObj = new ST_PQ_Rent_Cash_Flow_Step__c();
                        sObj.Rent__c =  rent.Id;
                        sObj.CurrencyIsoCode = rent.CurrencyIsoCode;
                        sObj.Amount__c = cf.amount;
                        sObj.Step__c = cf.step;
                        sObj.Num_Pmts__c = cf.numPmts;
                        sObj.Type__c = cf.type;
                        sObj.Rate__c = cf.rate;
                        sObj.Period__c = cf.period;
                        sObj.Timing__c = cf.timing;
                        sObj.Start_Accrual__c = cf.startAccrual;
                        sObj.End_Accrual__c = cf.endAccrual;
                        sObj.Balance__c = cf.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
    
    void CreateLoanCashflows(List<CashflowStep> cfs, String pobjId)
    {
         List<string> fieldNames = new List<string>();
        
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('IST__stExternalID__c');
        sObjectType sObjType = IST__SuperTRUMP_PQ_Loan__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<IST__SuperTRUMP_PQ_Loan__c> loans = [Select Id, CurrencyIsoCode, IST__stExternalID__c From IST__SuperTRUMP_PQ_Loan__c Where IST__Pricing_Quote__c = :pobjId];
        
        if (loans.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Loan_Cash_Flow_Step__c.getSObjectType();
        
        Set<Id> loanIds = new Set<Id>();
        for (sObject loan : loans)
        {
            loanIds.Add(loan.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);
        
        // Get all the existing cashflow steps for the loans
        // related to the pobjId pricing quote.
        List<sObject> cashflows = [Select Id From ST_PQ_Loan_Cash_Flow_Step__c Where Loan__c In :loanIds];
        
        if (!cashFlows.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing cashflow steps before creating the new ones.
            delete cashflows;
        }
        
        if (!cfs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
	        
            for (IST__SuperTRUMP_PQ_Loan__c loan : loans)
            {
                // Cashflow steps belonging to a particular loan will have a PID value
                // identical to the PID number in the stExternalID field of the loan,
                // e.g. 107 in "Z10001transactionloan107"
                integer PID = Eng_STCalculationIdService.getPid(loan, sObjectType.IST__SuperTRUMP_PQ_Loan__c.fields.IST__stExternalId__c.sObjectField);
                for (CashflowStep cf : cfs)
                {
                    if (cf.PID == PID)
                    {
                        ST_PQ_Loan_Cash_Flow_Step__c sObj = new ST_PQ_Loan_Cash_Flow_Step__c();
                        sObj.Loan__c =  loan.Id;
                        sObj.CurrencyIsoCode = loan.CurrencyIsoCode;
                        sObj.Amount__c = cf.amount;
                        sObj.Step__c = cf.step;
                        sObj.Num_Pmts__c = cf.numPmts;
                        sObj.Type__c = cf.type;
                        sObj.Rate__c = cf.rate;
                        sObj.Period__c = cf.period;
                        sObj.Timing__c = cf.timing;
                        sObj.Start_Accrual__c = cf.startAccrual;
                        sObj.End_Accrual__c = cf.endAccrual;
                        sObj.Balance__c = cf.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
    
    void CreatePerIncCashflows(List<CashflowStep> cfs, String pobjId)
    {
         List<string> fieldNames = new List<string>();
        
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('stExternalID__c');
        sObjectType sObjType = ST_PQ_Periodic_Income__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<ST_PQ_Periodic_Income__c> perincs = [Select Id, CurrencyIsoCode, stExternalID__c From ST_PQ_Periodic_Income__c Where Pricing_Quote__c = :pobjId];
        
        if (perincs.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Periodic_Income_Cash_Flow_Step__c.getSObjectType();
        
        Set<Id> perincIds = new Set<Id>();
        for (sObject perinc : perincs)
        {
            perincIds.Add(perinc.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);
        
        // Get all the existing cashflow steps for the periodic income
        // related to the pobjId pricing quote.
        List<sObject> cashflows = [Select Id From ST_PQ_Periodic_Income_Cash_Flow_Step__c Where Periodic_Income__c In :perincIds];
        
        if (!cashFlows.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing cashflow steps before creating the new ones.
            delete cashflows;
        }
        
        if (!cfs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
	        
            for (ST_PQ_Periodic_Income__c perinc : perincs)
            {
                // Cashflow steps belonging to a particular periodic Income will have a PID value
                // identical to the PID number in the stExternalID field of the periodic income,
                // e.g. 107 in "Z10001transactionloan107"
                integer PID = Eng_STCalculationIdService.getPid(perinc, sObjectType.ST_PQ_Periodic_Income__c.fields.stExternalId__c.sObjectField);
                for (CashflowStep cf : cfs)
                {
                    if (cf.PID == PID)
                    {
                        ST_PQ_Periodic_Income_Cash_Flow_Step__c sObj = new ST_PQ_Periodic_Income_Cash_Flow_Step__c();
                        sObj.Periodic_Income__c =  perinc.Id;
                        sObj.CurrencyIsoCode = perinc.CurrencyIsoCode;
                        sObj.Amount__c = cf.amount;
                        sObj.Step__c = cf.step;
                        sObj.Num_Pmts__c = cf.numPmts;
                        sObj.Type__c = cf.type;
                        sObj.Rate__c = cf.rate;
                        sObj.Period__c = cf.period;
                        sObj.Timing__c = cf.timing;
                        sObj.Start_Accrual__c = cf.startAccrual;
                        sObj.End_Accrual__c = cf.endAccrual;
                        sObj.Balance__c = cf.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
    
    void CreatePerExpCashflows(List<CashflowStep> cfs, String pobjId)
    {
         List<string> fieldNames = new List<string>();
        
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('stExternalID__c');
        sObjectType sObjType = ST_PQ_Periodic_Expense__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<ST_PQ_Periodic_Expense__c> perexps = [Select Id, CurrencyIsoCode, stExternalID__c From ST_PQ_Periodic_Expense__c Where Pricing_Quote__c = :pobjId];
        
        if (perexps.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Periodic_Expense_Cash_Flow_Step__c.getSObjectType();
        
        Set<Id> perexpIds = new Set<Id>();
        for (sObject perexp : perexps)
        {
            perexpIds.Add(perexp.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);
        
        // Get all the existing cashflow steps for the periodic expenses
        // related to the pobjId pricing quote.
        List<sObject> cashflows = [Select Id From ST_PQ_Periodic_Expense_Cash_Flow_Step__c Where Periodic_Expense__c In :perexpIds];
        
        if (!cashFlows.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing cashflow steps before creating the new ones.
            delete cashflows;
        }
        
        if (!cfs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
	        
            for (ST_PQ_Periodic_Expense__c perexp : perexps)
            {
                // Cashflow steps belonging to a particular periodic expense will have a PID value
                // identical to the PID number in the stExternalID field of the periodic expense,
                // e.g. 107 in "Z10001transactionloan107"
                integer PID = Eng_STCalculationIdService.getPid(perexp, sObjectType.ST_PQ_Periodic_Expense__c.fields.stExternalId__c.sObjectField);
                for (CashflowStep cf : cfs)
                {
                    if (cf.PID == PID)
                    {
                        ST_PQ_Periodic_Expense_Cash_Flow_Step__c sObj = new ST_PQ_Periodic_Expense_Cash_Flow_Step__c();
                        sObj.Periodic_Expense__c =  perexp.Id;
                        sObj.CurrencyIsoCode = perexp.CurrencyIsoCode;
                        sObj.Amount__c = cf.amount;
                        sObj.Step__c = cf.step;
                        sObj.Num_Pmts__c = cf.numPmts;
                        sObj.Type__c = cf.type;
                        sObj.Rate__c = cf.rate;
                        sObj.Period__c = cf.period;
                        sObj.Timing__c = cf.timing;
                        sObj.Start_Accrual__c = cf.startAccrual;
                        sObj.End_Accrual__c = cf.endAccrual;
                        sObj.Balance__c = cf.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
       
    void CreateRentAmortSchedule(List<AmortScheduleStep> aschs, String pobjId)
    {
        List<string> fieldNames = new List<string>();
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('IST__stExternalID__c');
        sObjectType sObjType = IST__SuperTRUMP_PQ_Rent__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<IST__SuperTRUMP_PQ_Rent__c> rents = [Select Id, CurrencyIsoCode, IST__stExternalID__c From IST__SuperTRUMP_PQ_Rent__c Where IST__Pricing_Quote__c = :pobjId];
        
        if (rents.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Rent_Amortization_Schedule_Step__c.getSObjectType();
        
        Set<Id> rentIds = new Set<Id>();
        for (sObject rent : rents)
        {
            rentIds.Add(rent.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);

        // Get all the existing amort schedule steps for the rents
        // related to the pobjId pricing quote.
        List<sObject> amortschedsteps = [Select Id From ST_PQ_Rent_Amortization_Schedule_Step__c Where Rent__c in :rentIds];
        
        if (!amortschedsteps.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing amort schedule steps before creating the new ones.
            delete amortschedsteps;
        }

        if (!aschs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
            
            for (IST__SuperTRUMP_PQ_Rent__c rent : rents)
            {
                // Amort Schedule steps belonging to a particular rent will have a PID value
                // identical to the PID number in the stExternalID field of the rent,
                // e.g. 107 in "Z10001transactionrent107"
                integer PID = Eng_STCalculationIdService.getPid(rent, sObjectType.IST__SuperTRUMP_PQ_Rent__c.fields.IST__stExternalId__c.sObjectField);
                for (AmortScheduleStep asch : aschs)
                {
                    if (asch.PID == PID)
                    {
                        ST_PQ_Rent_Amortization_Schedule_Step__c sObj = new ST_PQ_Rent_Amortization_Schedule_Step__c();
                        sObj.Rent__c = rent.Id;
                        sObj.CurrencyIsoCode = rent.CurrencyIsoCode;
                        sObj.Step__c = asch.step;
                        sObj.Funding__c = asch.funding;
                        sObj.Amort_Date__c = asch.amortdate;
                        sObj.Payment__c = asch.payment;
                        sObj.Interest__c = asch.interest;
                        sObj.Principal__c = asch.principal;
                        sObj.Balance__c = asch.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
       
    void CreateLoanAmortSchedule(List<AmortScheduleStep> aschs, String pobjId)
    {
        List<string> fieldNames = new List<string>();
        fieldNames.Add('Id');
        fieldNames.Add('CurrencyIsoCode');
        fieldNames.Add('IST__stExternalID__c');
        sObjectType sObjType = IST__SuperTRUMP_PQ_Loan__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);
        List<IST__SuperTRUMP_PQ_Loan__c> loans = [Select Id, CurrencyIsoCode, IST__stExternalID__c From IST__SuperTRUMP_PQ_Loan__c Where IST__Pricing_Quote__c = :pobjId];
        
        if (loans.isEmpty())
        {
            return;
        }
        
        sObjectType subSObjType = ST_PQ_Loan_Amortization_Schedule_Step__c.getSObjectType();
        
        Set<Id> loanIds = new Set<Id>();
        for (sObject loan : loans)
        {
            loanIds.Add(loan.Id);
        }
        
        fieldNames.clear();
        fieldNames.Add('Id');
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, subSObjType, fieldNames);

        // Get all the existing amort schedule steps for the loans
        // related to the pobjId pricing quote.
        List<sObject> amortschedsteps = [Select Id From ST_PQ_Loan_Amortization_Schedule_Step__c Where Loan__c in :loanIds];
        
        if (!amortschedsteps.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, subSObjType);
            // Delete the existing amort schedule steps before creating the new ones.
            delete amortschedsteps;
        }

        if (!aschs.IsEmpty())
        {
            List<sObject> sObjInsert = new List<sObject>();
	        
            for (IST__SuperTRUMP_PQ_Loan__c loan : loans)
            {
                // Amort Schedule steps belonging to a particular loan will have a PID value
                // identical to the PID number in the stExternalID field of the loan,
                // e.g. 107 in "Z10001transactionrent107"
                integer PID = Eng_STCalculationIdService.getPid(loan, sObjectType.IST__SuperTRUMP_PQ_Loan__c.fields.IST__stExternalId__c.sObjectField);
                for (AmortScheduleStep asch : aschs)
                {
                    if (asch.PID == PID)
                    {
                        ST_PQ_Loan_Amortization_Schedule_Step__c sObj = new ST_PQ_Loan_Amortization_Schedule_Step__c();
                        sObj.Loan__c = loan.Id;
                        sObj.CurrencyIsoCode = loan.CurrencyIsoCode;
                        sObj.Step__c = asch.step;
                        sObj.Funding__c = asch.funding;
                        sObj.Amort_Date__c = asch.amortdate;
                        sObj.Payment__c = asch.payment;
                        sObj.Interest__c = asch.interest;
                        sObj.Principal__c = asch.principal;
                        sObj.Balance__c = asch.balance;
                        sObjInsert.add(sObj);
                    }
                }
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, subSObjType);
            insert sObjInsert;
        }
    }
           
    void CreateTVSchedule(List<TVScheduleStep> tvschs, String pobjId)
    {
        List<string> qfieldNames = new List<string>();
        qfieldNames.Add('Id');
        qfieldNames.Add('CurrencyIsoCode');
        sObjectType qsObjType = IST__SuperTRUMP_Pricing_Quote__c.getSObjectType();
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, qsObjType, qfieldNames);
        List<IST__SuperTRUMP_Pricing_Quote__c> pquotes = [Select Id, CurrencyIsoCode From IST__SuperTRUMP_Pricing_Quote__c Where Id = :pobjId Limit 1];
        string CurrencyIsoCode = pquotes[0].CurrencyIsoCode;
    	
        sObjectType sObjType = ST_PQ_TV_Schedule_Step__c.sObjectType;

        List<String> fieldNames = new List<String> {'Id'};
        Eng_IvorySalesforceServices.checkObjAndFieldPermissions(Eng_IvorySalesforceServices.PermissionType.ACCESSIBLE, sObjType, fieldNames);

        List<ST_PQ_TV_Schedule_Step__c> tvStepObjs = [Select Id From ST_PQ_TV_Schedule_Step__c Where Quote__c = :pobjId];
        if (!tvStepObjs.isEmpty())
        {
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.DELETABLE, sObjType);
            delete tvStepObjs;
        }
        
        if (!tvschs.isEmpty())
        {
            tvStepObjs = new List<ST_PQ_TV_Schedule_Step__c>();
            for (TVScheduleStep tvsch : tvschs)
            {
                ST_PQ_TV_Schedule_Step__c sObj = new ST_PQ_TV_Schedule_Step__c();
                sObj.Quote__c = pobjId;
                sObj.CurrencyIsoCode = CurrencyIsoCode;
                sObj.TV_Date__c = tvsch.tvdate;
                sObj.Number_of_Payments_Scheduled__c = tvsch.numberOfPayments;
                sObj.Termination_Value_Percent__c = tvsch.tvValuePct;
                sObj.Termination_Value_Amount__c = tvsch.tvValueAmt;
                sObj.Advance_Rent__c = tvsch.advanceRent;
                sObj.Arrears_Rent__c = tvsch.arrearsRent;
                sObj.Advance_Debt_Service__c = tvsch.advanceDebtService;
                sObj.Arrears_Debt_Service__c = tvsch.arrearsDebtService;
                sObj.Total_Due_On_Termination__c = tvsch.totalDue;
                tvStepObjs.add(sObj);
            }
            Eng_IvorySalesforceServices.checkObjPermission(Eng_IvorySalesforceServices.PermissionType.CREATEABLE, sObjType);
            insert tvStepObjs;
        }
    }
    
    public CustomSTObjects parse(string xmlOut)
    {
        CustomSTObjects cusObjs = new CustomSTObjects();
        Dom.Document doc = new Dom.Document();
        doc.load(xmlOut);
        Dom.XmlNode rootNode = doc.getRootElement();
        if (rootNode == null || rootNode.getName().toLowerCase() != 'response')
        {
            throw new SuperTRUMPPricingQuoteEditException('ERROR: SuperTRUMP server response is not what was expected');
        }
        Dom.XmlNode messageNode = rootNode.getChildElement('Message', null);
        Dom.XmlNode resultNode = rootNode.getChildElement('Result', null);
        if (resultNode == null || resultNode.getText().toLowerCase() != 'success'){
            throw new SuperTRUMPPricingQuoteEditException ('ERROR: ' + (messageNode != null ? messageNode.getText() : 'Trouble parsing SuperTRUMP response result'));
        }
        Dom.XmlNode superTrumpNode = rootNode.getChildElement('SuperTRUMP', null);
        if (superTrumpNode == null)
        {
            throw new SuperTRUMPPricingQuoteEditException('ERROR: Missing SuperTRUMP element from server response');
        }
        List<Dom.XmlNode> transactionNodes = superTrumpNode.getChildElements();
        if (transactionNodes != null)
        {
            for (Dom.XmlNode transactionNode : transactionNodes){
                if (transactionNode.getName().toLowerCase() != 'transaction')
                {
                    continue;
                }
                Dom.XmlNode rentsNode = transactionNode.getChildElement('Rents', null);            
                ParseCashflowSteps(rentsNode, cusObjs.rentcashflows);
                ParseAmortSchedule(rentsNode, cusObjs.rentamortschedule);
                Dom.XmlNode loansNode = transactionNode.getChildElement('LendingLoans', null);
                ParseCashflowSteps(loansNode, cusObjs.loancashflows);
                ParseAmortSchedule(loansNode, cusObjs.loanamortschedule);
                Dom.XmlNode perincsNode = transactionNode.getChildElement('PeriodicIncomes', null);
                ParseCashflowSteps(perincsNode, cusObjs.perinccashflows);
                Dom.XmlNode perexpsNode = transactionNode.getChildElement('PeriodicExpenses', null);
                ParseCashflowSteps(perexpsNode, cusObjs.perexpcashflows);
                Dom.XmlNode reportInfoNode = transactionNode.getChildElement('PrintReportInfo', null);
                if (reportInfoNode != null)
                {
                    Dom.XmlNode reportXmlNode = reportInfoNode.getChildElement('ReportXml', null);
                    ParseTVSchedule(reportXmlNode, cusObjs.tvschedule);
                }
            }
        }
        return cusObjs;
    }
    
    void ParseCashflowSteps(Dom.XmlNode lTypesNode, List<CashflowStep> cfs)
    {
        if (lTypesNode == null)
        {
            return;
        }
        List<Dom.XmlNode> lTypeNodes = lTypesNode.getChildElements();
        for (Dom.XmlNode lTypeNode : lTypeNodes )
        {
            Dom.XmlNode PIDNode = lTypeNode.getChildElement('PID', null);
            if (PIDNode == null)
            {
                throw new SuperTRUMPPricingQuoteEditException('ERROR: No lType PID which associates a cashflow with an lType'); 
            }
            String PIDAsString = PIDNode.getText();
            integer Pid = (Integer)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, PIDAsString);
            Dom.XmlNode CashflowsNode = lTypeNode.getChildElement('CashflowSteps', null);
            if (CashflowsNode != null)
            {
                List<Dom.XmlNode> CashflowNodes = CashflowsNode.getChildElements(); 
                integer stepcnt = 1;
                if (CashflowNodes != null)
                {
                    for (Dom.XmlNode cashflowNode : CashflowNodes)
                    {
                        CashflowStep cf = new CashflowStep();
                        cf.PID = Pid;
                        cf.step = stepcnt;
                        Dom.XmlNode amountNode = cashflowNode.getChildElement('Amount', null);
                        if (amountNode != null)
                        {
                            string amountString = amountNode.getText();
                            cf.amount = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, amountString);
                        }
                        Dom.XmlNode typeNode = cashflowNode.getChildElement('Type', null);
                        if (typeNode != null)
                        {
                            String typeString = typeNode.getText();
                            if (!String.isEmpty(typeString))
                            {
                                cf.type = typeString;
                            }
                        }
                        Dom.XmlNode numPmtsNode = cashflowNode.getChildElement('NumberOfPayments', null);
                        if (numPmtsNode != null)
                        {
                            string numPmtsString = numPmtsNode.getText();
                            cf.NumPmts = (Integer)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, numPmtsString);
                        }
                        Dom.XmlNode endAccrualNode = cashflowNode.getChildElement('EndAccrual', null);
                        if (endAccrualNode != null)
                        {
                            string endAccrualString = endAccrualNode.getText();
                            cf.endAccrual = (String)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, endAccrualString);
                        }
                        Dom.XmlNode startAccrualNode = cashflowNode.getChildElement('StartAccrual', null);
                        if (startAccrualNode != null)
                        {
                            string startAccrualString = startAccrualNode.getText();
                            cf.startAccrual = (String)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, startAccrualString);
                        }
                        Dom.XmlNode rateNode = cashflowNode.getChildElement('Rate', null);
                        if (rateNode != null)
                        {
                            string rateString = rateNode.getText();
                            cf.rate = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Percent, rateString);
                        }
                        Dom.XmlNode periodNode = cashflowNode.getChildElement('Periodicity', null);
                        if (periodNode != null)
                        {
                            string periodString = periodNode.getText();
                            if (!String.isEmpty(periodString))
                            {
                                cf.period = periodString;
                            }
                        }
                        Dom.XmlNode timingNode = cashflowNode.getChildElement('PaymentTiming', null);
                        if (timingNode != null)
                        {
                            string timingString = timingNode.getText();
                            if (!String.isEmpty(timingString))
                            {
                                cf.timing = timingString;
                            }
                        }
                        Dom.XmlNode balanceNode = cashflowNode.getChildElement('Balance', null);
                        if (balanceNode != null)
                        {
                            string balanceString = balanceNode.getText();
                            cf.balance = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, balanceString);
                        }
                        stepcnt++;
		                
                        cfs.Add(cf);                                                   
                    }
                }
            }
        }
    }
    
    void ParseAmortSchedule(Dom.XmlNode lTypesNode, List<AmortScheduleStep> aschs)
    {
        if (lTypesNode == null)
        {
            return;
        }
        List<Dom.XmlNode> lTypeNodes = lTypesNode.getChildElements();
        if (lTypeNodes == null)
        {
            return;
            
        }
        for (Dom.XmlNode lTypeNode : lTypeNodes )
        {
            Dom.XmlNode PIDNode = lTypeNode.getChildElement('PID', null);
            if (PIDNode == null)
            {
                throw new SuperTRUMPPricingQuoteEditException('ERROR: No lType PID which associates an amortization step with an lType'); 
            }
            String PIDAsString = PIDNode.getText();
            integer Pid = (Integer)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, PIDAsString);
            Dom.XmlNode amortSchedNode = lTypeNode.getChildElement('AmortSchedule', null);
            if (amortSchedNode != null)
            {
                List<Dom.XmlNode> amortStepNodes = amortSchedNode.getChildElements();
                integer stepcnt = 1;
                if (amortStepNodes != null)
                {
                    for (Dom.XmlNode amortStepNode : amortStepNodes)
                    {
                        AmortScheduleStep asch = new AmortScheduleStep();
                        asch.PID = Pid;
                        asch.step = stepcnt;
                        string amortDateString = amortStepNode.getAttribute('date', null);
                        asch.amortdate = (String)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, amortDateString);
                        Dom.XmlNode fundingNode = amortStepNode.getChildElement('Funding', null);
                        if (fundingNode != null)
                        {
                            string fundingString = fundingNode.getText();
                            asch.funding = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, fundingString);
                        }
                        Dom.XmlNode balanceNode = amortStepNode.getChildElement('Balance', null);
                        if (balanceNode != null)
                        {
                            string balanceString = balanceNode.getText();
                            asch.balance = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, balanceString);
                        }
                        Dom.XmlNode paymentNode = amortStepNode.getChildElement('Payment', null);
                        if (paymentNode != null)
                        {
                            string paymentString = paymentNode.getText();
                            asch.payment = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, paymentString);
                        }
                        Dom.XmlNode interestNode = amortStepNode.getChildElement('Interest', null);
                        if (interestNode != null)
                        {
                            string interestString = interestNode.getText();
                            asch.interest = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, interestString);
                        }
                        Dom.XmlNode principalNode = amortStepNode.getChildElement('Principal', null);
                        if (principalNode != null)
                        {
                            string principalString = principalNode.getText();
                            asch.principal = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, principalString);
                        }
                        stepcnt++;
		                
                        aschs.Add(asch);                                                   
                    }
                }
            }
        }
    }

    void ParseTVSchedule(Dom.XmlNode reportXmlNode, List<TVScheduleStep> tvschs)
    {
        if (reportXmlNode == null)
        {
            return;
        }
        Dom.XmlNode reportNode = reportXmlNode.getChildElement('Report', null);
        if (reportNode == null)
        {
            return;
        }
        List<Dom.XmlNode> stepNodes = reportNode.getChildElements();
        if (stepNodes == null)
        {
            return;
        }
        for (Dom.XmlNode stepNode : stepNodes)
        {
            string stepTitle = stepNode.getName();
            if (stepTitle.equalsIgnoreCase('Header'))
            {
                continue;
            }
            TVScheduleStep tvsch = new TVScheduleStep();
            Dom.XmlNode tvDateNode = stepNode.getChildElement('Date', null);
            if (tvDateNode != null)
            {
                string tvDateString = tvDateNode.getText();
                tvsch.tvdate = (String)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.String, tvDateString);
            }
            Dom.XmlNode numPmtsNode = stepNode.getChildElement('NumberOfPaymentsScheduled', null);
            if (numPmtsNode != null)
            {
                string numPmtsString = numPmtsNode.getText();
                tvsch.numberOfPayments = (Integer)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Integer, numPmtsString);
            }
            Dom.XmlNode tvValuePctNode = stepNode.getChildElement('TerminationValuePercent', null);
            if (tvValuePctNode != null)
            {
                string tvValuePctString = tvValuePctNode.getText();
                if (!String.isEmpty(tvValuePctString))
                {
                    tvsch.tvValuePct = Decimal.valueOf(tvValuePctString);
                }
            }
            Dom.XmlNode tvValueAmtNode = stepNode.getChildElement('TerminationValue', null);
            if (tvValueAmtNode != null)
            {
                string tvValueAmtString = tvValueAmtNode.getText();
                tvsch.tvValueAmt = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, tvValueAmtString);
            }
            Dom.XmlNode advanceRentNode = stepNode.getChildElement('AdvanceRent', null);
            if (advanceRentNode != null)
            {
                string advanceRentString = advanceRentNode.getText();
                tvsch.advanceRent = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, advanceRentString);
            }
            Dom.XmlNode arrearsRentNode = stepNode.getChildElement('ArrearsRent', null);
            if (arrearsRentNode != null)
            {
                string arrearsRentString = arrearsRentNode.getText();
                tvsch.arrearsRent = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, arrearsRentString);
            }
            Dom.XmlNode advanceDebtServiceNode = stepNode.getChildElement('AdvanceDebtService', null);
            if (advanceDebtServiceNode != null)
            {
                string advanceDebtServiceString = advanceDebtServiceNode.getText();
                tvsch.advanceDebtService = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, advanceDebtServiceString);
            }
            Dom.XmlNode arrearsDebtServiceNode = stepNode.getChildElement('ArrearsDebtService', null);
            if (arrearsDebtServiceNode != null)
            {
                string arrearsDebtServiceString = arrearsDebtServiceNode.getText();
                tvsch.arrearsDebtService = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, arrearsDebtServiceString);
            }
            Dom.XmlNode totalDueNode = stepNode.getChildElement('TotalDueOnTermination', null);
            if (totalDueNode != null)
            {
                string totalDueString = totalDueNode.getText();
                tvsch.totalDue = (Decimal)Eng_IvoryCalcServer.parseCalculationFieldValue(Schema.DisplayType.Currency, totalDueString);
            }
                
           tvschs.Add(tvsch);                                                   
        }
    }

    public class CashflowStep
    {
        public Integer PID;
        public Integer step;
        public string type;
        public Integer numPmts;
        public Decimal amount;
        public Decimal rate;
        public string period;
        public string timing;
        public string startAccrual;
        public string endAccrual;
        public Decimal balance;
    }
    
    public class AmortScheduleStep
    {
        public Integer PID;
        public Integer step;
        public string amortdate;
        public Decimal funding;
        public Decimal payment;
        public Decimal interest;
        public Decimal principal;
        public Decimal balance;
    }
    
    public class TVScheduleStep
    {
        public string tvdate;
        public integer numberOfPayments;
        public Decimal tvValuePct;
        public Decimal tvValueAmt;
        public Decimal advanceRent;
        public Decimal arrearsRent;
        public Decimal advanceDebtService;
        public Decimal arrearsDebtService;
        public Decimal totalDue;
    }
    
    public class CustomSTObjects
    {
        CustomSTObjects()
        {
            rentcashflows = new List<CashflowStep>();
            loancashflows = new List<CashflowStep>();
            perinccashflows = new List<CashflowStep>();
            perexpcashflows = new List<CashflowStep>();
            rentamortschedule = new List<AmortScheduleStep>();
            loanamortschedule = new List<AmortScheduleStep>();
            tvSchedule = new List<TVScheduleStep>();
        }
        
        public List<CashflowStep> rentcashflows;
        public List<CashflowStep> loancashflows;
        public List<CashflowStep> perinccashflows;
        public List<CashflowStep> perexpcashflows;
        public List<AmortScheduleStep> rentamortschedule;
        public List<AmortScheduleStep> loanamortschedule;
        public List<TVScheduleStep> tvschedule;
    }

    public string queryXML(String stTransactionState, Blob reportBlob)
    {
        if (stTransactionState == null)
        {
            return null;
        }
        XmlStreamWriter xmlWriter = new XmlStreamWriter();
        xmlWriter.writeStartElement(null, 'SuperTRUMP', null);
        xmlWriter.writeAttribute(null, null, 'LocalErrorReporting', 'true');
        xmlWriter.writeStartElement(null, 'Transaction', null);  
        xmlWriter.writeStartElement(null, 'TransactionState', null);
        xmlWriter.writeCharacters(stTransactionState);
        xmlWriter.writeEndElement();
            
        xmlWriter.writeStartElement(null, 'Rents', null);
        xmlWriter.writeStartElement(null, 'Rent', null);
        xmlWriter.writeAttribute(null, null, 'index', '*');
        xmlWriter.writeStartElement(null, 'UseFundingsAndRate', null);
        xmlWriter.writeCharacters('true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'BalanceRate', null);
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'PID', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'CashflowSteps', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'AmortSchedule', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
               
        xmlWriter.writeStartElement(null, 'LendingLoans', null);
        xmlWriter.writeStartElement(null, 'LendingLoan', null);
        xmlWriter.writeAttribute(null, null, 'index', '*');
        xmlWriter.writeStartElement(null, 'PID', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'CashflowSteps', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'AmortSchedule', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();

        xmlWriter.writeStartElement(null, 'PeriodicIncomes', null);
        xmlWriter.writeStartElement(null, 'PeriodicIncome', null);
        xmlWriter.writeAttribute(null, null, 'index', '*');
        xmlWriter.writeStartElement(null, 'UseFundingsAndRate', null);
        xmlWriter.writeCharacters('true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'BalanceFunding', null);
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'PID', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'CashflowSteps', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();

        xmlWriter.writeStartElement(null, 'PeriodicExpenses', null);
        xmlWriter.writeStartElement(null, 'PeriodicExpense', null);
        xmlWriter.writeAttribute(null, null, 'index', '*');
        xmlWriter.writeStartElement(null, 'UseFundingsAndRate', null);
        xmlWriter.writeCharacters('true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'BalanceFunding', null);
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'PID', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeStartElement(null, 'CashflowSteps', null);
        xmlWriter.writeAttribute(null, null, 'query', 'true');
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        
        if (reportBlob != null)
        {
            xmlWriter.writeStartElement(null, 'PrintReportInfo', null);
            xmlWriter.writeStartElement(null, 'ReportBlob', null);
            String report = EncodingUtil.base64Encode(reportBlob);
            xmlWriter.writeCharacters(report);
            xmlWriter.writeEndElement();
            xmlWriter.writeStartElement(null, 'Periodicity', null);
            xmlWriter.writeCharacters('Monthly');
            xmlWriter.writeEndElement();
            xmlWriter.writeStartElement(null, 'ReportXml', null);
            xmlWriter.writeAttribute(null, null, 'query', 'true');
            xmlWriter.writeEndElement();
            xmlWriter.writeEndElement();
        }
        
        xmlWriter.writeEndElement();
        xmlWriter.writeEndElement();
        String result = xmlWriter.getXmlString();
        xmlWriter.close();
        return result;
    }
    
    private class SuperTRUMPPricingQuoteEditException extends Exception {}
}