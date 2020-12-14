@IsTest
public class Wrapper_seguro_details_test {

    static testMEthod void takedown_lmm() {
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
        Asset[] assets = new Asset[]{};
    	TakedownContent contentTakedown = new TakedownContent();
    	TakedownContentOld contentTakedownOLD = new TakedownContentOld();
        new Wrapper_seguro_details(takedownCP, assets, contentTakedown);
    }
    
    static testMEthod void takedown_old() {
        Takedowns_Contingency_plan__c takedownCP = new Takedowns_Contingency_plan__c();
        Asset[] assets = new Asset[]{};
    	TakedownContent contentTakedown = new TakedownContent();
    	TakedownContentOld contentTakedownOLD = new TakedownContentOld();
        new Wrapper_seguro_details(takedownCP, assets, contentTakedownOLD);
    }
    
    static testMethod void stageConvert() {
		String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();
        //Paso 1
        stage = 'Converted';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Converted';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Converted';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Converted';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Converted';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Converted';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Converted';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        //Paso 2
        stage = 'Converted';
        producto = 'PRESTAMO-FIJA';
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Converted';
        producto = 'AFINAN-FIJA';
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';
        try {
        	Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        }catch(QueryException e) {
            System.debug('Some error: '+ e.getMessage());
        }
        
        //Paso 4
        stage = 'Converted';
        producto = 'OPERFIN-FIJA';
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';
        try {
        	Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        }catch(QueryException e) {
            System.debug('Some error: '+ e.getMessage());
        }
        
        //Paso 5
        stage = 'Converted';
        producto = 'PROGRESIVO_FIJA';
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';
        try {
        	Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        }catch(QueryException e) {
            System.debug('Some error: '+ e.getMessage());
        }
    }
    
    static testMethod void stageTollgate1() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Tollgate 1';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 1';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 1';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Tollgate 1';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Tollgate 1';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 1';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Tollgate 1';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Tollgate 1';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Tollgate 1';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Tollgate 1';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Tollgate 1';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageSignatures() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'In Signatures';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'In Signatures';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'In Signatures';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'In Signatures';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'In Signatures';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'In Signatures';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'In Signatures';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'In Signatures';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'In Signatures';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'In Signatures';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'In Signatures';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageTollgate2() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Tollgate 2';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 2';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 2';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Tollgate 2';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Tollgate 2';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Tollgate 2';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Tollgate 2';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Tollgate 2';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Tollgate 2';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Tollgate 2';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Tollgate 2';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageRegistry() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Registry';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Registry';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Registry';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Registry';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Registry';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Registry';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Registry';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Registry';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Registry';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Registry';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Registry';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageFunded() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Funded';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Funded';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Funded';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Funded';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Funded';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Funded';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Funded';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Funded';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Funded';
        producto = 'AFINAN-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Funded';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Funded';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageClosed() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Closed';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Closed';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Closed';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Closed';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Closed';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Closed';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Closed';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Closed';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Closed';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Closed';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Closed';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
    
    static testMethod void stageCanceled() {
        String stage;
        String producto;
        String dealCategory;
        String finance;
        Datetime fechaCreacion = Datetime.now();

        stage = 'Canceled';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Canceled';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        stage = 'Canceled';
        producto = 'OPERFIN-FIJA'; // 
        dealCategory = 'Workout Restructure'; //WO
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfowo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Canceled';
        producto = 'PRESTAMO-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

        stage = 'Canceled';
        producto = 'AFINAN-FIJA'; // 
        dealCategory = 'Not new origination'; //Alivio
        finance = 'CapEx Lines';
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfalv2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);

		//Paso 1
        stage = 'Canceled';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'Release'; //New Origination
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo1 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 2
        stage = 'Canceled';
        producto = 'PRESTAMO-VAR'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo2 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 3
        stage = 'Canceled';
        producto = 'AFINAN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo3 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 4
        stage = 'Canceled';
        producto = 'OPERFIN-FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo4 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso 5
        stage = 'Canceled';
        producto = 'PROGRESIVO_FIJA'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo5 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
        
        //Paso Error
        stage = 'Canceled';
        producto = 'PROGRESIVO_FIJ'; // PROGRESIVO_FIJA
        dealCategory = 'New Origination';
        finance = 'CapEx Lines';  
        Wrapper_seguro_details.WrapperProcessCategory wrapperInfo6 = Wrapper_seguro_details.processDeal(producto, dealCategory, stage, finance, fechaCreacion);
    }
}