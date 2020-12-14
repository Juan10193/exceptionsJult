@Istest
private class Data_Access_ProcessInstanceWorkitemTest {
	@Istest
    static void Data_Access_ProcessInstanceWorkTest(){
        id ac = '0051R00000HftbcQAB';
        id el = '04i8A000000RKdFQAW';
        list<id>els = new list<id>();
        els.add(el);
        Data_Access_ProcessInstanceWorkitem.gWorkItemIdByActorId(els, el);
    }
    
    @Istest
    static void getActorIdsByWorkItemIdsTest(){
        id ac = '0051R00000HftbcQAB';
        id el = '04i8A000000RKdFQAW';
        list<id>els = new list<id>();
        els.add(el);
        Data_Access_ProcessInstanceWorkitem.getActorIdsByWorkItemIds(els);
    }
}