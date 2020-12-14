@Istest
private class TKD_PostSuppliersResponseWraperTest {
    @Istest
    static void fillwrapper(){
        TKD_PostSuppliersResponseWraper.ResponsePostSuppliers wrp = new TKD_PostSuppliersResponseWraper.ResponsePostSuppliers();
        wrp.partyId ='ID';
        TKD_PostSuppliersResponseWraper.Status status = new TKD_PostSuppliersResponseWraper.Status();
        status.code ='code';
        status.detail='F';
        status.message='message';
        wrp.supplierId='id';
        wrp.supplierSFID='d';
    } 
}