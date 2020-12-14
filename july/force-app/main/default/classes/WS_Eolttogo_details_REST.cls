@RestResource(urlMapping='/EOLToGo__c/*')
global  class WS_Eolttogo_details_REST {
    
    @HttpGet
    global static void geteolTogoById (){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');

        try {
            Id recordId = req.params.get('recordId');
            
            EOLToGo__c eol =[SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, RecordTypeId, 
            LastActivityDate, LastViewedDate, LastReferencedDate, Budget_Gain_on_Sales__c, 
            Budget_Year__c, Buy_Out_Return_All__c, Call_Option_Percentage__c, Call_Option__c, 
            Collateral_Insights__c, Collateral__c, Comments__c, Customer_Name__c, 
            Customer_Notification_Contact__c, Customer__c, EOL_Execution__c, EOL_R__c, 
            EOL_Recomendation_Comments__c, EOL_Strategic_Expert__c, Early_Buy_Out_Date__c, 
            Early_Buy_Out_EBO__c, Early_Buy_Out_Percentage__c, 
            Early_Termination_Notification_Days__c, End_of_Leasing_Date__c, 
            Estimated_Fair_Market_Value_RV__c, Evergreen_Extension__c, Evergreen_Paid__c, 
            Evergreen_Payments__c, Evergreen__c, Extension_Evergreen_In_Of_Months__c, 
            Fair_Market_Value_Amount__c, Gain_On_Sale__c, Higher_Of__c, Historic_Evergreen__c, 
            Last_Termination_Value_TV__c, Lock_Fee__c, Loss_Pool__c, 
            Notification_Days_In_Evergreen_Extension__c, Notification__c, 
            OLFM_Contract_Number__c, Originator_Name__c, Originator__c, 
            Prepayment_Penalty_Year_1__c, Prepayment_Penalty_Year_2__c, 
            Prepayment_Penalty_Year_3__c, Prepayment_Penalty_Year_4__c, Prepayment_Penalty_Year_5__c, 
            Product_Change__c, Purchase_Customer_Notification_Days__c, Purchase_Notification_Date__c, 
            Purchase_Option__c, Put_Option_Percentage__c, Put_Option__c, Release__c, Repurchase__c, 
            Residual_Value_Amount__c, Residual_Value__c, Return_Customer_Notification_Days__c, 
            Return_Notification_Date__c, Return__c, Revision_Status__c, Sale_To_Customer__c, 
            Side_Letter__c, Stage__c, Takedown_CP__c, This_Year_Budget_Evergreen__c, Vendor_Agreements_Comments__c, 
            Vendor_Name__c, Economic_Group__c, Transaction_End_Date__c, EOLIM__c, Side_Leter_Percentage__c, 
            Purchase_Option_Percentage__c, Originator_final__c, Customer_Final__c, Economic_Group_Name__c, 
            Economic_Group_Final__c, Region__c, Original_Equipment_Cost__c, Update_Date__c, Gain_on_Sale_Budget_Vs_Actual__c, 
            This_Year_Budget_Evergreen_amount__c, Evergreen_Pmts_Budget_Vs_Actual__c, Budget_EOL_Gain_GOS_EVG__c, 
            Actual_EOL_Gain_GOS_EVG__c, EOL_Gain_Budget_Vs_Actual__c, Contract_Annex__c, Unit__c, Line_of_Business__c, 
            Early_Termination__c, Sale_to_Customer_D__c, Release_D__c, Return_D__c, Product_Change_D__c, Email_originator__c, 
            Evergreen_P__c, Sale_to_Customer_P__c, Return_P__c, Release_P__c, Product_Change_P__c, Gain_On_Sale_Summary__c, 
            THis_Year_Budget_Gain_on_Sale__c, This_Year_Budget_Evergreen_MXN__c, THis_Year_Budget_Gain_on_Sale_MXN__c, Commercial__c, 
            Commercial_Collaboration_Level_Comments__c, Remarketing_Fee__c, Anticipated_Closing_Date__c, Budget_Amount__c, EVAL__c, 
            Early_Termination_Income_Projection__c, FMV_Amount__c, Full_Partial__c, Income_Amount__c, Income_Projection_Reason__c, 
            Portfolio_Notes__c, Probability__c, Sale_Renewal__c, Seller__c, Source__c, Federal_Local_Plates__c, 
            (SELECT Id,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastActivityDate,LastViewedDate,LastReferencedDate,EOLToGo__c,
            Decision_Type__c,Stage__c,Type__c,Early_Termination_Type__c,Seller__c,Anticipated_Close_Date__c,EVAL_Number__c,
            Probability__c,Source__c,Fair_Market_Value_FMV__c,Income_Amount__c,Comments__c,EOL_Strategic_Expert__c,Customer_Name__c,
            OLFM_Contract_number__c,Collateral__c,Line_of_Business__c,Anticipated_Close_Date_Quarter_Year__c,Income__c,Disposition_Date__c,
            Actual_Income__c FROM EOL_Decisions__r) FROM EOLToGo__c WHERE Id=:recordId LIMIT 1];
    
            res.responseBody = Blob.valueOf(JSON.serialize(eol));
        } catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST','Param: recordId is not a valid Id')
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', 'Requested Eol not found')
            };
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch(Exception e){
            res.statusCode = 500;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST', e.getMessage())
            };
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        }
    }
}