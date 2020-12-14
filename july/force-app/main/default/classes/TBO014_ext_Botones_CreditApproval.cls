public class TBO014_ext_Botones_CreditApproval {
	private final TBO014_Credit_Approval__c creditApprovalRecord {set; get;}
    public Boolean isSubmitReady								 {set; get;}
    public Boolean isMODRequestReady						     {set; get;}
    public Boolean isMACRequestReady							 {set; get;}
    
    // The extension constructor initializes the private member
    // variable creditApprovalRecord by using the getRecord method from the standard
    // controller.
    public TBO014_ext_Botones_CreditApproval(ApexPages.StandardController stdController) {
        this.creditApprovalRecord = (TBO014_Credit_Approval__c)stdController.getRecord();
        
        TBO014_Credit_Approval__c creditApproval = [SELECT TBO014_tx_Status__c, TBO014_fh_Effective_End_Date__c, TBO014_ls_Approval_Category__c FROM TBO014_Credit_Approval__c WHERE Id = :this.creditApprovalRecord.Id];
        
        AggregateResult pricingAR = [SELECT Count(Id) Quantity FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :this.creditApprovalRecord.Id];
        
        this.isSubmitReady = ((((Integer) pricingAR.get('Quantity')) > 0) && ((!creditApproval.TBO014_tx_Status__c.equals('Submitted'))) && (!creditApproval.TBO014_tx_Status__c.equals('Approved')) && (!creditApproval.TBO014_tx_Status__c.equals('MOD')));
                
        if (String.isNotEmpty(creditApproval.TBO014_tx_Status__c) && String.isNotEmpty(creditApproval.TBO014_ls_Approval_Category__c)) {
        	this.isMODRequestReady = ((creditApproval.TBO014_tx_Status__c.equals('Approved')) && (!creditApproval.TBO014_ls_Approval_Category__c.equals('MAC')) && (!creditApproval.TBO014_ls_Approval_Category__c.equals('MOD')));
    	}
        
        Date effectiveEndDateCA = creditApproval.TBO014_fh_Effective_End_Date__c;
        Date todaysDate = Date.today();
        
        if (String.isNotEmpty(creditApproval.TBO014_tx_Status__c) && (effectiveEndDateCA != null) && String.isNotEmpty(creditApproval.TBO014_ls_Approval_Category__c)) {
        	this.isMACRequestReady = ((todaysDate.daysBetween(effectiveEndDateCA) > 0) && (creditApproval.TBO014_tx_Status__c.equals('Approved')) && (!creditApproval.TBO014_ls_Approval_Category__c.equals('MAC')) && (!creditApproval.TBO014_ls_Approval_Category__c.equals('MOD')));
    	}
    }

    public PageReference callSubmit() {
        String url = '';
        
        HttpRequest request;
        HttpResponse response;
        
        Http objhttp = new Http();
        request = new HttpRequest();
        request.setMethod('POST'); 
        request.setEndpoint('http://160.34.7.97:7033/prs/handOffRequest/createHandOff/rs/v1/');
        request.setHeader('Accept','application/xml');
        request.setHeader('Content-type','application/xml; charset=UTF-8');
        request.setHeader('Accept-Language', 'en-CA');
        request.setTimeout(120000);
        
        TBO014_Credit_Approval__c creditApproval = [SELECT Id, Name, TBO014_fm_Account_Name__c, TBO014_rb_Account__r.ParentId, TBO014_tx_Status__c, TBO014_ls_Approval_Category__c, TBO014_rb_Credit_Approval_Original__c, TBO014_un_Amount_MXN__c, TBO014_un_Total_Amount_USD_Converted__c, TBO014_tx_Approval_Type__c FROM TBO014_Credit_Approval__c WHERE Id = :this.creditApprovalRecord.Id];
        
        String requestBody = '<v1:createHandOffRequest xmlns:v1="http://2BOptimus.engeniumcapital.com/esb/prs/handOffRequest/createHandOff/v1/">' +
                                '<v1:action>S</v1:action>' +
                                '<v1:accountName>' + creditApproval.TBO014_fm_Account_Name__c + '</v1:accountName>' +
                                '<v1:topParent>' + creditApproval.TBO014_rb_Account__r.ParentId + '</v1:topParent>' +
                                '<v1:sourceOpportunity>N/A</v1:sourceOpportunity>' +
                                '<v1:creditAnalistSF>N/A</v1:creditAnalistSF>' +
                                '<v1:user>N/A</v1:user>' +
                                '<v1:status>' + creditApproval.TBO014_tx_Status__c + '</v1:status>' +
                                '<v1:externalReferenceCreditAnalistSF>N/A</v1:externalReferenceCreditAnalistSF>' +
                                '<v1:approvalCategory>' + creditApproval.TBO014_ls_Approval_Category__c + '</v1:approvalCategory>' +
                                '<v1:creditApprovalOriginal>' + creditApproval.TBO014_rb_Credit_Approval_Original__c + '</v1:creditApprovalOriginal>' +
                                '<v1:MXNamount>' + creditApproval.TBO014_un_Amount_MXN__c + '</v1:MXNamount>' +
                                '<v1:USDtotalAmount>' + creditApproval.TBO014_un_Total_Amount_USD_Converted__c + '</v1:USDtotalAmount>' +
                                '<v1:approvalType>' + creditApproval.TBO014_tx_Approval_Type__c + '</v1:approvalType>';
        
        for (Opportunity opp : [SELECT Id, OPP_tx_EXT_REF_ID__c, Amount, CurrencyIsoCode, OPP_ls_Opportunity_from_Vendor__c, OPP_ls_Vendor_Fee_Commision__c, OPP_pr_Vendor_Fee_Commision__c, OPP_ls_Vendor_Brand__c, OPP_ls_Vendor_Distributor__c, OPP_ls_Opportunity_from_Broker__c, OPP_ls_Broker_Fee_Commision__c, OPP_pr_Broker_Fee_Commision__c, Owner.Name, OPP_rb_Closer__c, OPP_ls_Line_of_Business__c, OPP_ls_Region__c, OPP_ls_Vertical__c, OPP_ls_Financing_Need__c, OPP_lm_Additional_Services__c, OPP_ls_Deal_Category__c, OPP_ls_Insurance_Type__c, OPP_ls_Equipment_Import_Required__c, OPP_ls_Import_Type__c, OPP_tx_Opportunity_Comments__c, OPP_fh_Proposal_Signed_Received_Date__c, OPP_ls_Reason_Won_Level_1__c, OPP_ls_Reason_Won_Level_2__c, OPP_tl_Won_Comments__c, OPP_rb_Refered_by__c, OPP_tl_Not_Signed_Proposal_Reason__c, OPP_rb_Share_Rep_1__r.Name, OPP_rb_Share_Rep_2__r.Name, OPP_rb_Share_Rep_3__r.Name, OPP_rb_Share_Rep_4__r.Name FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :creditApproval.Id])
        {
            requestBody += '<v1:opportunities>' +
                                '<v1:opportunitySF>' + opp.Id + '</v1:opportunitySF>' +
                                '<v1:opportunityExternalReference>' + opp.OPP_tx_EXT_REF_ID__c + '</v1:opportunityExternalReference>' +
                                '<v1:amount>' + opp.Amount + '</v1:amount>' +
                                '<v1:currency>' + opp.CurrencyIsoCode + '</v1:currency>' +
                                '<v1:opportunityFromVendor>' + opp.OPP_ls_Opportunity_from_Vendor__c + '</v1:opportunityFromVendor>' +
                                '<v1:vendorFeeCommisionFlag>' + opp.OPP_ls_Vendor_Fee_Commision__c + '</v1:vendorFeeCommisionFlag>' +
                                '<v1:vendorFeeCommisionPerc>' + opp.OPP_pr_Vendor_Fee_Commision__c + '</v1:cendorFeeCommisionPerc>' +
                                '<v1:vendorBrand>' + opp.OPP_ls_Vendor_Brand__c + '</v1:vendorBrand>' +
                                '<v1:vendorDistributor>' + opp.OPP_ls_Vendor_Distributor__c + '</v1:vendorDistributor>' +
                                '<v1:opportunityFromBroker>' + opp.OPP_ls_Opportunity_from_Broker__c + '</v1:opportunityFromBroker>' +
                                '<v1:brokerFeeCommisionFlag>' + opp.OPP_ls_Broker_Fee_Commision__c + '</v1:brokerFeeCommisionFlag>' +
                                '<v1:brokerFeeCommisionPerc>' + opp.OPP_pr_Broker_Fee_Commision__c + '</v1:brokerFeeCommisionPerc>' +
                                '<v1:owner>' + opp.Owner.Name + '</v1:owner>' +
                                '<v1:closer>' + opp.OPP_rb_Closer__c + '</v1:closer>' +
                                '<v1:lineOfBusiness>' + opp.OPP_ls_Line_of_Business__c + '</v1:lineOfBusiness>' +
                                '<v1:region>' + opp.OPP_ls_Region__c + '</v1:region>' +
                                '<v1:vertical>' + opp.OPP_ls_Vertical__c + '</v1:vertical>' +
                                '<v1:financingNeed>' + opp.OPP_ls_Financing_Need__c + '</v1:financingNeed>' +
                                '<v1:additionalServices>' + opp.OPP_lm_Additional_Services__c + '</v1:additionalServices>' +
                                '<v1:dealCategory>' + opp.OPP_ls_Deal_Category__c + '</v1:dealCategory>' +
                                '<v1:insuranceType>' + opp.OPP_ls_Insurance_Type__c + '</v1:insuranceType>' +
                                '<v1:equipmentImportRequired>' + opp.OPP_ls_Equipment_Import_Required__c + '</v1:equipmentImportRequired>' +
                                '<v1:importType>' + opp.OPP_ls_Import_Type__c + '</v1:importType>' +
                                '<v1:comments>' + opp.OPP_tx_Opportunity_Comments__c + '</v1:comments>' +
                                '<v1:proposalSignedDate>' + opp.OPP_fh_Proposal_Signed_Received_Date__c + '</v1:proposalSignedDate>' +
                                '<v1:customerCreditAnalistResponse>N/A</v1:customerCreditAnalistResponse>' +
                                '<v1:reasonWonL1>' + opp.OPP_ls_Reason_Won_Level_1__c + '</v1:reasonWonL1>' +
                                '<v1:reasonWonL2>' + opp.OPP_ls_Reason_Won_Level_2__c + '</v1:reasonWonL2>' +
                                '<v1:wonComments>' + opp.OPP_tl_Won_Comments__c + '</v1:wonComments>' +
                                '<v1:referedBy>' + opp.OPP_rb_Refered_by__c + '</v1:referedBy>' +
                                '<v1:notSignedReason>' + opp.OPP_tl_Not_Signed_Proposal_Reason__c + '</v1:notSignedReason>' +
                                '<v1:shareRep1>' + opp.OPP_rb_Share_Rep_1__c + '</v1:shareRep1>' +
                                '<v1:shareRep2>' + opp.OPP_rb_Share_Rep_2__c + '</v1:shareRep2>' +
                                '<v1:shareRep3>' + opp.OPP_rb_Share_Rep_3__c + '</v1:shareRep3>' +
                                '<v1:shareRep4>' + opp.OPP_rb_Share_Rep_4__c + '</v1:shareRep4>' +
                            '</v1:opportunities>';
        }
                                
        for(TBO018_Pricing__c pricing : [SELECT Id, TBO018_rb_Opportunity__c, CurrencyIsoCode FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :creditApproval.Id]) {
            requestBody += '<v1:pricing>' +
                                '<v1:oportunitySF>' + pricing.TBO018_rb_Opportunity__c + '</v1:oportunitySF>' +
                                '<v1:product>N/A</v1:product>' +
                                '<v1:currency>' + pricing.CurrencyIsoCode + '</v1:currency>' +
                                '<v1:exchangeRate>N/A</v1:exchangeRate>' +
                                '<v1:exchangeRateDate>N/A</v1:exchangeRateDate>' +
                                '<v1:USDamount>N/A</v1:USDamount>' +
                                '<v1:term>N/A</v1:term>' +
                                '<v1:openningFee>N/A</v1:openningFee>' +
                                '<v1:securityDeposit>N/A</v1:securityDeposit>' +
                                '<v1:residual>N/A</v1:residual>' +
                                '<v1:deprecation>N/A</v1:deprecation>' +
                                '<v1:leverage>N/A</v1:leverage>' +
                                '<v1:rateType>N/A</v1:rateType>' +
                                '<v1:moneyCostDate>N/A</v1:moneyCostDate>' +
                                '<v1:expenseAni>N/A</v1:expenseAni>' +
                                '<v1:lossAni>N/A</v1:lossAni>' +
                                '<v1:fullTermWithResidual>N/A</v1:fullTermWithResidual>' +
                                '<v1:fullTermRate>N/A</v1:fullTermRate>' +
                                '<v1:lendingRate>N/A</v1:lendingRate>' +
                                '<v1:bookYield>N/A</v1:bookYield>' +
                                '<v1:economicYield>N/A</v1:economicYield>' +
                                '<v1:costOfFundsUnlevered>N/A</v1:costOfFundsUnlevered>' +
                                '<v1:costOfFundsLeverd>N/A</v1:costOfFundsLeverd>' +
                                '<v1:financeMargin>N/A</v1:financeMargin>' +
                                '<v1:economicROE>N/A</v1:economicROE>' +
                                '<v1:economicROI>N/A</v1:economicROI>' +
                                '<v1:contributedValue>N/A</v1:contributedValue>' +
                                '<v1:netIncome>N/A</v1:netIncome>' +
                            '</v1:pricing>';
        }
        
        requestBody += '</v1:createHandOffRequest>';
        
        /**
        request.setBody(requestBody);
        
        response = new HttpResponse();
        
        try {
            response = objhttp.send(request);
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
        }
        
        if(response.getStatus().equalsIgnoreCase('OK') && response.getStatusCode() == 200)
        {
            System.debug('EXITO-->' + response.getBody());
            url =  response.getBody();
            url = url.substringAfter('<v1:url>').substringBefore('</v1:url>');
            System.debug('EXITO3-->' + url); 
        }
        
        PageReference submitCreditApproval = new PageReference(url);
        */
        PageReference submitCreditApproval = new PageReference('/' + creditApproval.Id);
        submitCreditApproval.setRedirect(true);
		
        try {
            creditApproval.TBO014_tx_Status__c = 'Submitted';
            
            update creditApproval;
        }
        catch (Exception exUpdtCreditApproval) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exUpdtCreditApproval)));
            
            return null;
        }

        return submitCreditApproval;
    }
    
    public PageReference callMACRequest() {
        
        //Setup the save point for rollback
        Savepoint savePoint = Database.setSavepoint();
        
        TBO014_Credit_Approval__c creditApproval = [SELECT Id, OwnerId, Name, CurrencyIsoCode, RecordTypeId, TBO014_rb_Account__c, TBO014_fm_Account_Name__c, TBO014_un_Amount_USD__c, TBO014_un_Amount_MXN__c, TBO014_un_Total_Amount_USD_Converted__c, TBO014_tx_Approval_Type__c, TBO014_tx_Region__c, TBO014_tx_Status__c, TBO014_fh_Status_Date__c, TBO014_ca_Active__c, TBO014_fh_Effective_Start_Date__c, TBO014_fh_Effective_End_Date__c, TBO014_ls_EFA_required__c, BanderaCalculoAmout__c, TBO014_ca_Credit_Approval__c FROM TBO014_Credit_Approval__c WHERE Id = :this.creditApprovalRecord.Id];
                
        try {            
            creditApproval.TBO014_ls_Approval_Category__c = 'MAC';
            creditApproval.TBO014_tx_Status__c = 'New';
            
            update creditApproval;
        }
        catch (Exception exCloneCreditApproval) {
            Database.rollback(savePoint);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exCloneCreditApproval)));
            return null;
        }
        
        String url = '';
        
        HttpRequest request;
        HttpResponse response;
        
        Http objhttp = new Http();
        request = new HttpRequest();
        request.setMethod('POST'); 
        request.setEndpoint('http://160.34.7.97:7033/prs/handOffRequest/createHandOff/rs/v1/');
        request.setHeader('Accept','application/xml');
        request.setHeader('Content-type','application/xml; charset=UTF-8');
        request.setHeader('Accept-Language', 'en-CA');
        request.setTimeout(120000);
        
        String requestBody = '<v1:createHandOffRequest xmlns:v1="http://2BOptimus.engeniumcapital.com/esb/prs/handOffRequest/createHandOff/v1/">' +
                                '<v1:action>S</v1:action>' +
                                '<v1:accountName>' + creditApproval.TBO014_fm_Account_Name__c + '</v1:accountName>' +
                                '<v1:topParent>' + creditApproval.TBO014_rb_Account__r.ParentId + '</v1:topParent>' +
                                '<v1:sourceOpportunity>N/A</v1:sourceOpportunity>' +
                                '<v1:creditAnalistSF>N/A</v1:creditAnalistSF>' +
                                '<v1:user>N/A</v1:user>' +
                                '<v1:status>' + creditApproval.TBO014_tx_Status__c + '</v1:status>' +
                                '<v1:externalReferenceCreditAnalistSF>N/A</v1:externalReferenceCreditAnalistSF>' +
                                '<v1:approvalCategory>' + creditApproval.TBO014_ls_Approval_Category__c + '</v1:approvalCategory>' +
                                '<v1:creditApprovalOriginal>' + creditApproval.TBO014_rb_Credit_Approval_Original__c + '</v1:creditApprovalOriginal>' +
                                '<v1:MXNamount>' + creditApproval.TBO014_un_Amount_MXN__c + '</v1:MXNamount>' +
                                '<v1:USDtotalAmount>' + creditApproval.TBO014_un_Total_Amount_USD_Converted__c + '</v1:USDtotalAmount>' +
                                '<v1:approvalType>' + creditApproval.TBO014_tx_Approval_Type__c + '</v1:approvalType>';
        
        for (Opportunity opp : [SELECT Id, OPP_tx_EXT_REF_ID__c, Amount, CurrencyIsoCode, OPP_ls_Opportunity_from_Vendor__c, OPP_ls_Vendor_Fee_Commision__c, OPP_pr_Vendor_Fee_Commision__c, OPP_ls_Vendor_Brand__c, OPP_ls_Vendor_Distributor__c, OPP_ls_Opportunity_from_Broker__c, OPP_ls_Broker_Fee_Commision__c, OPP_pr_Broker_Fee_Commision__c, Owner.Name, OPP_rb_Closer__c, OPP_ls_Line_of_Business__c, OPP_ls_Region__c, OPP_ls_Vertical__c, OPP_ls_Financing_Need__c, OPP_lm_Additional_Services__c, OPP_ls_Deal_Category__c, OPP_ls_Insurance_Type__c, OPP_ls_Equipment_Import_Required__c, OPP_ls_Import_Type__c, OPP_tx_Opportunity_Comments__c, OPP_fh_Proposal_Signed_Received_Date__c, OPP_ls_Reason_Won_Level_1__c, OPP_ls_Reason_Won_Level_2__c, OPP_tl_Won_Comments__c, OPP_rb_Refered_by__c, OPP_tl_Not_Signed_Proposal_Reason__c, OPP_rb_Share_Rep_1__r.Name, OPP_rb_Share_Rep_2__r.Name, OPP_rb_Share_Rep_3__r.Name, OPP_rb_Share_Rep_4__r.Name FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :creditApproval.Id])
        {
            requestBody += '<v1:opportunities>' +
                                '<v1:opportunitySF>' + opp.Id + '</v1:opportunitySF>' +
                                '<v1:opportunityExternalReference>' + opp.OPP_tx_EXT_REF_ID__c + '</v1:opportunityExternalReference>' +
                                '<v1:amount>' + opp.Amount + '</v1:amount>' +
                                '<v1:currency>' + opp.CurrencyIsoCode + '</v1:currency>' +
                                '<v1:opportunityFromVendor>' + opp.OPP_ls_Opportunity_from_Vendor__c + '</v1:opportunityFromVendor>' +
                                '<v1:vendorFeeCommisionFlag>' + opp.OPP_ls_Vendor_Fee_Commision__c + '</v1:vendorFeeCommisionFlag>' +
                                '<v1:vendorFeeCommisionPerc>' + opp.OPP_pr_Vendor_Fee_Commision__c + '</v1:cendorFeeCommisionPerc>' +
                                '<v1:vendorBrand>' + opp.OPP_ls_Vendor_Brand__c + '</v1:vendorBrand>' +
                                '<v1:vendorDistributor>' + opp.OPP_ls_Vendor_Distributor__c + '</v1:vendorDistributor>' +
                                '<v1:opportunityFromBroker>' + opp.OPP_ls_Opportunity_from_Broker__c + '</v1:opportunityFromBroker>' +
                                '<v1:brokerFeeCommisionFlag>' + opp.OPP_ls_Broker_Fee_Commision__c + '</v1:brokerFeeCommisionFlag>' +
                                '<v1:brokerFeeCommisionPerc>' + opp.OPP_pr_Broker_Fee_Commision__c + '</v1:brokerFeeCommisionPerc>' +
                                '<v1:owner>' + opp.Owner.Name + '</v1:owner>' +
                                '<v1:closer>' + opp.OPP_rb_Closer__c + '</v1:closer>' +
                                '<v1:lineOfBusiness>' + opp.OPP_ls_Line_of_Business__c + '</v1:lineOfBusiness>' +
                                '<v1:region>' + opp.OPP_ls_Region__c + '</v1:region>' +
                                '<v1:vertical>' + opp.OPP_ls_Vertical__c + '</v1:vertical>' +
                                '<v1:financingNeed>' + opp.OPP_ls_Financing_Need__c + '</v1:financingNeed>' +
                                '<v1:additionalServices>' + opp.OPP_lm_Additional_Services__c + '</v1:additionalServices>' +
                                '<v1:dealCategory>' + opp.OPP_ls_Deal_Category__c + '</v1:dealCategory>' +
                                '<v1:insuranceType>' + opp.OPP_ls_Insurance_Type__c + '</v1:insuranceType>' +
                                '<v1:equipmentImportRequired>' + opp.OPP_ls_Equipment_Import_Required__c + '</v1:equipmentImportRequired>' +
                                '<v1:importType>' + opp.OPP_ls_Import_Type__c + '</v1:importType>' +
                                '<v1:comments>' + opp.OPP_tx_Opportunity_Comments__c + '</v1:comments>' +
                                '<v1:proposalSignedDate>' + opp.OPP_fh_Proposal_Signed_Received_Date__c + '</v1:proposalSignedDate>' +
                                '<v1:customerCreditAnalistResponse>N/A</v1:customerCreditAnalistResponse>' +
                                '<v1:reasonWonL1>' + opp.OPP_ls_Reason_Won_Level_1__c + '</v1:reasonWonL1>' +
                                '<v1:reasonWonL2>' + opp.OPP_ls_Reason_Won_Level_2__c + '</v1:reasonWonL2>' +
                                '<v1:wonComments>' + opp.OPP_tl_Won_Comments__c + '</v1:wonComments>' +
                                '<v1:referedBy>' + opp.OPP_rb_Refered_by__c + '</v1:referedBy>' +
                                '<v1:notSignedReason>' + opp.OPP_tl_Not_Signed_Proposal_Reason__c + '</v1:notSignedReason>' +
                                '<v1:shareRep1>' + opp.OPP_rb_Share_Rep_1__c + '</v1:shareRep1>' +
                                '<v1:shareRep2>' + opp.OPP_rb_Share_Rep_2__c + '</v1:shareRep2>' +
                                '<v1:shareRep3>' + opp.OPP_rb_Share_Rep_3__c + '</v1:shareRep3>' +
                                '<v1:shareRep4>' + opp.OPP_rb_Share_Rep_4__c + '</v1:shareRep4>' +
                            '</v1:opportunities>';
        }
                                
        for(TBO018_Pricing__c pricing : [SELECT Id, TBO018_rb_Opportunity__c, CurrencyIsoCode FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :creditApproval.Id]) {
            requestBody += '<v1:pricing>' +
                                '<v1:oportunitySF>' + pricing.TBO018_rb_Opportunity__c + '</v1:oportunitySF>' +
                                '<v1:product>N/A</v1:product>' +
                                '<v1:currency>' + pricing.CurrencyIsoCode + '</v1:currency>' +
                                '<v1:exchangeRate>N/A</v1:exchangeRate>' +
                                '<v1:exchangeRateDate>N/A</v1:exchangeRateDate>' +
                                '<v1:USDamount>N/A</v1:USDamount>' +
                                '<v1:term>N/A</v1:term>' +
                                '<v1:openningFee>N/A</v1:openningFee>' +
                                '<v1:securityDeposit>N/A</v1:securityDeposit>' +
                                '<v1:residual>N/A</v1:residual>' +
                                '<v1:deprecation>N/A</v1:deprecation>' +
                                '<v1:leverage>N/A</v1:leverage>' +
                                '<v1:rateType>N/A</v1:rateType>' +
                                '<v1:moneyCostDate>N/A</v1:moneyCostDate>' +
                                '<v1:expenseAni>N/A</v1:expenseAni>' +
                                '<v1:lossAni>N/A</v1:lossAni>' +
                                '<v1:fullTermWithResidual>N/A</v1:fullTermWithResidual>' +
                                '<v1:fullTermRate>N/A</v1:fullTermRate>' +
                                '<v1:lendingRate>N/A</v1:lendingRate>' +
                                '<v1:bookYield>N/A</v1:bookYield>' +
                                '<v1:economicYield>N/A</v1:economicYield>' +
                                '<v1:costOfFundsUnlevered>N/A</v1:costOfFundsUnlevered>' +
                                '<v1:costOfFundsLeverd>N/A</v1:costOfFundsLeverd>' +
                                '<v1:financeMargin>N/A</v1:financeMargin>' +
                                '<v1:economicROE>N/A</v1:economicROE>' +
                                '<v1:economicROI>N/A</v1:economicROI>' +
                                '<v1:contributedValue>N/A</v1:contributedValue>' +
                                '<v1:netIncome>N/A</v1:netIncome>' +
                            '</v1:pricing>';
        }
        
        requestBody += '</v1:createHandOffRequest>';
        
        /**
        request.setBody(requestBody);
        
        response = new HttpResponse();
        
        try {
            response = objhttp.send(request);
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
        }
        
        if(response.getStatus().equalsIgnoreCase('OK') && response.getStatusCode() == 200)
        {
            System.debug('EXITO-->' + response.getBody());
            url =  response.getBody();
            url = url.substringAfter('<v1:url>').substringBefore('</v1:url>');
            System.debug('EXITO3-->' + url); 
        }
        
        PageReference submitCreditApproval = new PageReference(url);
        */
        
        PageReference gotoCreditApproval = new PageReference('/' + creditApproval.Id); 
        gotoCreditApproval.setRedirect(true);
        
        return gotoCreditApproval;
    }
    
    public PageReference callMODRequest() {
        
        //Setup the save point for rollback
        Savepoint savePoint = Database.setSavepoint();
        
        TBO014_Credit_Approval__c newCreditApproval;
        
        try {
            
            System.debug('Entro!');
            
        	// Copy the Credit Approval - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
            TBO014_Credit_Approval__c creditApproval = [SELECT Id, OwnerId, Name, CurrencyIsoCode, RecordTypeId, TBO014_rb_Account__c, TBO014_fm_Account_Name__c, TBO014_un_Amount_USD__c, TBO014_un_Amount_MXN__c, TBO014_un_Total_Amount_USD_Converted__c, TBO014_tx_Approval_Type__c, TBO014_tx_Region__c, TBO014_tx_Status__c, TBO014_fh_Status_Date__c, TBO014_ca_Active__c, TBO014_fh_Effective_Start_Date__c, TBO014_fh_Effective_End_Date__c, TBO014_ls_EFA_required__c, BanderaCalculoAmout__c, TBO014_ca_Credit_Approval__c FROM TBO014_Credit_Approval__c WHERE Id = :this.creditApprovalRecord.Id];
        
        	newCreditApproval = creditApproval.clone(false);
            newCreditApproval.TBO014_ls_Approval_Category__c = 'MOD';
            newCreditApproval.TBO014_tx_Status__c = 'MOD';
            newCreditApproval.TBO014_rb_Credit_Approval_Original__c = creditApproval.Id;
            
            insert newCreditApproval;
            
            System.debug('New Credit Approval: ' + newCreditApproval);
            
            // Copy over the opportunity records - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
            Map<Id, Opportunity> oppRecordMap = new Map<Id, Opportunity>();
            
            for(Opportunity oppRecord : [SELECT Id, AccountId, RecordTypeId, Name, Description, StageName, Amount, Probability, CloseDate, Type, NextStep, LeadSource, IsClosed, IsWon, ForecastCategory, ForecastCategoryName, CurrencyIsoCode, CampaignId, HasOpportunityLineItem, Pricebook2Id, OwnerId, LastActivityDate, FiscalQuarter, FiscalYear, Fiscal, LastViewedDate, LastReferencedDate, SyncedQuoteId, HasOpenActivity, HasOverdueTask, OPP_na_Folio__c, OPP_rb_Credit_Approval__c, ROI_Analysis_Completed__c, OPP_tx_EXT_REF_ID__c, OPP_ls_Product__c, OPP_ls_Collateral__c, OPP_ls_Equipment_Condition__c, OPP_ls_Opportunity_from_Vendor__c, OPP_ls_Vendor_Fee_Commision__c, OPP_pr_Vendor_Fee_Commision__c, OPP_ls_Vendor_Brand__c, OPP_ls_Vendor_Distributor__c, OPP_ls_Opportunity_from_Broker__c, OPP_ls_Broker_Fee_Commision__c, OPP_pr_Broker_Fee_Commision__c, OPP_ls_Origin_of_equipment__c, OPP_rb_Account_Name__c, OPP_rb_Closer__c, OPP_ls_Line_of_Business__c, OPP_ls_Region__c, OPP_ls_Vertical__c, OPP_ls_Financing_Need__c, OPP_lm_Additional_Services__c, OPP_ls_Deal_Category__c, OPP_ls_Insurance_Type__c, OPP_ls_Equipment_Import_Required__c, OPP_ls_Import_Type__c, OPP_tx_Opportunity_Comments__c, OPP_fh_Proposal_Signed_Received_Date__c, OPP_fh_Date_Customer_Expects_Credit_App__c, OPP_ls_Reason_Won_Level_1__c, OPP_ls_Reason_Won_Level_2__c, OPP_tl_Won_Comments__c, OPP_ls_Reason_Lost_Level_1__c, OPP_ls_Reason_Lost_Level_2__c, OPP_tx_Lost_Comments__c, OPP_un_Spread_Diff_vs_Competitor_in_bps__c, OPP_ls_Competitor_Product__c, OPP_un_Competitor_Spread_bps__c, OPP_un_Competitor_Term_Months__c, OPP_ls_Competitor_Floating_Fixed__c, OPP_ls_Competitor_Is_the_main_lender__c, OPP_tl_Competitor_comments__c, OPP_tl_Not_Signed_Proposal_Reason__c, OPP_ls_Shared_Opportunity__c, OPP_ls_Of_sharing_reps__c, OPP_ls_Sharing_Criteria__c, OPP_rb_Share_Rep_1__c, OPP_pr_Sharing_1__c, OPP_ls_Shadow_Split__c, OPP_rb_Share_Rep_2__c, OPP_pr_Sharing_2__c, OPP_ls_Sharing_Type_2__c, OPP_rb_Share_Rep_3__c, OPP_pr_Sharing_3__c, OPP_ls_Sharing_Type_3__c, OPP_rb_Share_Rep_4__c, OPP_pr_Sharing_4__c, OPP_ls_Sharing_Type_4__c, OPP_ls_Marketing_Initiative_1__c, OPP_ls_Marketing_Initiative_2__c, OPP_ls_Marketing_Initiative_3__c, OPP_ls_Broker_name__c, OPP_rb_Competitor__c, OPP_rb_Refered_by__c, OPP_ls_Competitor_Index__c, OPP_ls_Reason_Lost_Level_3__c, OPP_fm_EditOpp__c, OPP_fm_Credit_Approval_Status__c, OPP_re_Pre_screening__c, OPP_ca_No_document__c, OPP_at_No_document_Reason__c, OPP_re_Takedown__c FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :this.creditApprovalRecord.Id]) {
                Opportunity newOppRecord = oppRecord.clone(false);
                newOppRecord.OPP_rb_Credit_Approval__c = newCreditApproval.Id;
                newOppRecord.OPP_tx_EXT_REF_ID__c = null;
                newOppRecord.Name = newOppRecord.Name + ' MOD';
                newOppRecord.StageName = 'MOD';
                oppRecordMap.put(oppRecord.Id, newOppRecord);
            }
            
            System.debug('Opp Record Map Values: ' + oppRecordMap.values());
            
            insert oppRecordMap.values();
            
            /**
            Set<Id> pricingQuteIds = new Set<Id>();
            
            for (TBO018_Pricing__c pricingRecordPQ : [Select TBO018_rb_SuperTRUMP_Pricing_Quote__c FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :this.creditApprovalRecord.Id AND TBO018_rb_Opportunity__c IN :oppRecordMap.keySet()]) {
                pricingQuteIds.add(pricingRecordPQ.TBO018_rb_SuperTRUMP_Pricing_Quote__c);
            }
            
            // Copy over the opportunity records - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
            Map<Id, IST__SuperTRUMP_Pricing_Quote__c> pricingQuoteRecordMap = new Map<Id, IST__SuperTRUMP_Pricing_Quote__c>();
            
            for(IST__SuperTRUMP_Pricing_Quote__c pricingQuoteRecord : [SELECT Id, IST__Balloon__c, BookYield__c, IST__Commencement__c, Contributed_Value__c, IST__Cost__c, Cost_of_Funds_Levered__c, Cost_of_Funds_Unlevered__c, created_in_SF__c, IST__Is_Synchronized__c, IST__Delivery_Date__c, Depreciation__c, Economic_ROE__c, Economic_ROI__c, Economic_Yield__c, Expense_ANI__c, Finance_Margin__c, IST__FinanceType__c, Full_Term_Rate__c, FulltermRatewithresidual__c, IST__IRR_NPT__c, IST__Lending_Rate__c, IST__LessorFAS__c, Leverage__c, LossANI__c, MC_Currency__c, IST__MISF_NAT__c, IST__Mode__c, MoneyCostDateFound__c, Net_Income__c, Opening_Fee__c, IST__Opportunity__c, IST__Payment__c, IST__Payment_Timing__c, IST__Periodicity__c, Product__c, IST__Description__c, IST__QuoteStatus__c, Rate_Type__c, IST__Rent_IBR__c, IST__Residual__c, Security_Deposit__c, IST__stExternalID__c, IST__Takedown__c, IST__Template__c, IST__Term__c, IST__Total_Lending__c FROM IST__SuperTRUMP_Pricing_Quote__c WHERE Id = :pricingQuteIds]) {
                IST__SuperTRUMP_Pricing_Quote__c newPricingQuoteRecord = pricingQuoteRecord.clone(false);
                
                Opportunity currentOpportunity = oppRecordMap.get(pricingQuoteRecord.IST__Opportunity__c);
                
                newPricingQuoteRecord.IST__Opportunity__c = currentOpportunity.Id;
                pricingQuoteRecordMap.put(pricingQuoteRecord.Id, newPricingQuoteRecord);
            }
            
            System.debug('Pricing Quote Record Map Values: ' + pricingQuoteRecordMap.values());
            
            insert pricingQuoteRecordMap.values();
            
            // Copy over the opportunity records - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
            List<TBO018_Pricing__c> pricingRecordList = new List<TBO018_Pricing__c>();
            
            for (TBO018_Pricing__c pricingRecord : [Select Id, Account_Name__c, TBO018_dv_Amount__c, TBO018_dv_ANI__c, TBO018_nu_ApprovalOrder__c, TBO018_ca_Approved_by_Risk__c, TBO018_pr_Book_Yield__c, TBO018_fm_Commercial_Support_Owner__c, TBO018_un_Contributed_Value__c, TBO018_pr_Cost_of_Funds_Levered__c, TBO018_pr_Cost_of_Funds_Unlevered__c, TBO018_rb_Credit_Approval__c, TBO018_fm_Credit_Approval_Status__c, TBO018_un_Depreciation__c, TBO018_tx_Description__c, TBO018_pr_Economic_ROE__c, TBO018_pr_Economic_ROI__c, TBO018_pr_Economic_Yield__c, TBO018_fm_EditPricing__c, TBO018_pr_Expense_ANI__c, TBO018_pr_Finance_Margin__c, TBO018_pr_Full_Term_Rate__c, TBO018_pr_Full_Term_Rate_w_Resid__c, TBO018_dv_Gross_margin__c, TBO018_pr_Lending_Rate__c, TBO018_pr_Leverage__c, TBO01_pr_Loss_ANI__c, TBO018_fh_Money_Cost_Date__c, TBO018_un_Net_Income__c, TBO018_pr_Opening_Fee__c, TBO018_rb_Opportunity__c, Opportunity_Owner__c, TPO018_fm_Opportunity_SFOP__c, TBO018_fh_Pricing_Fields__c, TBO018_tx_Pricing_Status__c, TBO018_tx_Product__c, TBO018_tx_Rate_Type__c, Region__c, TBO018_dv_Residual__c, TBO018_pr_Security_Deposit__c, TBO018_rb_SuperTRUMP_Pricing_Quote__c, TBO018_tx_Supertrump_Template__c, TBO018_rb_Takedowns__c, TBO018_un_Term__c, TBO018_ls_Type__c FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :this.creditApprovalRecord.Id AND TBO018_rb_Opportunity__c IN :oppRecordMap.keySet()]) {
                TBO018_Pricing__c newPricingRecord = pricingRecord.clone(false);
                
                System.debug('Opp Id Original Credit Approval: ' + pricingRecord.TBO018_rb_Opportunity__c);
                
                Opportunity currentOpportunity = oppRecordMap.get(pricingRecord.TBO018_rb_Opportunity__c);
                
                System.debug('Opp Id Credit Approval MOD: ' + currentOpportunity.Id);
                
                newPricingRecord.TBO018_rb_Opportunity__c = currentOpportunity.Id;
                
                IST__SuperTRUMP_Pricing_Quote__c currentPricingQuote = pricingQuoteRecordMap.get(pricingRecord.TBO018_rb_SuperTRUMP_Pricing_Quote__c);
                
                System.debug('Pricing Quote Id Credit Approval MOD: ' + currentPricingQuote.Id);
                
                newPricingRecord.TBO018_rb_SuperTRUMP_Pricing_Quote__c = currentPricingQuote.Id;
                
                newPricingRecord.TBO018_rb_Credit_Approval__c = newCreditApproval.Id;
                
                pricingRecordList.add(newPricingRecord);
            }
            
            System.debug('Pricing Record List: ' + pricingRecordList);
            
            insert pricingRecordList;
            */
        }
        catch (Exception exCloneCreditApproval) {
            Database.rollback(savePoint);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exCloneCreditApproval)));
            
            return null;
        }
        
        PageReference gotoNewCreditApproval = new PageReference('/' + newCreditApproval.Id); 
        gotoNewCreditApproval.setRedirect(true);
        
        return gotoNewCreditApproval;
    }
}