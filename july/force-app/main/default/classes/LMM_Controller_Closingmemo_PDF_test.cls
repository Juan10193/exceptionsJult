@Istest
public class LMM_Controller_Closingmemo_PDF_test {
    @Istest
    static  void LMM_Controller_Closingmemo_PDF_test(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.LMM_ls_Bur_Legal__c = '5';
        opp.LMM_ls_BurdeCrditoAval__c='5';
        opp.LMM_ls_BurodeCrditoRepresentativo__c ='15';
        opp.LMM_ls_ExpConClientesPrinc__c ='5';
        opp.LMM_ls_Anosenelnegocio__c ='5';
        opp.LMM_ConcentracinenClientes__c ='5';
        opp.LMM_ls_Industria__c='5';
        opp.LM_ls_D_as_de_AR__c='5';
        opp.LMM_ls_Tama_o_del_Deal__c='10';
        opp.LMM_ls_FCCR__c ='0';
        opp.LMM_ls_TotaldebtVSEBITDA__c ='0';
        opp.LMM_ls_LTVAdvancePaymentSD__c ='0';
        opp.LM_ls_Activaltamentemonetiz__c='0';
        opp.LMM_ls_Collateral_Gap__c='0';
        opp.LMM_ls_Garant_as_Adicionales__c='0';
        
        insert opp;
       
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
		System.currentPageReference().getParameters().put('OpId', opp.Id);
        LMM_Controller_Closingmemo_PDF m = new LMM_Controller_Closingmemo_PDF();
        m.calculateValuesRac();
        m.resultado();
        m.cargaOppLMM();
    }
    
     @Istest
    static  void LMM_Controller_Closingmemo_PDF_test2(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.LMM_Buro_Representativo__c ='Positivo';
        opp.LMM_Anos_de_experiencia_en_el_sector__c=5;
        opp.LMM_OR15_o_mejor__c =14;
        opp.LMM_Anos_experiencia_cliente_p__c=7;
        opp.LMM_Maxima_concentracion__c=56;
        opp.LMM_FCCR__c=0.86;
        opp.LMM_Apalancamiento__c=3;
        opp.LMM_Ratio__c=0.3;
        opp.LMM_Acciones_PG__c=75;
        opp.LMM_Calificacion_Aval_Principal__c=700;
        
        insert opp;
       
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
		System.currentPageReference().getParameters().put('OpId', opp.Id);
        LMM_Controller_Closingmemo_PDF m = new LMM_Controller_Closingmemo_PDF();
        m.calculateValuesRac();
        m.resultado();
        m.cargaOppLMM();
    }
    
    
         @Istest
    static  void LMM_Controller_Closingmemo_PDF_test3(){
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        opp.LMM_Buro_Representativo__c ='Negativo';
        opp.LMM_Anos_de_experiencia_en_el_sector__c=3;
        opp.LMM_OR15_o_mejor__c =16;
        opp.LMM_Anos_experiencia_cliente_p__c=3;
        opp.LMM_Maxima_concentracion__c=61;
        opp.LMM_FCCR__c=0.2;
        opp.LMM_Apalancamiento__c=7;
        opp.LMM_Ratio__c=0.8;
        opp.LMM_Acciones_PG__c=56;
        opp.LMM_Calificacion_Aval_Principal__c=600;
        
        insert opp;
       
        Test.setCurrentPageReference(new PageReference('Page.myPage'));
		System.currentPageReference().getParameters().put('OpId', opp.Id);
        LMM_Controller_Closingmemo_PDF m = new LMM_Controller_Closingmemo_PDF();
        m.calculateValuesRac();
        m.resultado();
        m.cargaOppLMM();
    }
    
}