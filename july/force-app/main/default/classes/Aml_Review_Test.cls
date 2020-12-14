@Istest
public class Aml_Review_Test {
	@Istest
    public static void getUserTest(){
         user a = [select id from User limit 1];
        list<id>usIds =new list<id>{a.id};
        Aml_Review_cls.getUseruarios(usIds, '123');
    }

    @Istest
    public static void getEntitiesTest(){
        Aml_Review_cls.getEntities('a2A0j0000006jGCEAY');
    }

    @Istest
    public static void getCommentsTest(){
         Aml_Review_cls.getComments('a2A0j0000006jGCEAY','1234','AML_Review');
    }
    
    @Istest
    public static void getCommentsNoPIdTest(){
         Aml_Review_cls.getComments('a2A0j0000006jGCEAY','','AML_Review');
    }
    
    @Istest
    public static void getUserPhotosTest(){
        user a = [select id from User limit 1];
        list<id>usIds =new list<id>{a.id};
        Aml_Review_cls.getUserPhotos(usIds);
    }
    
    @Istest
    public static void getAMLDoctsTest(){
        test.setMock(HttpCalloutMock.class, new MockHttpES3_DocSInRequestCalloutClass());
        string a = '12';
        Aml_Review_cls.getAMLDocts('https://test.com', '999999999', 'a');
    }
    
    @Istest
    public static void getDoctypesTest(){
        Aml_Review_cls.getDoctypes('a2A0j0000006jGCEAY', 'a2A0j0000006jGCEAY');
    }
    
    @Istest
    public static void unresolvedEntitiesTest(){
         list<id>Ids =new list<id>{'a2A0j0000006jGCEAY'};
        Aml_Review_cls.unresolvedEntities(Ids, '{"unresolveds":[{"id":"a2t0j000000NuOlAAK","partyId":"21091","hits":false},{"id":"a2t0j0000005MN2AAM","partyId":"13073","hits":false}]}');
    }
    
    @Istest
    public static void showHitsTest(){
        list<integer>partysIds = new list<integer>{12313,13132};
        test.setMock(HttpCalloutMock.class, new MockHttpGetHitsAmlreview());    
        Aml_Review_cls.showHits(partysIds, 'https://ecoasdev01.engeniumcapital.mx:7035');
    }
    
    @Istest
    public static void getUnresolvedItemsTest(){
        list<string>Ids = new list<string>{'a2A0j0000006jGCEAY'};
            Aml_Review_cls.getUnresolvedItems(Ids);
    }
    
    @Istest
    public static void adverseMediaTets(){
        Aml_Review_cls.adverseMedia('a2A0j0000006jGCEAY');
    }
}