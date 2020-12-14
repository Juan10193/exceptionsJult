public class EM_UpdateInvoices {
    public static List<String> UpdateEntity(EIV_InvoicingWrapClass invoicingObj, List<EIV_InvoicingWrapClass> invoicing, List<EIV_AddressWrapClass> address, string sso){
        system.debug('invoicing get ' + invoicing);
        system.debug('invoicingObj ' + invoicingObj);
        List<EIV_InvoicingWrapClass> UpdateInvoice = new List<EIV_InvoicingWrapClass>();         
        for(EIV_AddressWrapClass addr : address){
            if(addr.Purpose.equals('BILL_TO, SHIP_TO, INSTALL_AT')){
            	for(EIV_InvoicingWrapClass invoice : invoicing){
                    system.debug('invoice ' + invoice.EC_Operating_Unit_Name.contains(invoicingObj.EC_Operating_Unit_Name.right(3)));
                    system.debug('invoice.p_cust_acct_site_id ' + invoice.p_cust_acct_site_id);
                    system.debug('invoicingObj.p_cust_acct_site_id ' + invoicingObj.p_cust_acct_site_id);
                    if(invoice.EC_Operating_Unit_Name.contains(invoicingObj.EC_Operating_Unit_Name.right(3)) && (invoice.p_cust_acct_site_id != invoicingObj.p_cust_acct_site_id)){
                    	UpdateInvoice.add(invoice);                  	   
                    }
        		}     
            }                       
        }
       system.debug('listInvoiceToUpdate ' + UpdateInvoice);
       list<String> listJson = new list<String>();
       for(EIV_InvoicingWrapClass invoice : UpdateInvoice){
			invoice.EC_Payment_Account = invoicingObj.EC_Payment_Account;
            invoice.EC_CLABE = invoicingObj.EC_CLABE;
            invoice.Billing_Mails = invoicingObj.Billing_Mails;
            invoice.Payment_Method = invoicingObj.Payment_Method;
           	listJson.add(invoicingToJson(invoice,sso));
        }
        
        system.debug('listInvoiceToUpdate ' + UpdateInvoice);
        
        //EIV_EntityExtendClassBis extendClassBis = new EIV_EntityExtendClassBis();
        /*for(EIV_InvoicingWrapClass invoice : UpdateInvoice){
            listJson.add(invoicingToJson(invoice,sso));
        }*/
        return listJson;
         
    }

    public static String invoicingToJson(EIV_InvoicingWrapClass invoiceObj,string sso)
    {
        system.debug('this.invoicingObj.EC_Operating_Unit_Name ' + invoiceObj.EC_Operating_Unit_Name);
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject();      
        gen.writeFieldName('invoice');
        gen.writeStartObject(); 
        gen.writeStringField('custAcctSiteId' , nullToVoid(invoiceObj.p_cust_acct_site_id));
        gen.writeStringField('partyID' , ''); //Se enviara siempre vacio
        gen.writeStringField('invoiceId' , ''); //Se enviara siempre vacio
        gen.writeStringField('ecOperatingUnitName' , nullToVoid(invoiceObj.EC_Operating_Unit_Name));
        gen.writeStringField('ecOperatingUnitId' , ''); //Se enviara siempre vacio
        gen.writeStringField('ecClabe' , nullToVoid(invoiceObj.EC_CLABE));
        gen.writeStringField('ecPaymentAccount' , nullToVoid(invoiceObj.EC_Payment_Account));
        gen.writeStringField('paymentMethod' , nullToVoid(invoiceObj.Payment_Method));
        gen.writeStringField('billingMails' , nullToVoid(invoiceObj.Billing_Mails));
        gen.writeStringField('sourceCreatedBy' , nullToVoid(sso));
        gen.writeStringField('sourceUpdatedBy' , nullToVoid(sso));
        gen.writeStringField('sourceApplicationId' , 'SF');
        gen.writeStringField('sourceCreateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeStringField('sourceLastUpdateDate' , nullToVoid(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00')));
        gen.writeEndObject();    
        String jsonS = gen.getAsString();
        System.debug('Contact : '+jsonS); 
        return jsonS;
    } 
    public static String nullToVoid(String text)
    {
        if(String.isBlank(text) )
            text='';
        return text;
    }

}