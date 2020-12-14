@isTest
public class Takedown_Wrapper_NewSupplierInCA_Test {
	@isTest 
    public static void Request_Parameters(){
        Takedown_Wrapper_NewSupplierInCA.Request_Parameters Test_RPS = new Takedown_Wrapper_NewSupplierInCA.Request_Parameters();
        Takedown_Wrapper_NewSupplierInCA.Parameters Test_P = new Takedown_Wrapper_NewSupplierInCA.Parameters();
        Test_RPS.parametros = Test_P;
    }
    @isTest 
    public static void Parameters(){
        Takedown_Wrapper_NewSupplierInCA.Parameters Test_P = new Takedown_Wrapper_NewSupplierInCA.Parameters();
        Takedown_Wrapper_NewSupplierInCA.NewSupplier Test_NS = new Takedown_Wrapper_NewSupplierInCA.NewSupplier();
        Test_P.supplier = Test_NS;
    }
    @isTest 
    public static void NewSupplier(){
        Takedown_Wrapper_NewSupplierInCA.NewSupplier Test_NS = new Takedown_Wrapper_NewSupplierInCA.NewSupplier();
        Test_NS.vendorId = 12234;
		Test_NS.segment1 = 'Ejemplo';
		Test_NS.vendorName = 'Cliente Bueno';
		Test_NS.vendorNameAlt = 'Cliente Bueno 2';
		Test_NS.vendorTypeLookupCode = '134134';
		Test_NS.vendorType = 'Comercial';
		Test_NS.vatRegistrationNum = '6643342424';
		Test_NS.federalReportableFlag = '435352424';
		Test_NS.startDateActive = '23/08/2019';
		Test_NS.endDateActive = '30/08/2019';
		Test_NS.offsetTaxFlag = '323433444';
		Test_NS.autoTaxCalcFlag = '45645453';
		Test_NS.stateReportableFlag = '4524242';
		Test_NS.niNumber = '55353567';
		Test_NS.allowAwtFlag = '346466324';
		Test_NS.jgzzFiscalCode = '5758443';
		Test_NS.taxReference = '7573234';
		Test_NS.organizationTypeLookupCode = '43412257';
		Test_NS.partyId = 246355;
		Test_NS.employeeId = 745757453;
		Test_NS.summaryFlag = '1231442';
		Test_NS.enabledFlag = '3445322';
		Test_NS.oneTimeFlag = '3568865';
		Test_NS.invoiceCurrencyCode = '55123';
		Test_NS.paymentCurrencyCode = '55324';
		Test_NS.vatCode = '124643';
		Test_NS.attributeCategory = 'Compras';
		Test_NS.attribute1 = 'Descripción';
		Test_NS.attribute2 = 'Color';
		Test_NS.attribute3 = 'Precio';
		Test_NS.attribute4 = 'Tamaño';
		Test_NS.attribute5 = 'Cantidad';
		Test_NS.attribute6 = 'Desempeño';
		Test_NS.attribute7 = 'Diseño';
		Test_NS.attribute8 = 'Forma';
		Test_NS.attribute9 = 'Atributo';
		Test_NS.attribute10 = 'Luminosidad';
		Test_NS.attribute11 = 'Base';
		Test_NS.attribute12 = 'Altura';
		Test_NS.attribute13 = 'Ancho';
		Test_NS.attribute14 = 'Largo';
		Test_NS.attribute15 = 'Volumen';
		Test_NS.activeFlag = 'True';
		Test_NS.originalSso = '503001110';
        Takedown_Wrapper_NewSupplierInCA.Sites Test_SiteS = new Takedown_Wrapper_NewSupplierInCA.Sites();
        Takedown_Wrapper_NewSupplierInCA.Accounts Test_AccS = new Takedown_Wrapper_NewSupplierInCA.Accounts();
        Takedown_Wrapper_NewSupplierInCA.Contacts Test_ConS = new Takedown_Wrapper_NewSupplierInCA.Contacts();
        Test_NS.sites = Test_SiteS;
        Test_NS.accounts = Test_AccS;
        Test_NS.contacts = Test_ConS;   
    }
    @isTest 
    public static void Sites(){
        Takedown_Wrapper_NewSupplierInCA.Sites Test_SiteS = new Takedown_Wrapper_NewSupplierInCA.Sites();
        Test_SiteS.sites = new list <Takedown_Wrapper_NewSupplierInCA.Site>();
        Test_SiteS.sitePostXXXX = new list <Takedown_Wrapper_NewSupplierInCA.Site>();
    }
    @isTest 
    public static void SitePost(){
        Takedown_Wrapper_NewSupplierInCA.SitePost Test_SiteP = new Takedown_Wrapper_NewSupplierInCA.SitePost();
        Test_SiteP.site = new list <Takedown_Wrapper_NewSupplierInCA.Site>();
    }
    @isTest 
    public static void Site(){
        Takedown_Wrapper_NewSupplierInCA.Site Test_Site = new Takedown_Wrapper_NewSupplierInCA.Site();
        Test_Site.vendorId = 325252;
		Test_Site.vendorSiteId = 3455342;
		Test_Site.vendorSiteCode = '55434';
		Test_Site.vendorSiteCodeAlt = '48492';
		Test_Site.shipToLocationId = 8686854;
		Test_Site.shipToLocationName = 'Ejemplo_Site';
		Test_Site.termsDateBasis = '23/06/2020';
		Test_Site.acctsPayCodeCombinationId = 121421;
		Test_Site.acctsPayCodeCombination = '214242';
		Test_Site.prepayCodeCombinationId = 7453455;
		Test_Site.prepayCodeCombination = '643422';
		Test_Site.payGroupLookupCode = '876788';
		Test_Site.paymentPriority = 23;
		Test_Site.termId = 654321;
		Test_Site.termName = 'Test de Ejempl';
		Test_Site.payDateBasisLookupCode = '555654';
		Test_Site.paymentCurrencyCode = '986675';
		Test_Site.orgId = 123456;
		Test_Site.organizationName = 'Engen Capital';
		Test_Site.allowAwtFlag = 'Ejemplo';
		Test_Site.awtGroupId = 6456573;
		Test_Site.awtGroup = 'Engen Test TI';
		Test_Site.primaryPaySiteFlag = 'Mensual';
		Test_Site.vatCode = '33213';
		Test_Site.vatRegistrationNum = '23';
		Test_Site.remittanceEmail = 'casa@gamil.com';
		Test_Site.offsetTaxFlag  = '2421';
		Test_Site.autoTaxCalcFlag = '3535213';
		Test_Site.inactiveDate = '31/02/2020';
		Test_Site.areaCode = '54';
		Test_Site.phone = '5512547809';
		Test_Site.purchasingSiteFlag = 'Treu';
		Test_Site.rfqOnlySiteFlag = '12323';
		Test_Site.paySiteFlag = '35234';
		Test_Site.emailAddress = 'site@ejemplo.com';
		Test_Site.partySiteName = 'sites';
		Test_Site.province = 'CDMX';
		Test_Site.country = 'Méx';
		Test_Site.addressLine1 = 'Sur 56';
		Test_Site.addressLine2 = 'Núm. 34';
		Test_Site.addressLine3 = 'Santa Clara';
		Test_Site.addressLine4 = 'San Bernando 18';
		Test_Site.city = 'CDMX';
		Test_Site.state = 'CDMX';
		Test_Site.zip = '55123';
		Test_Site.attributeCategory = 'Auto 2020';
		Test_Site.attribute1 = 'Color';
		Test_Site.attribute2 = 'Precio';
		Test_Site.attribute3 = 'Desempeño';
		Test_Site.attribute4 = 'Calibre';
		Test_Site.attribute5 = 'Resistencia';
		Test_Site.attribute6 = 'Temperatura';
		Test_Site.attribute7 = 'Diseño';
		Test_Site.attribute8 = 'Tono';
		Test_Site.attribute9 = 'Modelo';
		Test_Site.attribute10 = 'Marca';
		Test_Site.attribute11 = 'Subsidiria';
		Test_Site.attribute12 = 'Componetes';
		Test_Site.attribute13 = 'Servicios';
		Test_Site.attribute14 = 'Año';
		Test_Site.attribute15 = 'Compra-Venta';
		Test_Site.activeFlag = 'False';
		Test_Site.originalSso = '503001110';
		Takedown_Wrapper_NewSupplierInCA.Accounts Test_AccS = new Takedown_Wrapper_NewSupplierInCA.Accounts();
        Takedown_Wrapper_NewSupplierInCA.Contacts Test_ConS = new Takedown_Wrapper_NewSupplierInCA.Contacts();
		Test_Site.accounts = Test_AccS;
		Test_Site.contacts = Test_ConS;
    }
    @isTest 
    public static void Accounts(){
        Takedown_Wrapper_NewSupplierInCA.Accounts Test_AccS = new Takedown_Wrapper_NewSupplierInCA.Accounts();
        Test_AccS.account = new list <Takedown_Wrapper_NewSupplierInCA.account>();
    }
    @isTest 
    public static void Account(){
        Takedown_Wrapper_NewSupplierInCA.Account Test_Acc = new Takedown_Wrapper_NewSupplierInCA.Account();
		Test_Acc.vendorId = 687565;
		Test_Acc.vendorSiteId = 3452366;
		Test_Acc.orgId = 2535335;
		Test_Acc.bankName = 'Engen Capital';
		Test_Acc.countryCode = '32932404';
		Test_Acc.bankNumber = '2478679';
		Test_Acc.branchName = 'Empresas Patito';
		Test_Acc.bankAccountId = 769787;
		Test_Acc.branchType = 'Comercio';
		Test_Acc.branchId = 36745756;
		Test_Acc.bankId = 454396;
		Test_Acc.acctOwnerPartyId = 789675;
		Test_Acc.bankAccountName = 'BBVA';
		Test_Acc.bankAccountNum = '111123';
		Test_Acc.currens= '2000000';
		Test_Acc.accCountryCode = '55123';
		Test_Acc.startDate = '29/02/2020';
		Test_Acc.endDate = '29/12/2020';
        Test_Acc.attributeCategory = 'Descripciones Detalladas';
		Test_Acc.attribute1 = 'Color';
		Test_Acc.attribute2 = 'Precio';
		Test_Acc.attribute3 = 'Tamaño';
		Test_Acc.attribute4 = 'Dimensiones';
		Test_Acc.attribute5 = 'Diseño';
		Test_Acc.attribute6 = 'Luminosidad';
		Test_Acc.attribute7 = 'Resistencia';
		Test_Acc.attribute8 = 'Resistibidad';
		Test_Acc.attribute9 = 'Aleación';
		Test_Acc.attribute10 = 'Composición';
		Test_Acc.attribute11 = 'Desempeño';
		Test_Acc.attribute12 = 'Adaptabilidad';
		Test_Acc.attribute13 = 'Flujo';
		Test_Acc.attribute14 = 'Mantenibilidad';
		Test_Acc.attribute15 = 'Mantenimiento';
		Test_Acc.objectVersionNumber = 342;
		Test_Acc.activeFlag = 'True';
		Test_Acc.originalSso = '503001110';
    }
    @isTest 
    public static void Contacts(){
        Takedown_Wrapper_NewSupplierInCA.Contacts Test_ConS = new Takedown_Wrapper_NewSupplierInCA.Contacts();
        Test_ConS.contact = new list <Takedown_Wrapper_NewSupplierInCA.contact>();
    }
    @isTest 
    public static void Contact(){
        Takedown_Wrapper_NewSupplierInCA.Contact Test_Acc = new Takedown_Wrapper_NewSupplierInCA.Contact();
        Test_Acc.vendorId = 687565;
		Test_Acc.vendorSiteId = 3452366;
		Test_Acc.vendorContactId = 3452366;
		Test_Acc.orgId = 2535335;
		Test_Acc.perPartyId = 998449;
		Test_Acc.relationshipId = 535633;
		Test_Acc.relationship = 'Muchos a Muchos';
		Test_Acc.relPartyId = 341232;
		Test_Acc.partySiteId = 769787;
		Test_Acc.orgContactId = 657053;
		Test_Acc.orgPartySiteId = 367457;
		Test_Acc.personFirstName = 'Benedick';
		Test_Acc.personMiddleName = 'David';
		Test_Acc.personLastName = 'Esquivel';
		Test_Acc.personTitle = 'Becario :(';
		Test_Acc.inactiveDate = '23/07/2019';
		Test_Acc.department = 'Sistemas';
		Test_Acc.areaCode = '55123';
		Test_Acc.phone = '56-13-43-65-12';
		Test_Acc.emailAddress = 'benedick.esquivel@engeniumcapital.com';
		Test_Acc.attributeCategory = 'Descripciones Detalladas';
		Test_Acc.attribute1 = 'Color';
		Test_Acc.attribute2 = 'Precio';
		Test_Acc.attribute3 = 'Tamaño';
		Test_Acc.attribute4 = 'Dimensiones';
		Test_Acc.attribute5 = 'Diseño';
		Test_Acc.attribute6 = 'Luminosidad';
		Test_Acc.attribute7 = 'Resistencia';
		Test_Acc.attribute8 = 'Resistibidad';
		Test_Acc.attribute9 = 'Aleación';
		Test_Acc.attribute10 = 'Composición';
		Test_Acc.attribute11 = 'Desempeño';
		Test_Acc.attribute12 = 'Adaptabilidad';
		Test_Acc.attribute13 = 'Flujo';
		Test_Acc.attribute14 = 'Mantenibilidad';
		Test_Acc.attribute15 = 'Mantenimiento';
		Test_Acc.activeFlag = 'True';
		Test_Acc.originalSso = '503001110';
    }
}