/**
 * @File Name          : LMMCotizacionPDFController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 11/5/2020 15:19:52
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    5/5/2020   eduardo.amiens@outlook.com     Initial Version
**/
public class LMMCotizacionPDFController {

    public EC_Quote__c eC_Quote {get;set;}
    public integer testMes {get;set;}
    public string testDia {get;set;}
    public string Tipo_de_Financiamiento {get;set;}
    public Decimal calculatedLMM_Deposito_en_gtia {get;set;}
    public Decimal calculatedLMM_Comision {get;set;}
    public Decimal calculatedLMM_Anticipo_a_capital {get;set;}
    public Decimal calculatedECQ_Opci_n_de_compra {get;set;}
    
    public list<LMMCotizacionPDFWrapper.TablaAmortizacion> listLMMCotizacionPDFWrapper {get;set;}
    
	public LMMCotizacionPDFController(ApexPages.StandardController controller){
		SObject sObjectRecived = controller.getRecord();
        this.eC_Quote = new EC_Quote__c();
        this.eC_Quote.id = sObjectRecived.id; 
        system.debug('eC_Quote ' + eC_Quote);
        this.eC_Quote = Data_Acess_EC_Quote.getQuoteById(eC_Quote.id);
        if(string.isNotEmpty(this.eC_Quote.Tipo_de_Financiamiento__c))
            getLabelTipo_de_Financiamiento(this.eC_Quote.Tipo_de_Financiamiento__c);
        getTablaAmortizacion();
        calculateValues();
        
    }
    //Este constructor solo tiene el propósito de testear las fechas del sistema
    public LMMCotizacionPDFController(integer testMes, string testDia){
    	this.testMes = testMes; 
        this.testDia = testDia;
    }
    public void getTablaAmortizacion(){
         CotizadorWSWrapper.HeadRequest HeadRequest = (CotizadorWSWrapper.HeadRequest)JSON.deserialize(this.eC_Quote.RequestAmortizacion__c, CotizadorWSWrapper.HeadRequest.class);
         String data = JSON.serialize(HeadRequest.data);
         system.debug('HeadRequest ' + data);
         string userId = HeadRequest.userId;
            string programId = HeadRequest.programId;
        String response;
        if(!Test.isRunningTest()){
            response = CotizadorController.requestPost('callout:'+ CotizadorController.getUrl() + '/prm/api/v3/calcularCotizacion?userid=' + userId + '&programid=' + programId, data);
        } else {
			response = '{"classObject":{"quoteDetailDTO":{"dblMonthlyPayment":676.410709786961,"lstQuotePeriods":[{"dblTotal":784.6364233528748,'
                + '"dblInterest":283.5,"dblBalance":21000,"dblSubtotal":676.410709786961,"dblIva":108.22571356591376,"intPeriod":1,"dblCapital":'
                + '392.910709786961},{"dblTotal":784.6364233528748,"dblInterest":278.195705417876,"dblBalance":20607.08929021304,"dblSubtotal":6'
                + '76.410709786961,"dblIva":108.22571356591376,"intPeriod":2,"dblCapital":398.21500436908497}],"dblBookYield":16.19999999999983,'
                + '"dblExchangeRateValue":0,"dblMinRate":16.2,"dblRealRate":16.2,"dblTotalAmount":21000,"currencyAssetsDTO":{"strDescription":"D'
                + 'olar Americano","statusDTO":{"strDescription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951949},"strCu'
                + 'rrencyCode":"USD","intCurrencyId":1,"selected":false},"dblFinancialInsuranceValue":12.364227736560757}},"success":true,"messa'
                + 'ge":"Tabla de amortizaciÃ³n creada","title":"CotizaciÃ³n"}';            
        }
        system.debug('response ' + response);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response);
        system.debug('results ' + results);
        Map<string,object> classObject = (map<string,object>) results.get('classObject');
        system.debug('classObject ' + classObject);
        Map<string,object> quoteDetailDTO = (map<string,object>) classObject.get('quoteDetailDTO');
        system.debug('quoteDetailDTO ' + quoteDetailDTO);
        list<object> lstQuotePeriods = (list<object>) quoteDetailDTO.get('lstQuotePeriods');
        list<LMMCotizacionPDFWrapper.TablaAmortizacion> listTablaAmortizacion = new list<LMMCotizacionPDFWrapper.TablaAmortizacion>();
        for(object obj : lstQuotePeriods){
            Map<string,object> mpQuotePeriods = (Map<string,object>) obj;   
            LMMCotizacionPDFWrapper.TablaAmortizacion TablaAmortizacion = new LMMCotizacionPDFWrapper.TablaAmortizacion();
            system.debug('results.get(dblTotal) ' + mpQuotePeriods.get('dblTotal'));
            TablaAmortizacion.dblTotal = double.valueOf(mpQuotePeriods.get('dblTotal'));
            TablaAmortizacion.dblInterest = double.valueOf(mpQuotePeriods.get('dblInterest'));
            TablaAmortizacion.dblBalance = double.valueOf(mpQuotePeriods.get('dblBalance'));
            TablaAmortizacion.dblSubtotal = double.valueOf(mpQuotePeriods.get('dblSubtotal'));
            TablaAmortizacion.dblIva = double.valueOf(mpQuotePeriods.get('dblIva'));
            TablaAmortizacion.intPeriod = double.valueOf(mpQuotePeriods.get('intPeriod'));
            TablaAmortizacion.dblCapital = double.valueOf(mpQuotePeriods.get('dblCapital'));
            listTablaAmortizacion.add(TablaAmortizacion);
        }
        this.listLMMCotizacionPDFWrapper = listTablaAmortizacion;
        system.debug('this.listLMMCotizacionPDFWrapper ' + this.listLMMCotizacionPDFWrapper);
    }
    public String getcurrentDate(){
        date d = date.today();
        return String.valueof(getDay() + ', ' + d.day() + ' ' + getMonth() + ' ' + d.year());        
    }
    public string getDay(){
        String dia;
        if(!test.isRunningTest()){
          Datetime dt = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0)); 
          dia = dt.format('EEEE');
        } else{
          dia = this.testDia; 
        }
        
        switch on dia {    
            when 'Monday' {		// when block 1
                dia = 'Lunes';
            }	
            when 'Tuesday' {		// when block 2
                dia = 'Martes'; 
            }
            when 'Wednesday' {		// when block 3
                dia = 'Miércoles';
            }
            when 'Thursday' {		// when block 1
                dia = 'Jueves';
            }	
            when 'Friday' {		// when block 2
                dia = 'Viernes';
            }
            when 'Saturday' {		// when block 3
                dia = 'Sábado';
            }
            when 'Sunday' {		// when block 1
                dia = 'Domingo';
            }
            when else {		  // default block, optional
                dia = 'Lunes';
            }
        }
        return dia;
    }
    
    public string getMonth(){
        integer dateMonth;
        if(!test.isRunningTest()){
			dateMonth = date.today().month();   
        } else{
            dateMonth = this.testMes; 
        }
        string mes;
        switch on dateMonth {    
            when 1 {		// when block 1
                mes = 'Ene';
            }	
            when 2 {		// when block 2
                mes = 'Feb'; 
            }
            when 3 {		// when block 3
                mes = 'Mar';
            }
            when 4 {		// when block 1
                mes = 'Abr';
            }	
            when 5 {		// when block 2
                mes = 'May';
            }
            when 6 {		// when block 3
                mes = 'Jun';
            }
            when 7 {		// when block 1
                mes = 'Jul';
            }	
            when 8 {		// when block 2
                mes = 'Ago';
            }
            when 9 {		// when block 3
                mes = 'Sep';
            }
            when 10 {		// when block 1
                mes = 'Oct';
            }	
            when 11 {		// when block 2
                mes = 'Nov';
            }
            when 12 {		// when block 3
                mes = 'Dic';
            }
            when else {		  // default block, optional
                mes = 'Ene';
            }
        }
        return mes;
    }
    
    public void getLabelTipo_de_Financiamiento(string valuePKlist){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult = EC_Quote__c.Tipo_de_Financiamiento__c.getDescribe();
         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

         for( Schema.PicklistEntry pickListVal : ple){
             if(pickListVal.getValue().equals(valuePKlist)){
                this.Tipo_de_Financiamiento = pickListVal.getLabel();
             }
         }    
    } 
    public void calculateValues(){
        if(EC_Quote.Valor_del_activo__c != null && EC_Quote.LMM_Deposito_en_gtia__c != null && EC_Quote.LMM_Deposito_en_gtia__c != 0){ 
            system.debug('LMM_Deposito_en_gtia__c ' + (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Deposito_en_gtia__c) / 100);          
            this.calculatedLMM_Deposito_en_gtia = (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Deposito_en_gtia__c) / 100;
        }
        if(EC_Quote.Valor_del_activo__c != null && EC_Quote.LMM_Comision__c != null && EC_Quote.LMM_Comision__c != 0){
            system.debug('LMM_Comision__c ' + (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Comision__c) / 100);
            this.calculatedLMM_Comision = (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Comision__c) / 100;            
        }
        if(EC_Quote.Valor_del_activo__c != null && EC_Quote.LMM_Anticipo_a_capital__c != null && EC_Quote.LMM_Anticipo_a_capital__c != 0){
            system.debug('LMM_Deposito_en_gtia__c ' + (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Anticipo_a_capital__c) / 100);
            this.calculatedLMM_Anticipo_a_capital = (this.EC_Quote.Valor_del_activo__c * EC_Quote.LMM_Anticipo_a_capital__c) / 100;            
        }
        if(EC_Quote.Valor_del_activo__c != null && EC_Quote.ECQ_Opci_n_de_compra__c != null && EC_Quote.ECQ_Opci_n_de_compra__c != 0){
            system.debug('LMM_Deposito_en_gtia__c ' + (this.EC_Quote.Valor_del_activo__c * EC_Quote.ECQ_Opci_n_de_compra__c) / 100);
            this.calculatedECQ_Opci_n_de_compra = (this.EC_Quote.Valor_del_activo__c * EC_Quote.ECQ_Opci_n_de_compra__c) / 100;            
        }

        
        
    }
}