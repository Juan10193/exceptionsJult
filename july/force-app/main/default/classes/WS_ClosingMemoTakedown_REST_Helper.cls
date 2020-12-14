public class WS_ClosingMemoTakedown_REST_Helper {
    private Opportunity opportunidad                                            {get;set;}
    private List<ES2_Obj_EntityMasterInCreditApproval__c> entitysInCa           {get;set;}
    private Credit_approval_CP__c ca                                            {get;set;}
    private SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ        {get;set;}
    private ES3_obj_Pricing_in_Credit_Approval__c pricingInCa                   {get;set;}
    private list<ES3_obj_Condition_Service_covenant__c> covenants               {get;set;}
    private Wrapper_ClosingMemoTakedown_REST closingMemoTKD                     {get;set;}

    public WS_ClosingMemoTakedown_REST_Helper(Id opportunityId, string pricingPQName, Id pricingInCaId){
        this.opportunidad = Data_Access_Opportunity_cls.getOpportunityById(String.valueOf(opportunityId));
        this.entitysInCa = Data_Access_EntityMastInCApproval_cls.entitiesInCaOp(string.valueOf(opportunityId));
        this.ca = TKD_ClosingMemoFull.getCredutApprovalbyOpId(string.valueOf(pricingInCaId));
        this.pricingPQ = TKD_ClosingMemoFull.fecthPricingPQ( pricingPQName);
        this.pricingInCa = TKD_ClosingMemoFull.fetchPricingInCA(string.valueOf(pricingInCaId));
        this.covenants = TKD_ClosingMemoFull.fetchCovenants(String.valueOf(opportunityId));
        this.closingMemoTKD = new Wrapper_ClosingMemoTakedown_REST();
        setGeneralInformation(this.ca);
        this.closingMemoTKD.caSummary = this.ca.BKL_TXT_Credit_Approval_Summary__c;
        setEntitiesEstructure(this.entitysInCa);
        setOpportunity (this.opportunidad);
        Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricing pq = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricing();
        pq.estructure = getPricingPQEstructure(this.pricingPQ, this.pricingInCa);
        pq.pricingId = this.pricingPQ.recordID;
        pq.pricingName = this.pricingPQ.Name;
        pq.economics = getPricingPQEconomics(this.pricingPQ, this.pricingInCa);
        this.closingMemoTKD.pricing = pq;
        this.closingMemoTKD.specialConditions = getSpecialConditions();
        this.closingMemoTKD.covenanQualitativos = getCovenanQualitativos();
        this.closingMemoTKD.covenanQuantitativos = getCovenanQuantitativos();
        this.closingMemoTKD.caComments = this.ca.ES3_CA_Comments__c;
    }


    public void setGeneralInformation(Credit_approval_CP__c ca){
        Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDGralInfo generalInfo = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDGralInfo();
        generalInfo.creditApprovalType = ca.Type_of_credit_approval__c;
        generalInfo.srUW = ca.Sr_Underwriter__r.FirstName +' ' + ca.Sr_Underwriter__r.LastName;
        generalInfo.uw = ca.Risk_Analyst__r.Name;
        generalInfo.statusAML = ca.ES3_ls_AML_Review_Status__c;
        generalInfo.vendor = ca.bkl_ls_vendor__c;
        generalInfo.economicGroup = ca.CPI_tx_Risk_Economic_Group__c;
        generalInfo.approvalLevel = ca.Approval_Level__c;
        generalInfo.approvalDate = ca.Decision_Date__c;
        generalInfo.originador = ca.CPL_rb_account__r.Owner.FirstName + ' ' + ca.CPL_rb_account__r.Owner.LastName;
        generalInfo.satusRisk = ca.ES3_ls_RISK_REVIEW_STATUS__c;
        generalInfo.ca = ca.Name;
        generalInfo.statusCA = ca.SP3_pl_Credit_Approval_Status__c;
        generalInfo.bussinesType = ca.CPL_rb_account__r.ACC_fm_Target_Market__c;
        generalInfo.caId =ca.Id;
        this.closingMemoTKD.generalInformation = generalInfo;
    }


    public void setEntitiesEstructure (list<ES2_Obj_EntityMasterInCreditApproval__c> entitysInCa){
        list<Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDentiteStructure> enties = new list<Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDentiteStructure>();
        for (ES2_Obj_EntityMasterInCreditApproval__c entitie : entitysInCa) {
            Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDentiteStructure entEstructure = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDentiteStructure();
            entEstructure.beneficialOwner = entitie.ES2_ms_Role__c.contains('Beneficial Owner')?1:0;
            entEstructure.legalDepositary = entitie.ES2_ms_Role__c.contains('Legal Depositary')?1:0;
            entEstructure.obligor = Integer.valueOf(entitie.ES2_fm_Obligor__c);
            entEstructure.guarantor =Integer.valueOf(entitie.ES2_fm_Garantor__c);
            entEstructure.riskDesicionEntity = Integer.valueOf(entitie.ES2_fm_Desicion_Entity__c);
            entEstructure.entityLink = entitie.ES2_fm_Entity__c;
            entEstructure.topParentId = entitie.ES2_tx_TopParentID__c;
            entEstructure.topParentName = entitie.ES2_tx_TopParetName__c;
            entEstructure.partyId = entitie.ES2_tx_Party_Id__c;
            entEstructure.customerType = entitie.ES2_tx_CostumerType__c;
            entEstructure.entityName = entitie.ES3_tx_Entity_Name__c;
            entEstructure.rFC = entitie.TKD_txt_RFC__c; 
            enties.add(entEstructure);
        }

        this.closingMemoTKD.entitiesStructure = enties;
    }

    public void setOpportunity (Opportunity opportunidad){
        Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDOpportunity opp = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDOpportunity();
        opp.opportunityId = string.valueOf(opportunidad.Id);
        opp.opportunityName = opportunidad.Name;
        opp.stage = opportunidad.StageName;
        opp.product = opportunidad.OPP_ls_Product__c;
        opp.productApproved = opportunidad.ES3_tx_Products_Approved__c;
        opp.aditionalServices = opportunidad.OPP_lm_Additional_Services__c;
        opp.brokerName = opportunidad.OPP_ls_Broker_name__c;
        opp.oppCurrency = opportunidad.CurrencyIsoCode;
        opp.financialNed = opportunidad.OPP_ls_Financing_Need__c;
        opp.brokerFeeComission = opportunidad.OPP_ls_Broker_Fee_Commision__c;
        opp.multiCurrency = opportunidad.CPL_ck_maybeProvidedAnotherCurrency__c;
        opp.lineOfBussines = opportunidad.OPP_ls_Line_of_Business__c;
        opp.amount = opportunidad.Amount;
        opp.collateral = opportunidad.OPP_ls_Collateral__c;
        opp.brokerFeeCommisionPercent = opportunidad.OPP_pr_Broker_Fee_Commision__c;
        this.closingMemoTKD.oportunidad = opp;
    }

    public Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEstructure getPricingPQEstructure (SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pPQ, ES3_obj_Pricing_in_Credit_Approval__c pricingInCa){
        Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEstructure pqEstructure = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEstructure();
        pqEstructure.pcngProduct = pPQ.Product_Name;
        pqEstructure.pcngCurrency = pPQ.CurrencyIsoCode;
        pqEstructure.amountToFinancek = pPQ.IST_Cost;
        pqEstructure.freqMontlyQuartely = pPQ.IST_Periodicity;
        pqEstructure.arrears =pPQ.Payment_Timing;
        pqEstructure.termInMontsIPP = getterminMonthsIncludingPP(pricingInCa, pPQ);
        pqEstructure.termInMontsWPP = Integer.valueOf(pricingInCa.ES3_pc_Term_in_months_without_PP__c);
        pqEstructure.progressPaymentsM = Integer.valueOf(pricingInCa.ES3_nu_Progress_Payments_M__c);
        pqEstructure.gracePeriodM = Integer.valueOf(pricingInCa.ES3_nu_Grace_Period_in_Months__c);
        pqEstructure.typeOfGracePeriod = pricingInCa.ES3_ls_Type_of_Grace_Period__c;
        pqEstructure.lowHig_HigLow = pricingInCa.ES3_ls_Low_High_High_Low__c;
        pqEstructure.lhDescription = pricingInCa.BKL_TXT_L_H_Description__c;
        pqEstructure.advancePayment = pricingInCa.ES3_nu_Advance_PaymentPercent__c;
        pqEstructure.eFA = pricingInCa.ES3_ls_EFA__c;
        pqEstructure.usedNew = pricingInCa.ES3_ls_Used_New__c;
        pqEstructure.sYLByesNo = pricingInCa.ES3_ls_SL_B_YES_NO__c;
        pqEstructure.progressDescription = pricingInCa.BKL_TXT_Progres_Description__c;
        pqEstructure.eBO = pricingInCa.ES3_ls_EBO__c;
        pqEstructure.eBoDescription = pricingInCa.ES3_tl_EBO_Description__c;
        pqEstructure.equipmentToFinance = pricingPQ.Opportunity_Collateral;
        pqEstructure.assetDescription = pricingInCa.BKL_TXT_Asset__c;
        pqEstructure.returnCondition = pricingInCa.BKL_TXT_Return_Condition__c;
        pqEstructure.remarketingFee = pricingInCa.ES3_pc_Remarketing_Fee_Percent__c;
        pqEstructure.splitTrack = pricingInCa.ES3_pc_Split_Trac_Percentent__c;
        pqEstructure.lockFee = pricingInCa.BKL_pc_Lock_Fee__c;
        pqEstructure.bootCollateralType = pricingInCa.ES3_tx_Boot_Collateral__c;
        pqEstructure.eolOption = pricingInCa.BKL_txt_EOL_Option__c;
        pqEstructure.promNote = pricingInCa.BKL_lst_Prom_Note__c;
        pqEstructure.cargaPeligrosa = pricingInCa.ES3_pc_C_PELIGROSA__c;
        pqEstructure.cashCollateral = pricingInCa.ES3_pc_CASH_COLLATERAL__c;
        pqEstructure.collectionRights = pricingInCa.ES3_pc_COLLECTION_RIGHTS__c;
        pqEstructure.crossCollateral = pricingInCa.ES3_pc_CROSS_COLLATERAL__c;
        pqEstructure.directDebit = pricingInCa.ES3_pc_DIRECT_DEBIT__c;
        return pqEstructure;
    }

    public Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEconomics getPricingPQEconomics(SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pPQ, ES3_obj_Pricing_in_Credit_Approval__c pricingInCa){
        Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEconomics pqEconomics = new Wrapper_ClosingMemoTakedown_REST.ClosingMemoTKDPricingEconomics();
        pqEconomics.expenseAni = pPQ.Expense_ANI;
        pqEconomics.rOIWithInsurance = pPQ.Economic_ROI;
        pqEconomics.rOINoInsurance = pricingInCa.ES3_nu_ROI_No_Insurance__c;
        pqEconomics.bookYield = pPQ.BookYield;
        pqEconomics.openingFee = getopeningFee(pricingInCa, pPQ);
        pqEconomics.sd = getSD(pricingInCa, pPQ);
        pqEconomics.sdPercent = pricingInCa.BLG_pr_SD_percent__c;
        pqEconomics.sdComment = pricingInCa.BLG_at_SD_Comment__c;
        pqEconomics.rateFixedFloating = pricingPQ.Rate_Type;
        pqEconomics.rate = getRatePercent(pricingInCa, pPQ);
        pqEconomics.rv = getRvpercent(pricingInCa, pPQ);
        pqEconomics.ballonBulletPayment = getBallon(pricingInCa, pPQ);
        pqEconomics.pOption = getPoption(pricingInCa, pPQ);
        pqEconomics.lastUpdate = Date.valueOf(pricingPQ.LastModifiedDate);
        return pqEconomics;
    }

    public Wrapper_ClosingMemoTakedown_REST getClosingMemo (){
        return this.closingMemoTKD;
    }

    public list<Wrapper_ClosingMemoTakedown_REST.SpecialCondition> getSpecialConditions(){
        list<ES3_obj_Condition_Service_covenant__c> specialCoditions = new List<ES3_obj_Condition_Service_covenant__c>();
        for (ES3_obj_Condition_Service_covenant__c record : this.covenants) {
            if(record.RecordType.Name.contains('Condition')){
                specialCoditions.add(record);
            }
        }

        list <Wrapper_ClosingMemoTakedown_REST.SpecialCondition> specials = new  list <Wrapper_ClosingMemoTakedown_REST.SpecialCondition>();

        if(specialCoditions.size()>0){
            for (ES3_obj_Condition_Service_covenant__c spetialconditio : specialCoditions) {
                string es3txcomments = spetialconditio.ES3_tx_Coments__c;
                if(es3txcomments == null || es3txcomments ==''){
                    spetialconditio.ES3_tx_Coments__c ='';
                }
                Wrapper_ClosingMemoTakedown_REST.SpecialCondition condition = new Wrapper_ClosingMemoTakedown_REST.SpecialCondition();
                condition.specialCondition = spetialconditio.ES3_lst_Condition__c + '; ' + spetialconditio.ES3_lt_Timing__c + '; ' + spetialconditio.ES3_TXT_Description__c + ' ' + spetialconditio.ES3_tx_Coments__c +'\n';
                specials.add(condition);
            }
        }

        return specials;
    }

    public list <Wrapper_ClosingMemoTakedown_REST.CovenanQualitativo> getCovenanQualitativos(){
        list<ES3_obj_Condition_Service_covenant__c> qualitativos = new List<ES3_obj_Condition_Service_covenant__c>();
        for (ES3_obj_Condition_Service_covenant__c record : this.covenants) {
            if(record.RecordType.Name.contains('Qualitative')){
                qualitativos.add(record);
            }
        }

        list <Wrapper_ClosingMemoTakedown_REST.CovenanQualitativo> covequalitativos = new list <Wrapper_ClosingMemoTakedown_REST.CovenanQualitativo>();

        if(qualitativos.size()>0){
            for (ES3_obj_Condition_Service_covenant__c cove : qualitativos) {
                if(cove.ES3_tx_Coments__c ==null || cove.ES3_tx_Coments__c ==''){
                    cove.ES3_tx_Coments__c='';
                }
                Wrapper_ClosingMemoTakedown_REST.CovenanQualitativo qualitative = new Wrapper_ClosingMemoTakedown_REST.CovenanQualitativo();
                qualitative.covenantCualitativo = cove.ES3_TXT_Threshold__c + '; ' + cove.ES3_LT_Timing_Cualitativo__c + '; ' + cove.ES3_LST_Covenant_Cualitativo__c + '; ' + cove.ES3_tx_Coments__c +'\n';
                system.debug('qualitativeP');
                system.debug(qualitative);
                system.debug('coveP');
                system.debug(cove);
                if(cove.ES3_rb_Entity__c !=null){
                    qualitative.covenantCualitativo = qualitative.covenantCualitativo + cove.ES3_rb_Entity__r.Name +'\n';
                }
                covequalitativos.add(qualitative);
            }
        }

        return covequalitativos;
    }

    public list <Wrapper_ClosingMemoTakedown_REST.CovenanQuantitativo> getCovenanQuantitativos(){
        list<ES3_obj_Condition_Service_covenant__c> quantittivos = new List<ES3_obj_Condition_Service_covenant__c>();
        for (ES3_obj_Condition_Service_covenant__c record : this.covenants) {
            if(record.RecordType.Name.contains('Quantitative')){
                quantittivos.add(record);
            }
        }

        list <Wrapper_ClosingMemoTakedown_REST.CovenanQuantitativo> covequantitativos = new list <Wrapper_ClosingMemoTakedown_REST.CovenanQuantitativo>();

        if(quantittivos.size()>0){
            for (ES3_obj_Condition_Service_covenant__c cove : quantittivos) {
                if(cove.ES3_lst_Covenant_Cuantitativo__c !=null || cove.ES3_lst_Covenant_Cuantitativo__c !=''){
                    if(cove.ES3_tx_Coments__c ==null || cove.ES3_tx_Coments__c ==''){
                        cove.ES3_tx_Coments__c='';
                    }
                    Wrapper_ClosingMemoTakedown_REST.CovenanQuantitativo quantitative = new Wrapper_ClosingMemoTakedown_REST.CovenanQuantitativo();
                    quantitative.covenantCuantitativo = cove.ES3_LT_Min_Max__c + '; ' +  cove.ES3_TXT_Threshold__c + '; ' + cove.ES3_LT_Timing_Cuantitativo__c + '; ' + cove.ES3_lst_Covenant_Cuantitativo__c + '; ' +cove.ES3_tx_Coments__c +'\n';
                    if(cove.ES3_rb_Entity__c !=null){
                        quantitative.covenantCuantitativo = quantitative.covenantCuantitativo + cove.ES3_rb_Entity__r.Name +'\n';
                    }
                    covequantitativos.add(quantitative);
                }
            }
        }

        return covequantitativos;
    }

    public integer getterminMonthsIncludingPP(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        if(pricingInCa.ES3_pc_Term_in_Months__c ==null ){
          return Integer.valueOf(pricingPQ.IST_Term);
        }else{
            return Integer.valueOf(pricingInCa.ES3_pc_Term_in_Months__c);
        }
    }

    public Decimal getopeningFee(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        if(pricingInCa.ES3_pc_Opening_Fee__c ==null){
            return pricingPQ.Opening_Fee; 
        }else{
            return pricingInCa.ES3_pc_Opening_Fee__c;
        }
    }

    public Decimal getSD(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        if(pricingInCa.ES3_num_SD__c ==null){
            return pricingPQ.Security_Deposit;
        }else{
            return pricingInCa.ES3_num_SD__c;
        }
    }

    public Decimal getRatePercent(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        if(pricingInCa.ES3_pc_Rate__c ==null){
            if(pricingPQ.IST_TemplateName =='EC Quasi Lease'){
                return pricingPQ.Full_Term_Rate;
            }else if(pricingPQ.IST_TemplateName !='EC Loan'){
                return pricingPQ.FulltermRatewithresidual;
            }else{
                return pricingPQ.IST_Lending_Rate;
            }
        }else{
            return pricingInCa.ES3_pc_Rate__c;
        }
    }

    public Decimal getRvpercent(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        String product;
        Decimal rvp;

        if(pricingPQ.IST_TemplateName == 'EC Loan'){
            product = 'Term Loan';
        }else{
            try{
            product = pricingPQ.IST_TemplateName.substring(3, pricingPQ.IST_TemplateName.length() +1);
            }catch(Exception e){
                system.debug('EL PQ NO TIENE TEMPLATE');
                system.debug(e);
            } 
        }

        if(product == null){
            if(pricingInCa.ES3_pc_RV__c ==null){
                if(product.contains('True') || product.contains('Fleet') || product.contains('TF')){
                    rvp = pricingPQ.Residual_Value;
                    return rvp;
                }
            }else{
                rvp = pricingInCa.ES3_pc_RV__c;
                return rvp;
            }
        }
        return null;   
    }

    public Decimal getBallon(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        if(pricingInCa.ES3_num_Ballon_Bullet_Payment__c==null){
            return pricingPQ.IST_Balloon;
        }else{
            return pricingInCa.ES3_num_Ballon_Bullet_Payment__c;
        }
    }

    public Decimal getPoption(ES3_obj_Pricing_in_Credit_Approval__c pricingInCa, SupperTRUMP_Pricing_Quote_Wrapper.query_All_Fields pricingPQ){
        string product;
        Decimal po;
        if(pricingPQ.IST_TemplateName =='EC Loan'){
            product = 'Term Loan';
        }else{
            try{
                product = pricingPQ.IST_TemplateName.substring(3, pricingPQ.IST_TemplateName.length() +1);
            }catch(Exception e){
               system.debug('EL PQ NO TIENE TEMPLATE');
               system.debug(e);
            }
        }

        if(product != null){
            if(pricingInCa.ES3_pc_P_Option__c ==null){
                if(product.contains('Quasi')){
                    po = pricingPQ.Residual_Value;
                    return po;
                }else{
                    po = null;
                    return po;
                }
            }else{
                po = pricingInCa.ES3_pc_P_Option__c;
               system.debug('pricing ca :' + pricingInCa.ES3_pc_P_Option__c );
                return po;
            }
        }
        return null;
    }
}