@IsTest
public class ES2_jsonDummyTest {
    @IsTest
    static void ES2_jsonDummyTest(){
        
        ES2_jsonDummy a = new ES2_jsonDummy();
        ES2_jsonDummy.entitymasterToJson();
        ES2_jsonDummy.JsonnULO('a');
        ES2_jsonDummy.entitymasterToJsonTes('a');
        ES2_jsonDummy.jsonaudits();
        ES2_jsonDummy.jsondocdetail();
        ES2_jsonDummy.jsondocs();
        
    }
    
}