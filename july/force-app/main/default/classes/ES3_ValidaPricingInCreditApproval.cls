public class ES3_ValidaPricingInCreditApproval {
    @AuraEnabled
    public static List<String> validatePricing(Id sourceCAId, Boolean flag)
    {
        List<String> retornoNew = new List<String>();
        
        try
        {
            List<Opportunity_in_Credit_approval_CP__c> opps = [Select id, CP_rb_Oportunidad__r.Name 
                                                               from Opportunity_in_Credit_approval_CP__c 
                                                               where CP_rb_Credit_approval_CP__c=: sourceCAId];
            
            
            if(opps.size()>0)
            {
                for(Opportunity_in_Credit_approval_CP__c op : opps)
                {
                    List<ES3_obj_Pricing_in_Credit_Approval__c> pricings;
                    pricings = [Select id, ES3_nu_Advance_PaymentPercent__c, ES3_tx_Appraisal__c, ES3_tx_Boot_Collateral__c,ES3_ls_EBO__c,ES3_ls_EFA__c,
                                ES3_nu_Grace_Period_in_Months__c,ES3_ls_Low_High_High_Low__c,ES3_ls_Progress_Payments__c,ES3_nu_Progress_Payments_M__c,ES3_pc_Remarketing_Fee_Percent__c,
                                ES3_nu_ROI_No_Insurance__c,ES3_ls_SL_B_YES_NO__c,ES3_pc_Split_Trac_Percentent__c,ES3_pc_Trac_Percent__c,ES3_ls_Type_of_Grace_Period__c,ES3_ls_Used_New__c
                                from ES3_obj_Pricing_in_Credit_Approval__c where 	ES3_rb_Opportunity_in_Credit_approval_CP__c =: op.id];
                    if(pricings == null || pricings.size()==0)
                    {
                        
                        retornoNew.add('Opportunity: ' + op.CP_rb_Oportunidad__r.Name + ' missing pricing\n');
                    }
                    else
                    {
                        if(flag)
                        {
                            for(ES3_obj_Pricing_in_Credit_Approval__c  pricingIncreditApproval : pricings)
                            {
                                if(//String.isBlank(creditApproval.ES3_nu_Advance_Payment__c) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_tx_Appraisal__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_tx_Boot_Collateral__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_ls_Boot_Collateral_Type__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_EBO__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_EFA__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_nu_Grace_Period_in_Months__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_Low_High_High_Low__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_ls_Progress_Payments__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_nu_Progress_Payments_M__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_pc_Remarketing_Fee__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_nu_ROI_No_Insurance__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_SL_B_YES_NO__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_pc_Split_Trac__c ) ||
                                    //String.isBlank(pricingIncreditApproval.ES3_pc_Trac__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_Type_of_Grace_Period__c ) ||
                                    String.isBlank(pricingIncreditApproval.ES3_ls_Used_New__c ) )  
                                {
                                    
                                    retornoNew.add('Opportunity: ' + op.CP_rb_Oportunidad__r.Name + ' missing pricing fields\n');
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        Catch(Exception e)
        {
            
            retornoNew.add('ERROR, you can not check the opportunities');
        }
        
        return retornoNew;
    }
    
    @AuraEnabled
    public static Map< String, Boolean > getButtonsCA(String StatusCA)
    {
        System.debug('STATUSCA: ' + StatusCA);
        Map<String,Boolean> result = new Map<String,Boolean>();
        result.put('ES3_BUTTON_SEND_TO_RISK__C',false);
        result.put('ES3_BUTTON_SEND_TO_AML__C',false);
        result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C',false);
        result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_AML__C',false);
        result.put('ES3_BUTTON_REWORK_RISK__C',false);
        result.put('ES3_BUTTON_REWORK_AML__C',false);
        result.put('ES3_BUTTON_SET_ON_HOLD_RISK__C',false);
        result.put('ES3_BUTTON_SET_ON_HOLD_AML__C',false);
        result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_RISK__C',false);
        result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_AML__C',false);
        result.put('ES3_BUTTON_APPROVE__C',false);
        result.put('ES3_BUTTON_DECLINED_RISK__C',false);
        result.put('ES3_BUTTON_DECLINED_AML__C',false);
        result.put('ES3_BUTTON_WITHDRAWN_RISK__C',false);
        result.put('ES3_BUTTON_WITHDRAWN_AML__C',false);
        result.put('ES3_BUTTON_SUBMIT_FOR_APPROVAL_RISK__C',false);
        result.put('ES3_Button_Rework_for_entities_AML__c',false);
        result.put('ES3_Button_Rework_for_entities_RISK__c',false);
        
            
        List<ES3_Credit_Approval_Buttons__c> CAButton = new List<ES3_Credit_Approval_Buttons__c>();
        
        try
        {
            String statusRISK = [SELECT ES3_ls_RISK_REVIEW_STATUS__c FROM Credit_approval_CP__c WHERE Id =:StatusCA].ES3_ls_RISK_REVIEW_STATUS__c;
        	String statusAML = [SELECT ES3_ls_AML_Review_Status__c FROM Credit_approval_CP__c WHERE Id =:StatusCA].ES3_ls_AML_Review_Status__c;
            String typeCA= [SELECT RecordType.name FROM Credit_approval_CP__c WHERE Id=: StatusCA].RecordType.name; 
            
            List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
            
            String MyProflieName = PROFILE[0].Name;
            system.debug('JD: Profile ' + MyProflieName);
            system.debug('JD: CONSULTA' + statusRISK + ' ' +  statusAML);
            CAButton = 
                [Select ES3_BUTTON_SEND_TO_RISK__C, ES3_BUTTON_SEND_TO_AML__C,ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C,ES3_BUTTON_ACCEPT_TO_REVIEW_AML__C,
                 ES3_BUTTON_REWORK_RISK__C,ES3_BUTTON_REWORK_AML__C,ES3_BUTTON_SET_ON_HOLD_RISK__C,ES3_BUTTON_SET_ON_HOLD_AML__C,ES3_BUTTON_BACK_TO_IN_PROCESS_RISK__C,
                 ES3_BUTTON_BACK_TO_IN_PROCESS_AML__C,ES3_BUTTON_APPROVE__C,ES3_BUTTON_DECLINED_RISK__C,ES3_BUTTON_DECLINED_AML__C,ES3_BUTTON_WITHDRAWN_RISK__C,
                 ES3_BUTTON_WITHDRAWN_AML__C,ES3_BUTTON_SUBMIT_FOR_APPROVAL_RISK__C, ES3_Button_Rework_for_entities_AML__c,ES3_Button_Rework_for_entities_RISK__c
                 from ES3_Credit_Approval_Buttons__c where ES3_Status_to_RISK__c =: statusRISK and ES3_STATUS_AML__C =: statusAML and ES3_TX_PERFIL__C =: MyProflieName and MC3_TYPE_OF_CA__c =: typeCA];
            system.debug('JD: CONSULTA BOTONES ' +CAButton );
            if(CAButton.size()==1)
            {
                result = null;
                result = new Map<String,Boolean>();
                result.put('ES3_BUTTON_SEND_TO_RISK__C',CAButton[0].ES3_BUTTON_SEND_TO_RISK__C);
                result.put('ES3_BUTTON_SEND_TO_AML__C',CAButton[0].ES3_BUTTON_SEND_TO_AML__C);
                result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C',CAButton[0].ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C);
                result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_AML__C',CAButton[0].ES3_BUTTON_ACCEPT_TO_REVIEW_AML__C);
                result.put('ES3_BUTTON_REWORK_RISK__C',CAButton[0].ES3_BUTTON_REWORK_RISK__C);
                result.put('ES3_BUTTON_REWORK_AML__C',CAButton[0].ES3_BUTTON_REWORK_AML__C);
                result.put('ES3_BUTTON_SET_ON_HOLD_RISK__C',CAButton[0].ES3_BUTTON_SET_ON_HOLD_RISK__C);
                result.put('ES3_BUTTON_SET_ON_HOLD_AML__C',CAButton[0].ES3_BUTTON_SET_ON_HOLD_AML__C);
                result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_RISK__C',CAButton[0].ES3_BUTTON_BACK_TO_IN_PROCESS_RISK__C);
                result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_AML__C',CAButton[0].ES3_BUTTON_BACK_TO_IN_PROCESS_AML__C);
                result.put('ES3_BUTTON_APPROVE__C',CAButton[0].ES3_BUTTON_APPROVE__C);
                result.put('ES3_BUTTON_DECLINED_RISK__C',CAButton[0].ES3_BUTTON_DECLINED_RISK__C);
                result.put('ES3_BUTTON_DECLINED_AML__C',CAButton[0].ES3_BUTTON_DECLINED_AML__C);
                result.put('ES3_BUTTON_WITHDRAWN_RISK__C',CAButton[0].ES3_BUTTON_WITHDRAWN_RISK__C);
                result.put('ES3_BUTTON_WITHDRAWN_AML__C',CAButton[0].ES3_BUTTON_WITHDRAWN_AML__C);
                result.put('ES3_BUTTON_SUBMIT_FOR_APPROVAL_RISK__C',CAButton[0].ES3_BUTTON_SUBMIT_FOR_APPROVAL_RISK__C);                
                result.put('ES3_Button_Rework_for_entities_AML__c',CAButton[0].ES3_Button_Rework_for_entities_AML__c);
                result.put('ES3_Button_Rework_for_entities_RISK__c',CAButton[0].ES3_Button_Rework_for_entities_RISK__c);
            	system.debug('JD: BOTN ACEPTRISK: '+ CAButton[0].ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C);
            }
            else if (MyProflieName == 'System Administrator' || MyProflieName == 'Administrador del sistema' || MyProflieName == 'Administrator' || MyProflieName == 'Administrador')
            {
                result = null;
                result = new Map<String,Boolean>();
                result.put('ES3_BUTTON_SEND_TO_RISK__C',true);
                result.put('ES3_BUTTON_SEND_TO_AML__C',true);
                result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_RISK__C',true);
                result.put('ES3_BUTTON_ACCEPT_TO_REVIEW_AML__C',true);
                result.put('ES3_BUTTON_REWORK_RISK__C',true);
                result.put('ES3_BUTTON_REWORK_AML__C',true);
                result.put('ES3_BUTTON_SET_ON_HOLD_RISK__C',true);
                result.put('ES3_BUTTON_SET_ON_HOLD_AML__C',true);
                result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_RISK__C',true);
                result.put('ES3_BUTTON_BACK_TO_IN_PROCESS_AML__C',true);
                result.put('ES3_BUTTON_APPROVE__C',true);
                result.put('ES3_BUTTON_DECLINED_RISK__C',true);
                result.put('ES3_BUTTON_DECLINED_AML__C',true);
                result.put('ES3_BUTTON_WITHDRAWN_RISK__C',true);
                result.put('ES3_BUTTON_WITHDRAWN_AML__C',true);
                result.put('ES3_BUTTON_SUBMIT_FOR_APPROVAL_RISK__C',true);   
                result.put('ES3_Button_Rework_for_entities_AML__c',true);
                result.put('ES3_Button_Rework_for_entities_RISK__c',true);
            }
            else
            {
                System.debug('OEJ, No hay registros para la consulta o hay mas de un registro con las mismas llaves para los botones del CA');
            }
        }
        Catch(Exception e)	
        {
            System.debug('OEJ, Hubo un error en la consulta de los permisos de los botones del CA');

        }
        return result;
    }
    
    
      @AuraEnabled
    public static Map<String,integer> tollgateDocsAml(string sourceCAId){
      String searchRequestId='999999999';
            string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            
            
            req.setTimeout(20000);
            req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            system.debug('respuesta:--->' +  res.getBody());
            Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
            system.debug('resultsMap--' +  resultsMap);
            Map<string,object>docListMap = (Map<string,object>)resultsMap.get('documentsList');
     		list<object>documentList =null;
     		if((Map<string,object>)resultsMap.get('documentsList')==null){
         		documentList =new list<object>();
            }else{
                documentList = (list<object>)docListMap.get('document');     
            }
            
            list<string>listaDocF = new list<string>();
            
            integer ind = 2;
            for(object doc:documentList){
                Map<string,object>newDoc = (Map<string,object>)doc;
                Map<string,object>docum = (Map<string,object>)newDoc;
                
                string doctype = string.valueOf(newDoc.get('type'));
                if(listaDocF.contains(doctype)){
                
                }else{
                    listaDocF.add(doctype);
                }
            }
            
            system.debug('listaDocF====>' + listaDocF);
        //Credit_approval_CP__c tipo = [Select Type_of_credit_approval__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
        Credit_approval_CP__c getLostiposDoc;
        string tiposdocum;
            getLostiposDoc = test.isRunningTest()? new Credit_approval_CP__c() : [Select DoctypesAML__c, MC3_tx_DoctypesAMLMAC__c, Type_of_credit_approval__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            
            tiposdocum =test.isRunningTest()? 'Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up","Fast Track", "Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up","MOD", "Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up'
                				:string.valueOf(getLostiposDoc.Type_of_credit_approval__c == 'MAC' ?getLostiposDoc.MC3_tx_DoctypesAMLMAC__c : getLostiposDoc.DoctypesAML__c);
        system.debug('trae ' + tiposdocum);
        
            List<string>listaSDoc = tiposdocum.split(',');
            list<string>faltan = new list<string>();
        system.debug('faltan ' + faltan);
            for(string o : listaSDoc){
                boolean bandera = listaDocF.contains(o);
                
                if(bandera==false){
                    faltan.add(o.replaceAll('[^a-zA-Z- ]',''));
                }
            }
            Map<String,integer> elCount = new Map<String,Integer>();
            for(string key : faltan){
                if(!elCount.containsKey(key)){
                    elCount.put(key,0);
                }
                Integer currentInt=elCount.get(key)+1;
                elCount.put(key,currentInt);
            }
            
            
           /* string mensaje =  string.valueOf(elCount);
            system.debug('ELCOUNT--->: ' + elCount );
            string mensaje2 = mensaje.replace('}','');
            string mensaje3 = mensaje2.replace('{','');
            mensaje3=mensaje3.replaceAll('=','');
            mensaje3=mensaje3.replaceAll('1','');
            //string mensajeUltimo =mensaje3.replace(',','\n');
            string mensajeUltimo =mensaje3;
                system.debug('Mensaje ===>>>>' + mensajeUltimo);
         string warningDocs = mensajeUltimo;
        system.debug('documentos: ' +warningDocs);*/
        
        
     Map<String,integer> resultfinal=elCount;
    /* if(elCount.containsKey('Write Up')){
         resultfinal='No';
             }else{
                 resultfinal='YES';
                 Credit_approval_CP__c status =[SELECT CPL_ls_StageName__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
                 status.CPL_ls_StageName__c='Approved with closing memo';
                 update status;
             }*/


        return resultfinal;
    }

    @AuraEnabled
    public static Map<String,integer> tollgateDocs(string sourceCAId){
      String searchRequestId='999999999';
            string sServiceURL = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            
            
            req.setTimeout(20000);
            req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            system.debug('respuesta:--->' +  res.getBody());
            Map<string,object> resultsMap = (Map<string,object>)JSON.deserializeUntyped(res.getBody());
            system.debug('resultsMap--' +  resultsMap);
            Map<string,object>docListMap = (Map<string,object>)resultsMap.get('documentsList');
     		list<object>documentList =null;
     		if((Map<string,object>)resultsMap.get('documentsList')==null){
         		documentList =new list<object>();
            }else{
                documentList = (list<object>)docListMap.get('document');     
            }
            
            list<string>listaDocF = new list<string>();
            
            integer ind = 2;
            for(object doc:documentList){
                Map<string,object>newDoc = (Map<string,object>)doc;
                Map<string,object>docum = (Map<string,object>)newDoc;
                
                string doctype = string.valueOf(newDoc.get('type'));
                if(listaDocF.contains(doctype)){
                
                }else{
                    listaDocF.add(doctype);
                }
            }
            
            system.debug('listaDocF====>' + listaDocF); 
        
        //Credit_approval_CP__c tipo = [Select Type_of_credit_approval__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
        Credit_approval_CP__c getLostiposDoc;
        string tiposdocum;
        
            getLostiposDoc = test.isRunningTest()? new Credit_approval_CP__c() : [Select Doctypes__c, MC3_tx_DoctypesRiskMac__c, Type_of_credit_approval__c from Credit_approval_CP__c where Credit_approval_CP__c.Id =:sourceCAId];
            tiposdocum =test.isRunningTest()? 'Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up","Fast Track", "Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up","MOD", "Commercial Proposal,Good Faith Deposit (GFD),E-Val for Prospect,Pricing for Prospect,OTHERS SALES,Customer Visit,Financial Statements,KYC documents,Identification Documents,Legal Assesment,Background Documents,Spreads,Public Deed,Credit Bureau Report,Write Up'
                				:string.valueOf(getLostiposDoc.Type_of_credit_approval__c == 'MAC' ?getLostiposDoc.MC3_tx_DoctypesRiskMac__c : getLostiposDoc.get('Doctypes__c'));
            List<string>listaSDoc = tiposdocum.split(',');
        system.debug('son ' + listaSDoc);
            list<string>faltan = new list<string>();
            for(string o : listaSDoc){
                boolean bandera = listaDocF.contains(o);
                
                if(bandera==false){
                    faltan.add(o.replaceAll('[^a-zA-Z- ]',''));
                    system.debug('faltan ' + faltan);
                }
            }
            Map<String,integer> elCount = new Map<String,Integer>();
            for(string key : faltan){
                if(!elCount.containsKey(key)){
                    elCount.put(key,0);
                }
                Integer currentInt=elCount.get(key)+1;
                elCount.put(key,currentInt);
            }
            
            
           /* string mensaje =  string.valueOf(elCount);
            system.debug('ELCOUNT--->: ' + elCount );
            string mensaje2 = mensaje.replace('}','');
            string mensaje3 = mensaje2.replace('{','');
            mensaje3=mensaje3.replaceAll('=','');
            mensaje3=mensaje3.replaceAll('1','');
            //string mensajeUltimo =mensaje3.replace(',','\n');
            string mensajeUltimo =mensaje3;
                system.debug('Mensaje ===>>>>' + mensajeUltimo);
         string warningDocs = mensajeUltimo;
        system.debug('documentos: ' +warningDocs);*/
        
        
     Map<String,integer> resultfinal=elCount;
    /* if(elCount.containsKey('Write Up')){
         resultfinal='No';
             }else{
                 resultfinal='YES';
                 Credit_approval_CP__c status =[SELECT CPL_ls_StageName__c FROM Credit_approval_CP__c WHERE Credit_approval_CP__c.Id =:sourceCAId];
                 status.CPL_ls_StageName__c='Approved with closing memo';
                 update status;
             }*/


        return resultfinal;
    }
    
    @AuraEnabled
    public static List<String> validateConditions(string sourceCAId, String nameButton)
    {
        //Variable para guardar los errores
        List<String> returnErrors = new List<String>();
        //Extraemos los parametros y CA
        try
        {
            Credit_approval_CP__c CA = [SELECT ES2_re_Obligor__c,
                                        ES3_tx_AML_On_Hold_Comment__c,
                                        ES3_mpl_On_Hold_Reason__c,
                                        ES2_re_Guarantor__c,
                                        RecordType.Name,
                                        ES2_re_Risk_Desicion_Entity__c,
                                        CPL_fm_Opportunities_in_credit_approval__c,
                                        ES3_Approve_WC_Comments__c,
                                        ES3_ls_AML_Review_Status__c,
                                        ES3_mpl_AML_Declined_reason__c,
                                        ES3_tx_AML_Rework_Comment__c,
                                        ES3_pl_AML_Rework_reason__c,
                                        ES3_tx_RISK_Declined_Comment__c,
                                        ES3_mpl_RISK_Declined_Reason__c,
                                        ES3_tx_RISK_On_Hold_Comment__c,
                                        ES3_mpl_RISK_On_Hold_Reason__c,
                                        ES3_tx_Risk_Rework_Comment__c,
                                        ES3_ls_RISK_REVIEW_STATUS__c,
                                        ES3_pl_Risk_Rework_reason__c,
                                        CPI_ls_Reason_Lost_Level_1__c,
                                        CPI_ls_Reason_Lost_Level_2__c,
                                        CPI_ls_Reason_Lost_Level_3__c,
                                        CPI_rb_Competitor__c,
                                        CPI_tx_Lost_Comments__c,
                                        ES3_pl_AML_Declined_Comment__c,
                                        Approval_Level__c,
                                        Exposure__c,
                                        Type_of_credit_approval__c,
                                        CPI_rb_Risk_Classification__c,
                                        CPI_tx_Customer_Since__c,
                                        CPI_rb_OR_rating__c,
                                        CPI_tx_Risk_Economic_Group__c,
                                        CPI_rb_SIC_code__c,
                                        CPI_rb_OR_Override__c,
                                        CPI_rb_OR_Override__r.name,
                                        MC3_date_New_Expiration_Date__c,
                                        ES3_TX_HNWI_ID__c,
                                        Override_Reason__c,
                                        ES3_TX_MRA_ID__c,
                                        ES3_tx_Bloomberg_ID__c,
                                        MD_Current_Exposure__c,
                                        MOD_Carveount_In_Ca__c
                                        FROM Credit_approval_CP__c
                                        WHERE Credit_approval_CP__c.Id =: sourceCAId][0];            
            
            List<EIV_Parameter__c> params;
            
            if(CA.Type_of_credit_approval__c=='MAC'){
                params= [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                                             where name =: nameButton 
                                             AND EIV_TX_PARAMETER__c LIKE '%MACConditions:%' ORDER BY EIV_TX_PARAMETER__c];
            
            }else if(CA.Type_of_credit_approval__c=='MOD/MAC'){
                params= [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                                             where name =: nameButton 
                                             AND EIV_TX_PARAMETER__c LIKE '%MODCondition:%' ORDER BY EIV_TX_PARAMETER__c];
            
            
            
            } else {
                params= [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                         where name =: nameButton 
                         AND (not EIV_TX_PARAMETER__c LIKE '%MODCondition:%') 
                         AND (not EIV_TX_PARAMETER__c LIKE '%MACConditions:%') 
                         AND (EIV_TX_PARAMETER__c LIKE '%Condition:%')  
                         ORDER BY EIV_TX_PARAMETER__c];
            }/*else
            
            {
                params= [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                                             where name =: nameButton 
                                             AND EIV_TX_PARAMETER__c LIKE '%Condition:%' ORDER BY EIV_TX_PARAMETER__c];
            }*/
            
            
                     
            
            System.debug('params OEJ:' + params);
            
            for(EIV_Parameter__c param : params)
            {
                System.debug('Entramos al for de parametros OEJ:' + param.EIV_TX_PARAMETER__c);
                String[] condition = param.EIV_TX_PARAMETER__c.split(':', 2);
                System.debug('OEJ Split:' + condition);
                System.debug('OEJ CA:' + CA);
                //Validar que se tenga al menos una oportunidad
                if(condition[1]=='oppsInCA>1' && CA.CPL_fm_Opportunities_in_credit_approval__c==0 )
                {
                    returnErrors.add('Opportunities are required\n');
                }
                  
                //Validar que se tenga al menos un pricing por cada oportunidad y que todos los pricings tengan todos los campos llenos
                //
                if(condition[1]=='pricingInAllOpps')
                {
                    List<String> result = validatePricing(CA.id,false);
                    if(result.size()>0)
                    {
                        returnErrors.addAll(result);
                    }  
                }                
                
                if(condition[1]=='pricingAllFields')
                {
                    List<String> result = validatePricing(CA.id,true);
                    if(result.size()>0)
                    {
                        returnErrors.addAll(result);
                    }  
                    
                }  
                //MC3_date_New_Expiration_Date__c
                if(condition[1]=='expirationDate' && String.isBlank(String.valueOf(CA.MC3_date_New_Expiration_Date__c)))
                {
                        returnErrors.add('New Expiration Date is required\n');
                } 
                    if(condition[1]=='obligor>1' && CA.ES2_re_Obligor__c==0)
                    {
                        returnErrors.add('An Obligor is required\n');
                    }  
                
                if(condition[1]=='RiskDesicionEntiti>1' && CA.ES2_re_Risk_Desicion_Entity__c==0)
                {
                    returnErrors.add('An Risk Descision Entity is required\n');
                }                 
                if(condition[1]=='ES3_Approve_WC_Comments__cNoVacio' && String.isBlank(CA.ES3_Approve_WC_Comments__c))
                {
                    returnErrors.add('Approve Comments AML is required\n');
                }  
                if(condition[1]=='ES3_ls_AML_Review_Status__cOnHold' && CA.ES3_ls_AML_Review_Status__c != 'On Hold')
                {
                    returnErrors.add('AML status should be on hold\n');
                }                
                if(condition[1]=='ES3_mpl_AML_Declined_reason__cNoVacio' && String.isBlank(CA.ES3_mpl_AML_Declined_reason__c))
                {
                    returnErrors.add('AML Declined Reason is required\n');
                }  
                if(condition[1]=='ES3_pl_AML_Declined_Comment__cNoVacio' && String.isBlank(CA.ES3_pl_AML_Declined_Comment__c))
                {
                    returnErrors.add('AML Declined Comment is required\n');
                }  
                if(condition[1]=='ES3_tx_AML_On_Hold_Comment__cNoVacio' && String.isBlank(CA.ES3_tx_AML_On_Hold_Comment__c))
                {
                    returnErrors.add('AML On Hold Comment is required\n');
                }  
                if(condition[1]=='ES3_mpl_On_Hold_Reason__cNoVacio' && String.isBlank(CA.ES3_mpl_On_Hold_Reason__c))
                {
                    returnErrors.add('AML On Hold Reason is required\n');
                }  
                if(condition[1]=='ES3_tx_AML_Rework_Comment__cNoVacio' && String.isBlank(CA.ES3_tx_AML_Rework_Comment__c))
                {
                    returnErrors.add('AML Rework Comment is required\n');
                }                  
             
                if(condition[1]=='ES3_pl_AML_Rework_reason__cNoVacio' && String.isBlank(CA.ES3_pl_AML_Rework_reason__c))
                {
                    returnErrors.add('AML Rework Reason is required\n');
                } 
                if(condition[1]=='ES3_tx_RISK_Declined_Comment__cNoVacio' && String.isBlank(CA.ES3_tx_RISK_Declined_Comment__c))
                {
                    returnErrors.add('RISK Declined Comment is required\n');
                } 
                if(condition[1]=='ES3_mpl_RISK_Declined_Reason__cNoVacio' && String.isBlank(CA.ES3_mpl_RISK_Declined_Reason__c))
                {
                    returnErrors.add('RISK Declined Reason is required\n');
                } 
                if(condition[1]=='ES3_tx_RISK_On_Hold_Comment__cNoVacio' && String.isBlank(CA.ES3_tx_RISK_On_Hold_Comment__c))
                {
                    returnErrors.add('RISK On Hold Comment is required\n');
                } 
                if(condition[1]=='ES3_mpl_RISK_On_Hold_Reason__cNoVacio' && String.isBlank(CA.ES3_mpl_RISK_On_Hold_Reason__c))
                {
                    returnErrors.add('RISK On Hold Reason is required\n');
                }                 
                if(condition[1]=='ES3_tx_Risk_Rework_Comment__cNoVacio' && String.isBlank(CA.ES3_tx_Risk_Rework_Comment__c))
                {
                    returnErrors.add('Risk Rework Comment is required\n');
                }   
                if(condition[1]=='ES3_pl_Risk_Rework_reason__cNoVacio' && String.isBlank(CA.ES3_pl_Risk_Rework_reason__c))
                {
                    returnErrors.add('Risk Rework Reason is required\n');
                }   
                if(condition[1]=='ES3_ls_RISK_REVIEW_STATUS__cOnHold' && CA.ES3_ls_RISK_REVIEW_STATUS__c != 'On Hold')
                {
                    returnErrors.add('Risk Review Status no is On Hold');
                } 
                if(condition[1]=='CPI_ls_Reason_Lost_Level_1__cNoVacio' && String.isBlank(CA.CPI_ls_Reason_Lost_Level_1__c))
                {
                    returnErrors.add('Reason Lost 1 is required\n');
                }
                if(condition[1]=='CPI_ls_Reason_Lost_Level_2__cNoVacio' && String.isBlank(CA.CPI_ls_Reason_Lost_Level_2__c))
                {
                    returnErrors.add('Reason Lost 2 is required\n');
                }
                if(condition[1]=='CPI_ls_Reason_Lost_Level_3__cNoVacio' && String.isBlank(CA.CPI_ls_Reason_Lost_Level_3__c))
                {
                    returnErrors.add('Reason Lost 3 is required\n');
                }
                if(condition[1]=='CPI_rb_Competitor__cNoVacio' && String.isBlank(CA.CPI_rb_Competitor__c))
                {
                    returnErrors.add('Competitor is required\n');
                }
                if(condition[1]=='CPI_tx_Lost_Comments__cNoVacio' && String.isBlank(CA.CPI_tx_Lost_Comments__c))
                {
                    returnErrors.add('Lost Comments is required\n');
                }
                if(condition[1]=='Approval_Level__cNoVacio' && String.isBlank(CA.Approval_Level__c))
                {
                    returnErrors.add('Approval Level is required\n');
                }
                if(condition[1]=='Exposure__cNoVacio' && String.isBlank(String.valueof(CA.Exposure__c)))
                {
                    returnErrors.add('Total Exposure is required\n');
                }
                if(condition[1]=='CPI_rb_Risk_Classification__cNoVacio' && String.isBlank(CA.CPI_rb_Risk_Classification__c))
                {
                    returnErrors.add('Risk Classification is required\n');
                }
                if(condition[1]=='CPI_tx_Customer_Since__cNoVacio' && String.isBlank(CA.CPI_tx_Customer_Since__c))
                {
                    returnErrors.add('Customer Since is required\n');
                }
                if(condition[1]=='ES3_TX_HNWI_ID__cNoVacio' && (String.isBlank(CA.ES3_TX_HNWI_ID__c) && String.isBlank(CA.ES3_TX_MRA_ID__c) && String.isBlank(CA.ES3_tx_Bloomberg_ID__c)))
                {
                    returnErrors.add('MRA ID OR Bloomberg ID OR HNWI ID is required\n');
                }
                
                if(condition[1]=='CPI_rb_SIC_code__cNoVacio' && String.isBlank(CA.CPI_rb_SIC_code__c))
                {
                    returnErrors.add('SIC code in Economic Group selected is required\n');
                }
                if(condition[1]=='CPI_tx_Risk_Economic_Group__cNoVacio' && String.isBlank(CA.CPI_tx_Risk_Economic_Group__c))
                {
                    returnErrors.add('Risk Economic Group is required\n');
                }
                //mod
                if(condition[1]=='MD_Current_Exposure__cNoVacio' && String.isBlank(String.valueof(CA.MD_Current_Exposure__c)))
                {
                    returnErrors.add('Current Exposure is required\n');
                }
                if(condition[1]=='CPI_rb_OR_rating__cNoVacio' && String.isBlank(CA.CPI_rb_OR_rating__c))
                {
                    returnErrors.add('Approval OR Rating is required\n');
                }
                if(condition[1]=='CPI_rb_OR_Override__cNoVacio' && String.isBlank(CA.CPI_rb_OR_Override__c))
                {
                    returnErrors.add('Or Override is required\n');
                }
                if(condition[1]=='Override_Reason__cNoVacio' && String.isBlank(CA.Override_Reason__c))
                {
                    returnErrors.add('Override Reason is required\n');
                }
                
            }
        }
         Catch(Exception e)
        {         
           returnErrors.add('No se encontro la configuración del botón ' + nameButton + ' Error:' + e.getStackTraceString());
            system.debug('No se encontro la configuración del botón ' + nameButton + ' Error:' + e.getStackTraceString());
        }
        return returnErrors;
    }
    @AuraEnabled
    public static List<String> executeAccions(string sourceCAId, String nameButton)
    {
        //Variable para guardar los errores
        List<String> returnErrors = new List<String>();
        
        try
        {
            Credit_approval_CP__c CA2 = [SELECT Type_of_credit_approval__c
                                        FROM Credit_approval_CP__c
                                        WHERE Credit_approval_CP__c.Id =: sourceCAId][0];
            List<EIV_Parameter__c> params;
            if(CA2.Type_of_credit_approval__c == 'MAC'){
                params = [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                                             where name =: nameButton 
                                             AND EIV_TX_PARAMETER__c LIKE '%Updates:%' ORDER BY EIV_TX_PARAMETER__c];
           
            }else{
                params = [Select name, EIV_TX_PARAMETER__c from EIV_Parameter__c 
                                             where name =: nameButton 
                                             AND EIV_TX_PARAMETER__c LIKE '%Update:%' ORDER BY EIV_TX_PARAMETER__c];
            }
            
            
            Credit_approval_CP__c CA = new Credit_approval_CP__c(id=sourceCAId);
            for(EIV_Parameter__c param : params)
            {
                String[] sUpdate = param.EIV_TX_PARAMETER__c.split(':', 2);
                String[] field_value = sUpdate[1].split('=', 2);
                System.debug('OEJ Update : ' + field_value);
                
                if(field_value[0] == 'ES3_ls_AML_Review_Status__c')
                {
                 	CA.ES3_ls_AML_Review_Status__c = field_value[1];
                }
                if(field_value[0] == 'ES3_ls_RISK_REVIEW_STATUS__c')
                {
                 	CA.ES3_ls_RISK_REVIEW_STATUS__c = field_value[1];
                }    
                if(field_value[0] == 'RecordTypeId')
                {
                    CA.RecordTypeId = field_value[1];
                }   
                if(field_value[0] == 'CPL_ls_StageName__c')
                {
                    CA.CPL_ls_StageName__c = field_value[1];
                }   
                if(field_value[0] == 'SP3_pl_Credit_Approval_Status__c')
                {
                    CA.SP3_pl_Credit_Approval_Status__c = field_value[1];
                }
                if(field_value[0] == 'Decision_Date__c')
                {
                    CA.Decision_Date__c = System.today();
                } 
                
                
            }
            update CA;
        }
        Catch(Exception e)
        {         
            returnErrors.add('No se pudo actualizar el estado del Credit Approval ' + nameButton + ' Error:' + e);
        }
        return returnErrors;
    }
    
    @AuraEnabled
    public static string reloadpage(string CAId){
        String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/lightning/r/Credit_approval_CP__c/' +CAId;
        return fullRecordURL;
    }
}