@Istest
public class Takedown_Wrapper_SupplierInCA_Test {
    @isTest static void requestAmlHits_Test(){
        Takedown_Wrapper_SupplierInCA.requestAmlHits request = new Takedown_Wrapper_SupplierInCA.requestAmlHits();
        request.parametros = new Takedown_Wrapper_SupplierInCA.Parametros();   
    }
    
    @isTest static void parametros_Test(){
        Takedown_Wrapper_SupplierInCA.Parametros parametros = new Takedown_Wrapper_SupplierInCA.Parametros();
        parametros.parametro= new List<Takedown_Wrapper_SupplierInCA.Parametro>();
    }
    
    @isTest static void parametro_Test(){
        Takedown_Wrapper_SupplierInCA.Parametro  parametro = new Takedown_Wrapper_SupplierInCA.Parametro();
        parametro.name ='PACKSYS MEXICO, S.A. DE C.V.';
        parametro.rfc ='PME101027F37';
    }
    
    @isTest static void responseAmlHits_Test(){
        Takedown_Wrapper_SupplierInCA.responseAmlHits response = new Takedown_Wrapper_SupplierInCA.responseAmlHits();
        response.result = new Takedown_Wrapper_SupplierInCA.Result();
        response.status = new Takedown_Wrapper_SupplierInCA.Status();
    }
    
    @isTest static void result_Test(){
        Takedown_Wrapper_SupplierInCA.Result result = new Takedown_Wrapper_SupplierInCA.Result();
        result.amlHits = new List<Takedown_Wrapper_SupplierInCA.AmlHits>();
    }
    
    @isTest static void amlHits_Test(){
        Takedown_Wrapper_SupplierInCA.AmlHits amlHits = new Takedown_Wrapper_SupplierInCA.AmlHits();
         amlHits.partyId = 109403;				
         amlHits.vendorId = 76189;			
		 amlHits.entityName ='PACKSYS MEXICO, S.A. DE C.V.  100.000%';				
		 amlHits.entityType ='';				
	     amlHits.customerType ='ORGANIZATION';				
		 amlHits.rfc ='PME101027F37';						
		 amlHits.sicCode='2821';				
		 amlHits.sicCodeDescription ='Mfg plastic materials/resins';		
		 amlHits.country	='MX';				
		 amlHits.state ='MEX';					
		 amlHits.hits ='false';						
		 amlHits.hitDescription ='';			
		 amlHits.crr='LOW';					
    }
    
    @isTest static void status_Test(){
        Takedown_Wrapper_SupplierInCA.Status status = new Takedown_Wrapper_SupplierInCA.Status();
        status.code='code';
        status.detail='S';
        status.message='Success';
    }
    
    
    
    

}