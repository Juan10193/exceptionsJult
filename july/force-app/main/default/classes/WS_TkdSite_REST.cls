@RestResource(urlMapping='/TKD_Site__c/*')
global class WS_TkdSite_REST {
    
    @HttpGet
    global static void getSiteById(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json;charset=UTF-8');
        string recordId = req.params.get('recordId');

        try {
            TKD_Site__c site =[SELECT Id, IsDeleted, Name, CurrencyIsoCode, Supplier__c, TKD_Vat_code__c, 
            TKD_Vendor_ID__c, TKD_Vendor_Site_ID__c, TKD_ls_State__c, TKD_tx_Country__c, 
            Tkd_at_Address_line_1__c, Tkd_at_Address_line_2__c, Tkd_ls_Country__c, Tkd_ls_Org_Name__c, 
            Tkd_tx_City__c, Tkd_tx_State__c, Tkd_tx_Zip__c, tkd_tf_phone__c, Pay_Site_Flag__c, 
            primaryPaySiteFlag__c, SR_ls_Custom_Currency__c, (SELECT Id, TKD_rb_Site__c, TKD_Vendor_Site_ID__c, 
            OwnerId, CreatedById, Email, Title, Department, Phone, Name, LastName, FirstName, 
            MiddleName FROM Contacts__r), (SELECT Id, OwnerId, Name, Bank_Name__c, 
            Bank_Account_Currency__c, Bank_Account_Name__c, Bank_Country__c, Mexican_Swift__c, ABA_Swift__c,
            Intermediary_Bnak_Name__c, Intermediary_Bank_Swift__c, Intermediary_Bank_Account_CLABE_IBAN__c, 
            FFC_Name__c, FFC_Ref__c, Cuenta__c, ABAswift__c, TKD_Vendor_Site_ID__c, TKD_rb_Site__c, 
            Codigo_BIC__c, Codigo__c, Contexto__c, Nombre_Banco_intermediadio__c, Pago_a_Cta_Concentradora_RN__c, 
            Pago_a_Cuenta_Concentradora__c, Tipo_BIC__c, Tipo__c, CurrencyIsoCode FROM Bank_Accounts__r) FROM TKD_Site__c WHERE Id =:recordId LIMIT 1];

            res.responseBody = Blob.valueOf(JSON.serialize(site));
        } catch (System.StringException e) {
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST','Param: recordId is not a valid Id')
            };
            res.statusCode =400;
            res.responseBody = Blob.valueOf(JSON.serialize(errs));
        } catch (System.QueryException e){
            res.statusCode = 404;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('NOT_FOUND', 'Requested Site not found')
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