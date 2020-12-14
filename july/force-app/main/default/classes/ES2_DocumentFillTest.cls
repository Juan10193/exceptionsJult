@Istest
public class ES2_DocumentFillTest {
@Istest
    static void ES2_DocumentFillTest(){
		
      
      map<string,object>b = null;
        b =  (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.jsondocs());
        
        ES2_DocumentFill.fillDocumentsListForEntity(b);
    }
    
    @Istest
    static void ES2_DocumentFillTest2(){
		ES2_DocumentFill a = new ES2_DocumentFill();
      
      map<string,object>b = null;
        b =  (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.jsondocdetail());
        
       a.rellenarDoc(b);
    }
    
    @Istest
    static void ES2_DocumentFillTest3(){
		
      
      map<string,object>b = null;
        b =  (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.jsonaudits());
        
        system.debug('json' + ES2_jsonDummy.jsonaudits());
        
       ES2_DocumentFill.fillAuditListForEntity(b);
    }
}