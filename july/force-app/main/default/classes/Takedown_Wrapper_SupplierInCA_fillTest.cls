public class Takedown_Wrapper_SupplierInCA_fillTest {
    public static Takedown_Wrapper_SupplierInCA.responseAmlHits fillResponse(){
        Takedown_Wrapper_SupplierInCA.responseAmlHits responseAmlHits = new Takedown_Wrapper_SupplierInCA.responseAmlHits();
        Takedown_Wrapper_SupplierInCA.Result Result = new Takedown_Wrapper_SupplierInCA.Result();
        list<Takedown_Wrapper_SupplierInCA.AmlHits> listAmlHits = new list<Takedown_Wrapper_SupplierInCA.AmlHits>();
        Takedown_Wrapper_SupplierInCA.AmlHits AmlHits = new Takedown_Wrapper_SupplierInCA.AmlHits();
		AmlHits.partyId = 13073;
        AmlHits.vendorId = 13073;
        AmlHits.entityType = 'entityType';
        AmlHits.customerType = 'customerType';
        AmlHits.rfc = 'GIFH890612HDGLTD04';
        AmlHits.sicCode = 'sicCode';
        AmlHits.sicCodeDescription = 'sicCodeDescription';
        AmlHits.country = 'country';
        AmlHits.state = 'state';
        AmlHits.hits = 'hits';
        AmlHits.hitDescription = 'hitDescription';
        AmlHits.crr = 'crr';
        listAmlHits.add(AmlHits);
        Result.amlHits = listAmlHits;
        responseAmlHits.result = Result;
        return responseAmlHits;
    }

}