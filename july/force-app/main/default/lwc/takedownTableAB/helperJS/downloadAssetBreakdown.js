/* eslint-disable no-confusing-arrow */
let workDownload = (s) => {
    let buf = new ArrayBuffer(s.length);
    let view = new Uint8Array(buf);
    for(let i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
    return buf;    
}

let prepareHeadersToDownload = (data) => {
    let preparedData = []
    for(let element of data){
        preparedData.push({
            Id : element.Id,          
            Name :element.Name,
            Model : element.TKD_tx_Model__c,
            SerialNumber : element.SerialNumber,
            Description : element.Description,
            Modelyear : element.TKD_tx_model_year__c,
            EngineNumber : element.TKD_tl_engine_number__c,
            Brand : element.TKD_tx_brand__c,
            Status : element.Status,
            Active : element.TKD_ck_active__c,	
            InsurancePolicy : element.TKD_tx_Insurance_policy__c,	
            ECPolicy : element.TKD_tl_ec_policy__c,	
            InsuranceCompany : element.TKD_tx_Insurance_company__c,
            IncisoInsurance : element.TKD_tx_inciso_insurance__c,	
            InsuranceExpirationDate : element.TKD_fh_insurance_expiration_date__c,	
            Aseguradora : element.TKD_tx_aseguradora__c,	
            AnnexANumber : element.TKD_tx_annex_a_number__c,	
            AnnexACreatedDate : element.TKD_fh_annex_a_created_Date__c,	
            AnnexAApprovedDate : element.TKD_fh_annex_a_approved_Date__c,	
            QuoteNumber : element.TKD_tx_quote_number__c,	
            AnnexAStatus : element.TKD_ls_annex_a_status__c,	
            QuoteDate : element.TKD_fh_quote_date__c,	
            ECorCustomerSupplier : element.TKD_ls_ec_or_customer_supplier__c,	
            UnitAvailabilityIndays : element.TKD_nu_unit_availability_days__c,
            SupplierName : element.TKD_tx_supplier_name__c,	
            PurchaseStatus : element.TKD_ls_purchase_Status__c,
            DeliveryStatus : element.TKD_ls_delivery_status__c,	
            CustomerAgreedDeliveryDate : element.TKD_fh_customer_agreed_delivery_date__c,
            RealDeliveryDate : element.TKD_fh_real_delivery_date__c,
            WelcomeKitSent : element.TKD_ca_welcome_kit_sent__c,
            ForcastedDeliveryDate : element.TKD_fh_forcasted_delivery_date__c,
            WelcomeKitSentDate : element.TKD_fh_welcome_kit_sent_date__c,
            AnnexBStatus : element.TKD_ls_annex_b_status__c,	
            AnnexBSentDate : element.TKD_fh_annex_a_sent_date__c,	
            Quantity : element.Quantity,	
            PaymentType : element.TKD_tx_payment_type__c,            	
            PaymentOrder : element.TKD_tx_payment_order__c,            
            PaymentFrecuency : element.TKD_tx_payment_frecuency__c,
            PaymentAmount : element.TKD_dv_payment_amount__c,	
            SoftCost : element.TKD_dv_soft_cost__c,	
            TotalCost : element.TKD_dv_total_cost__c,
            CurrencyIsoCode : element.CurrencyIsoCode,
            //CollateralID : element.TKD_rb_collateral__c
            collateralType : element.TKD_fm_collateral_type__c,
            collateralDescription : element.TKD_fm_collateral_description__c,
            invoiceTakedown : element.Tkd_fm_invoice_name__c
        })
    }
    return preparedData;
}
let prepareHeadersToUpload = (data) => {
    Object.keys(data).forEach(key => data[key] === undefined ? null : data[key])
    let preparedData = []
    for(let element of data){
        let sffields = {
            Id : validaCampos(element.Id),          
            Name : validaCampos(element.Name),
            TKD_tx_Model__c : validaCampos(element.Model),
            SerialNumber : validaCampos(element.SerialNumber),
            Description : validaCampos(element.Description),
            TKD_tx_model_year__c : validaCampos(element.Modelyear),
            TKD_tl_engine_number__c : validaCampos(element.EngineNumber),
            TKD_tx_brand__c : validaCampos(element.Brand),
            Status : validaCampos(element.Status),
            TKD_ck_active__c : element.Active === 'FALSE' ? false : true,	
            TKD_tx_Insurance_policy__c : validaCampos(element.InsurancePolicy),	
            TKD_tl_ec_policy__c : validaCampos(element.ECPolicy),	
            TKD_tx_Insurance_company__c : validaCampos(element.InsuranceCompany),
            TKD_tx_inciso_insurance__c : validaCampos(element.IncisoInsurance),	
            //TKD_fh_insurance_expiration_date__c : element.InsuranceExpirationDate,	
            TKD_tx_aseguradora__c : validaCampos(element.Aseguradora),	
            TKD_tx_annex_a_number__c : validaCampos(element.AnnexANumber),	
            //TKD_fh_annex_a_created_Date__c : element.AnnexACreatedDate,	
            //TKD_fh_annex_a_approved_Date__c : element.AnnexAApprovedDate,	
            TKD_tx_quote_number__c : validaCampos(element.QuoteNumber),	
            TKD_ls_annex_a_status__c : validaCampos(element.AnnexAStatus),	
            //TKD_fh_quote_date__c : element.QuoteDate,	
            TKD_ls_ec_or_customer_supplier__c : validaCampos(element.ECorCustomerSupplier),	
            TKD_nu_unit_availability_days__c : validaCampos(element.UnitAvailabilityIndays),
            TKD_tx_supplier_name__c : validaCampos(element.SupplierName),	
            TKD_ls_purchase_Status__c : validaCampos(element.PurchaseStatus),
            TKD_ls_delivery_status__c : validaCampos(element.DeliveryStatus),	
            //TKD_fh_customer_agreed_delivery_date__c : element.CustomerAgreedDeliveryDate,
            //TKD_fh_real_delivery_date__c : element.RealDeliveryDate,
            TKD_ca_welcome_kit_sent__c : element.WelcomeKitSent === 'FALSE' ? false : true,
            //TKD_fh_forcasted_delivery_date__c : element.ForcastedDeliveryDate,
            //TKD_fh_welcome_kit_sent_date__c : element.WelcomeKitSentDate,
            TKD_ls_annex_b_status__c : validaCampos(element.AnnexBStatus),	
            //TKD_fh_annex_a_sent_date__c : validaCampos(element.AnnexBSentDate),	
            TKD_dv_payment_amount__c : isNaN(element.PaymentAmount) ? null : Number(element.PaymentAmount),
            TKD_tx_payment_type__c : validaCampos(element.PaymentType),	
            Quantity : isNaN(element.Quantity) ? null : Number(element.Quantity),	
            TKD_tx_payment_order__c : validaCampos(element.PaymentOrder),	
            TKD_dv_soft_cost__c : isNaN(element.SoftCost) ? null : Number(element.SoftCost),	
            TKD_tx_payment_frecuency__c : validaCampos(element.PaymentFrecuency),	
            TKD_dv_total_cost__c : isNaN(element.TotalCost) ? null : Number(element.TotalCost),
            TKD_rb_collateral__c : validaCampos(element.CollateralID),
            TKD_rb_takedown_Invoice__c : validaCampos(element.invoiceID)
            //TKD_tl_op_collateral_description__c : validaCampos(element.collateralDescription),
            //TKD_tl_op_collateral_type__c : validaCampos(element.collateralType)
        }
        //Object.keys(data).forEach(key => typeof sffields[key] !== "number" ? delete data[key] : '')
        //Object.keys(sffields).forEach(key => sffields[key] === undefined ? delete sffields[key] : typeof sffields[key] === "boolean" ? sffields[key] :  typeof sffields[key] === "number" ? Number(sffields[key]) : sffields[key] !== null ? sffields[key].toString() : sffields[key])
        preparedData.push(sffields)
    }
    return preparedData;
}

let prepareCollateralToUpload = (data,catalogCollateral,invoiceTakedown) => {
    console.log('data ' + JSON.stringify(data))

    console.log('catalogCollateral ' + JSON.stringify(catalogCollateral))
    data.forEach(element =>{
        let collateral= catalogCollateral.filter(index => {
            if(element.collateralDescription !== null & element.collateralDescription !== undefined & element.collateralDescription !== ''
            & element.collateralType !== null & element.collateralType !== undefined & element.collateralType !== '') 
            if((index.COLATERAL_DESCRIPTION__c === element.collateralDescription 
                || index.COLATERAL_DESCRIPTION__c === element.collateralDescription.toLowerCase()
                || index.COLATERAL_DESCRIPTION__c === element.collateralDescription.toUpperCase())
                &&
                (index.COLATERAL_TYPE__c === element.collateralType 
                    || index.COLATERAL_TYPE__c === element.collateralType.toLowerCase()
                    || index.COLATERAL_TYPE__c === element.collateralType.toUpperCase())){
                        return index.Id
                }
        })
        if(collateral.length > 0){
            element.CollateralID = collateral[0].Id
        } 
                
    });

    data.forEach(element => {
        let invoice = invoiceTakedown.filter(index => {
            if(element.invoiceTakedown !== null && element.invoiceTakedown !== undefined && element.invoiceTakedown !== '') {
                if(index.Name === element.invoiceTakedown || index.Name === element.invoiceTakedown.toLowerCase()|| index.Name === element.invoiceTakedown.toUpperCase()) {
                    return index.Id;
                }
            }
        });

        if(invoice.length > 0) {
            element.invoiceID = invoice[0].Id; 
        }
    });

    console.log('result data ' + JSON.stringify(data))
    return data;
}
let setComments = (data) =>{ 
    const author = 'Salesforce';
    //Id
    data.A1.c = [{a:author, t:'Identificador SF'}];
    data.A1.c.hidden = true;

    //Name
    data.B1.c = [{a:author, t:'texto(255)'}];
    data.B1.c.hidden = true;

    //Model
    data.C1.c = [{a:author, t:'texto(250)'}];
    data.C1.c.hidden = true;

    //SerialNumber
    data.D1.c = [{a:author, t:'Texto(80)'}];
    data.D1.c.hidden = true;

    //Description
    data.E1.c = [{a:author, t:'Texto(3200)'}];
    data.E1.c.hidden = true;

    //Modelyear
    data.F1.c = [{a:author, t:'Texto(200)'}];
    data.F1.c.hidden = true;


    //EngineNumber
    data.G1.c = [{a:author, t:'Texto(360)'}];
    data.G1.c.hidden = true;

    //Brand
    data.H1.c = [{a:author, t:'Texto(255)'}];
    data.H1.c.hidden = true;

    //Status
    data.I1.c = [{a:author, t:'Texto(100)'}];
    data.I1.c.hidden = true;

    //Active
    data.J1.c = [{a:author, t:'Casilla(TRUE o FALSE)'}];
    data.J1.c.hidden = true;

    //InsurancePolicy
    data.K1.c = [{a:author, t:'Texto(250)'}];
    data.K1.c.hidden = true;

    //ECPolicy
    data.L1.c = [{a:author, t:'Texto(360)'}];
    data.L1.c.hidden = true;

    //InsuranceCompany
    data.M1.c = [{a:author, t:'Texto(250)'}];
    data.M1.c.hidden = true;

    //IncisoInsurance
    data.N1.c = [{a:author, t:'Texto(150)'}];    
    data.N1.c.hidden = true;

    //InsuranceExpirationDate
    data.O1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.O1.c.hidden = true;

    //Aseguradora
    data.P1.c = [{a:author, t:'Texto(255)'}];
    data.P1.c.hidden = true;

    //AnnexANumber
    data.Q1.c = [{a:author, t:'Texto(150)'}];
    data.Q1.c.hidden = true;

    //AnnexACreatedDate
    data.R1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.R1.c.hidden = true;

    //AnnexAApprovedDate
    data.S1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.S1.c.hidden = true;

    //QuoteNumber
    data.T1.c = [{a:author, t:'texto(150)'}];
    data.T1.c.hidden = true;

    //AnnexAStatus
    data.U1.c = [{a:author, t:'Texto(100)'}];
    data.U1.c.hidden = true;

    //QuoteDate
    data.V1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.V1.c.hidden = true;

    //ECorCustomerSupplier
    data.W1.c = [{a:author, t:'Texto(100)'}];
    data.W1.c.hidden = true;

    //UnitAvailabilityIndays
    data.X1.c = [{a:author, t:'Número(5)'}];
    data.X1.c.hidden = true;

    //SupplierName
    data.Y1.c = [{a:author, t:'Texto(150)'}];
    data.Y1.c.hidden = true;

    //PurchaseStatus
    data.Z1.c = [{a:author, t:'Texto(100)'}];
    data.Z1.c.hidden = true;

    //DeliveryStatus
    data.AA1.c = [{a:author, t:'Texto(100)'}];
    data.AA1.c.hidden = true;

    //CustomerAgreedDeliveryDate
    data.AB1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.AB1.c.hidden = true;

    //RealDeliveryDate
    data.AC1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.AC1.c.hidden = true;

    //WelcomeKitSent
    data.AD1.c = [{a:author, t:'Casilla (TRUE o FALSE)'}];
    data.AD1.c.hidden = true;

    //ForcastedDeliveryDate
    data.AE1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.AE1.c.hidden = true;

    //WelcomeKitSentDate
    data.AF1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.AF1.c.hidden = true;

       
    //AnnexBStatus
    data.AG1.c = [{a:author, t:'Texto(100)'}];
    data.AG1.c.hidden = true;

    //AnnexBSentDate
    data.AH1.c = [{a:author, t:'Fecha(dd/mm/aaaa)'}];
    data.AH1.c.hidden = true;

    //Quantity
    data.AI1.c = [{a:author, t:'Número(10,2)'}];
    data.AI1.c.hidden = true;

    //PaymentType
    data.AJ1.c = [{a:author, t:'Texto(150)'}];
    data.AJ1.c.hidden = true;

    //PaymentOrder 
    data.AK1.c = [{a:author, t:'Texto(150)'}];
    data.AK1.c.hidden = true;

    //PaymentFrecuency 
    data.AL1.c = [{a:author, t:'Texto(150)'}];
    data.AL1.c.hidden = true;

    //PaymentAmount
    data.AM1.c = [{a:author, t:'Número(16,2)'}];
    data.AM1.c.hidden = true;

    //SoftCost 
    data.AN1.c = [{a:author, t:'Número(16,2)'}];
    data.AN1.c.hidden = true;

    //TotalCost
    data.AO1.c = [{a:author, t:'Número(16,2)'}];
    data.AO1.c.hidden = true;

    //CurrencyIsoCode
    data.AP1.c = [{a:author, t:'readOnly'}];
    data.AP1.c.hidden = true;

    //collateralType
    data.AQ1.c = [{a:author, t:'Texto(500)'}];
    data.AQ1.c.hidden = true;

    //collateralDescription
    data.AR1.c = [{a:author, t:'Texto(500)'}];
    data.AR1.c.hidden = true;

    //TakedownInvoice (nuevo)
    data.AS1.c = [{a:author, t:'Texto(500)'}];
    data.AS1.c.hidden = true;

    return data;

}

function validaCampos(parametro){
    if(parametro !== null & parametro !== undefined & parametro !== ''){
        parametro = parametro.toString()
    } else if (parametro === null){
        parametro = ''   
    } else if (parametro === undefined){
        parametro = ''    
    }
    return parametro

}
export {workDownload,prepareHeadersToDownload,prepareHeadersToUpload,setComments,prepareCollateralToUpload};