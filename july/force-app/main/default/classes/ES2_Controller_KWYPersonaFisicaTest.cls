@isTest
public class ES2_Controller_KWYPersonaFisicaTest {
	@isTest
    static void ES2_Controller_KWYPersonaFisica(){
        ES2_Controller_KWYPersonaFisica inst = new ES2_Controller_KWYPersonaFisica();
        inst.detail = new EIV_DetailWrapClass();
        
        inst.req.pOutRequestId ='12';
        inst.idReg ='10';
        inst.detail = null;
        inst.partyIdDoc = '11';
        
        ES2_Controller_KWYPersonaFisica.downloadDoctos('1','2');
        
        inst.requestIdDoc ='12';
        inst.oraId ='10';
        inst.docUrl ='asdas/pdf';
        inst.docType ='KYC_DOCUMENT';
        inst.docId ='23';
        inst.nameDoc ='documento';
        ES2_Controller_KWYPersonaFisica.deleteDocument('1', '2','2','KYC documents','2','ana', '2');
       
        
        inst.sendbtn = null;
        inst.aceptbtn = null;
        inst.onhdbtn = null;
        inst.reworkbtn = null;
        inst.rejbtn = null;
        inst.preaprbtn = null;
        inst.aprbtn = null;
        inst.cancelbtn = null;
        inst.btentitybtn = null;
        inst.editbtn = null;
        inst.Ncombtn = null;
        inst.Ndocbtn = null;
        inst.senddTocustomer = null;
        inst.completedByC = null;
        inst.newKYCPFrovider();
        inst.saveKYCPF();
        inst.editKYCPF();
        inst.provRecurso.pOutKYCIndResLegalName = 'pOutKYCIndResLegalName';
        inst.provRecurso.pOutKYCIndResCountry = 'pOutKYCIndResCountry';
        inst.provRecurso.pOutKYCIndResRFC = 'pOutKYCIndResRFC';
        inst.provRecurso.pOutKYCIndResAddress = 'pOutKYCIndResAddress';
        inst.provRecurso.pOutKYCIndResFEASerialNo = 'pOutKYCIndResFEASerialNo';
        
        
        
        inst.saveProvider();
        
        inst.idReg ='12';
        inst.deleteProvider();
        inst.send();
        inst.sendToCustomer();
        inst.completedByCustomer();
        inst.accept();
        inst.onHold();
        inst.rework();
        inst.reject();
        inst.preApprove();
        inst.approve();
        inst.cancel();
        inst.vfTypeEntitieRead('INDIVIDUAL');
        inst.newcoment();
         ES2_Controller_KWYPersonaFisica.newdocument('A', '112', '3', 'Maruchan','123');
        inst.CancelTable();
        inst.saveStatusGeneral(null, null);
        inst.cambia('10000');
        inst.yesnobtn();
        inst.passvalue('Y');
        
     
       
        PageReference pr = Page.ES2_KYC_Person_NewProvider;
        pr.getParameters().put('requestId', 'ID1234');
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
        sic.Name = '999';
        sic.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic;
        sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
        inst.backToEntity();
        inst.deleteProvider();
        
    }
}