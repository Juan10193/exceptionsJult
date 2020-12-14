@Istest
public class Data_Factory_Opportunity_Test {
    
    	// Metodo que permite crear una oportunidad de tipo  Workout unicamente con los datos requeridos
        public static Opportunity createNewOpportunityTypeWK(){     
            	Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Sales').getRecordTypeId();
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity(); 
            	opp.RecordTypeId = devRecordTypeId;
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas WK Test'; 
                opp.OPP_ls_Region__c='Mexico 1'; 
                opp.StageName='New';
            	opp.CPL_dv_Approved_Amount__c = 100000;
            	//Deal Parameters
                opp.Amount=1000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
           		//Collateral Details
            	opp.OPP_ls_Line_of_Business__c='Equipment';
            	opp.OPP_ls_Collateral__c='Agricultural Equipment';            	
				//Vendor Parameters
            	opp.OPP_ls_Opportunity_from_Vendor__c='No';
            	//Broker Parameters
            	opp.OPP_ls_Opportunity_from_Broker__c='No';
            	
			           
        insert opp;
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }
    
     public static Opportunity createNewOpportunityTypeSales(){            
         		Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Sales').getRecordTypeId();
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity();
         		opp.RecordTypeId = devRecordTypeId;
         		opp.AccountId = Data_Factory_Account_Test.createNewAccount('AccountName').id;
           		//Opportunity Details
                //opp.AccountId=Data_Factory_Account_test.createNewAccount().Id;
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas WK Test'; 
                opp.OPP_ls_Region__c='Mexico 1'; 
                opp.StageName='Lead';
            	opp.CPL_dv_Approved_Amount__c = 1000000000;
            	//Deal Parameters
                opp.Amount=1000000000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
           		//Collateral Details
            	opp.OPP_ls_Line_of_Business__c='Equipment';
            	opp.OPP_ls_Collateral__c='Agricultural Equipment';            	
				//Vendor Parameters
            	opp.OPP_ls_Opportunity_from_Vendor__c='No';
            	//Broker Parameters
            	opp.OPP_ls_Opportunity_from_Broker__c='No';
			           
        insert opp;
         		
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }
    public static Opportunity createNewOpportunityFunded(){       
        		Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Sales').getRecordTypeId();
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity(); 
        		opp.RecordTypeId = devRecordTypeId;
         		opp.AccountId = Data_Factory_Account_Test.createNewAccount('AccountName').id;
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas WK Test'; 
                opp.OPP_ls_Region__c='Mexico 1'; 
                opp.StageName='Lead';
            	opp.CPL_dv_Approved_Amount__c = 1000000000;
            	//Deal Parameters
                opp.Amount=1000000000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
           		//Collateral Details
            	opp.OPP_ls_Line_of_Business__c='Equipment';
            	opp.OPP_ls_Collateral__c='Agricultural Equipment';            	
				//Vendor Parameters
            	opp.OPP_ls_Opportunity_from_Vendor__c='No';
            	//Broker Parameters
            	opp.OPP_ls_Opportunity_from_Broker__c='No';
			           
        insert opp;
         		
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }
	public static Opportunity createNewOpportunityTypeSalesWithOldCA(){    
				Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Sales').getRecordTypeId();      
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity(); 
        		opp.RecordTypeId = devRecordTypeId;
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas WK Test'; 
                opp.OPP_ls_Region__c='Mexico 1'; 
                opp.StageName='In Credit';
            	opp.CPL_dv_Approved_Amount__c = 1000000000;
            	//Deal Parameters
                opp.Amount=1000000000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
           		//Collateral Details
            	opp.OPP_ls_Line_of_Business__c='Equipment';
            	opp.OPP_ls_Collateral__c='Agricultural Equipment';            	
				//Vendor Parameters
            	opp.OPP_ls_Opportunity_from_Vendor__c='No';
            	//Broker Parameters
            	opp.OPP_ls_Opportunity_from_Broker__c='No';
        		opp.OPP_rb_Credit_Approval__c = Data_Factory_CreditApproval_Old.createNewCreditApprovalOld('someAccount').id;
			           
        insert opp;
         		
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }
    public static Opportunity createNewOpportunityTypeLMM(){ 
				Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();        
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity();
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas LMM Test'; 
                opp.StageName='Nuevo';
            	opp.CPL_dv_Approved_Amount__c = 1000000000;
        		opp.RecordTypeId = devRecordTypeId;
            	//Deal Parameters
                opp.Amount=1000000000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
			           
        insert opp;
         		
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }
    public static Opportunity createNewOpportunityTypeWOA(){ 
				Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Workout Alivio').getRecordTypeId();        
            	Date firstDate = Date.newInstance(2019, 09, 30);
                Opportunity opp = new Opportunity();
                opp.OwnerId=UserInfo.getUserId();
                opp.OPP_rb_Closer__c=UserInfo.getUserId();  
                opp.Name='Pruebas LMM Test'; 
                opp.StageName='Nuevo';
            	opp.CPL_dv_Approved_Amount__c = 1000000000;
        		opp.RecordTypeId = devRecordTypeId;
            	//Deal Parameters
                opp.Amount=1000000000000.00; 
            	opp.CloseDate=firstDate;
            	opp.CPS2_da_Expected_1st_funding_date__c=firstDate;
			           
        insert opp;
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = 'Colegios Militares';
        enttityCP.CPI_tx_RFC_TIN__c = 'GIFH890612HDGLTD04';
        enttityCP.EM_Party_ID__c = 'sdf32';
        insert enttityCP;
        
        LMM_Entidad_de_oportunidad__c LMM_Entidad_de_oportunidad = new LMM_Entidad_de_oportunidad__c(LMM_pd_Oportunidad__c = opp.id,
                                                                                                     LMM_pd_Entity_CP__c = enttityCP.id);
        LMM_Entidad_de_oportunidad.LMM_lm_Rol__c = 'Obligor;Legal depositary;';
        insert LMM_Entidad_de_oportunidad;
         		
        System.debug('Oportinidad creada: '+ opp);  	     
        return opp;        
    }

}