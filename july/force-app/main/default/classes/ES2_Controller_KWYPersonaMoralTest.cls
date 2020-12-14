@isTest
public class ES2_Controller_KWYPersonaMoralTest {
	@isTest
    static void ES2_Controller_KWYPersonaMoral(){
        ES2_Controller_KWYPersonaMoral inst = new ES2_Controller_KWYPersonaMoral();
        inst.detail = new EIV_DetailWrapClass();
        inst.editKYCPMProvider();
        inst.partyIdDoc ='12';
        
        inst.sendbtn = true;
        inst.aceptbtn = true;
        inst.onhdbtn = true;
        inst.reworkbtn = true;
        inst.rejbtn = true;
        inst.preaprbtn = true;
        inst.aprbtn = true;
        inst.cancelbtn = true;
        inst.btentitybtn = true;
        inst.editbtn = true; 
        inst.Ncombtn = true;
        inst.Ndocbtn = true;
        inst.senddTocustomer = true;
        inst.completedByC = true;
        
        inst.editKYCPMProvider();
        inst.saveKYCPMProvider();
        inst.idReg ='12';
        inst.deleteProvider();
        inst.editKYCPMBANCK();
        
        inst.req.pOutRequestId = '10';
        inst.bankT.pOutKYCOrgBankName = 'BANAMEX';
        inst.bankT.pOutKYCOrgBankAccount ='1010101010';
        inst.bankT.pOutKYCOrgBankCountry ='Mex';
        inst.saveKYCPMBANCK();
        inst.deleteBank();
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
        
        
        //inst.backToEntity();
       
        inst.saveStatusGeneral('oldStatus','sStatus');
        inst.saveKYCPMP();
        inst.editKYCPM();
        inst.editKYCPMCAPITALSOCIAL();
        inst.req.pOutRequestId ='12';
        inst.capSoc.pOutKYCOrgPartnerLegalName = 'Memoerdes';
        inst.capSoc.pOutKYCOrgPartnerCountry ='Mex';
        inst.capSoc.pOutKYCOrgPartnerRFC ='ABC123';
        inst.capSoc.pOutKYCOrgPartnerPorcent ='10%';
        inst.saveKYCPMCAPITALSOCIAL();
        inst.deleteCapitalS();
        inst.editKYCPMAcCM();
        
        inst.req.pOutRequestId ='12';
        inst.accpm.pOutKYCOrgPartnerOrgLegalName ='Macarena';
        inst.accpm.pOutKYCOrgPartnerOrgCountry = 'Mex';
        inst.accpm.pOutKYCOrgPartnerOrgRFC ='ABX123';
        inst.accpm.pOutKYCOrgPartnerOrgPorcent ='20%';
        inst.saveACcMral();
        inst.deleteAccMoral();
        inst.editKYCPMAcCFIdei();
        inst.req.pOutRequestId = '12';
        inst.sfidei.pOutKYCOrgTrustLegalName ='Paola';
        inst.sfidei.pOutKYCOrgTrustCountry ='Mex';
        inst.sfidei.pOutKYCOrgTrustRFC ='ASB123';
        inst.sfidei.pOutKYCOrgTrustPersons ='Malo';
        inst.saveACcFidei();
        inst.deleteAccFidei();
        
        inst.editKYCPMAcCFIsic();
        inst.req.pOutRequestId ='12';
        inst.spfisic.pOutKYCOrgPartnerIndLegalName = 'Maracuya';
		inst.spfisic.pOutKYCOrgPartnerIndCountry ='Mex';
        inst.spfisic.pOutKYCOrgPartnerIndRFC ='ABXC123';
        inst.spfisic.pOutKYCOrgPartnerIndPorcent = '10%';
        inst.saveACcFIsic();
        inst.deleteAccFisica();
        
        inst.editKYCPMAAdmins();
        inst.req.pOutRequestId = '12';
        inst.sAdmin.pOutKYCOrgBizManagerName = 'Chuchita';
        inst.sAdmin.pOutKYCOrgBizManagerTitle ='GERENTE';
        inst.sAdmin.pOutKYCOrgBizManagerRFC = 'ABX12312';
        inst.savePMAdmins();
        inst.deleteManagerOrg();
        inst.editKYCPMFunciP();
        
        inst.req.pOutRequestId ='12';
        inst.funcioP.pOutKYCOrgBizMainTitle = 'GEFASO';
        inst.funcioP.pOutKYCOrgBizMainName = 'Maura';
        inst.funcioP.pOutKYCOrgBizMainRFC = 'ABC123123';
        inst.savePMFuncioP();
        inst.deleteFuncionarioPrin();
        
        
        inst.editKYCPMConsorcio();
        inst.req.pOutRequestId = '12';
        inst.grupEm.pOutKYCOrgCorpLegalName ='CHUCHITA';
        inst.grupEm.pOutKYCOrgCorpCountry ='Mex';
        inst.grupEm.pOutKYCOrgCorpAddress = 'Segunda serrada de leandro Valle';
        inst.grupEm.pOutKYCOrgCorpObjective = 'Para lo que sea';
        inst.grupEm.pOutKYCOrgCorpPercent ='60%';
        inst.savePMconsorcio();
        inst.deleteConsorcio();
        inst.vfTypeEntitieRead('INDIVIDUAL');
        inst.newcoment();
        
        inst.CancelTable();
        inst.cambia('10000');
        inst.yesnobtn();
        inst.passvalue('Y');
        
        
        
        inst.requestIdDoc ='12';
        inst.oraId ='10';
        inst.docUrl ='asdas/pdf';
        inst.docType ='KYC_DOCUMENT';
        inst.docId ='23';
        inst.nameDoc ='documento';
        
    }
    
    
   @isTest
    static void ES2_Controller_KWYPersonaMoralElss(){
         ES2_Controller_KWYPersonaMoral inst = new ES2_Controller_KWYPersonaMoral();
        inst.req.pOutRequestId = '';
         inst.detail = new EIV_DetailWrapClass();
        inst.partyIdDoc ='';
        
        inst.sendbtn = true;
        inst.aceptbtn = true;
        inst.onhdbtn = true;
        inst.reworkbtn = true;
        inst.rejbtn = true;
        inst.preaprbtn = true;
        inst.aprbtn = true;
        inst.cancelbtn = true;
        inst.btentitybtn = true;
        inst.editbtn = true; 
        inst.Ncombtn = true;
        inst.Ndocbtn = true;
        inst.senddTocustomer = true;
        inst.completedByC = true;
        
        inst.editKYCPMProvider();
        inst.saveKYCPMProvider();
        inst.idReg ='12';
        inst.deleteProvider();
        inst.editKYCPMBANCK();
        
        inst.req.pOutRequestId = '10';
        inst.bankT.pOutKYCOrgBankName = 'BANAMEX';
        inst.bankT.pOutKYCOrgBankAccount ='1010101010';
        inst.bankT.pOutKYCOrgBankCountry ='Mex';
        inst.saveKYCPMBANCK();
        inst.deleteBank();
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
        
        
        //inst.backToEntity();
       
        inst.saveStatusGeneral('oldStatus','sStatus');
        inst.saveKYCPMP();
        inst.editKYCPM();
        inst.editKYCPMCAPITALSOCIAL();
        inst.req.pOutRequestId ='12';
        inst.capSoc.pOutKYCOrgPartnerLegalName = 'Memoerdes';
        inst.capSoc.pOutKYCOrgPartnerCountry ='Mex';
        inst.capSoc.pOutKYCOrgPartnerRFC ='ABC123';
        inst.capSoc.pOutKYCOrgPartnerPorcent ='10%';
        inst.saveKYCPMCAPITALSOCIAL();
        inst.deleteCapitalS();
        inst.editKYCPMAcCM();
        
        inst.req.pOutRequestId ='12';
        inst.accpm.pOutKYCOrgPartnerOrgLegalName ='Macarena';
        inst.accpm.pOutKYCOrgPartnerOrgCountry = 'Mex';
        inst.accpm.pOutKYCOrgPartnerOrgRFC ='ABX123';
        inst.accpm.pOutKYCOrgPartnerOrgPorcent ='20%';
        inst.saveACcMral();
        inst.deleteAccMoral();
        inst.editKYCPMAcCFIdei();
        inst.req.pOutRequestId = '12';
        inst.sfidei.pOutKYCOrgTrustLegalName ='Paola';
        inst.sfidei.pOutKYCOrgTrustCountry ='Mex';
        inst.sfidei.pOutKYCOrgTrustRFC ='ASB123';
        inst.sfidei.pOutKYCOrgTrustPersons ='Malo';
        inst.saveACcFidei();
        inst.deleteAccFidei();
        
        inst.editKYCPMAcCFIsic();
        inst.req.pOutRequestId ='12';
        inst.spfisic.pOutKYCOrgPartnerIndLegalName = 'Maracuya';
		inst.spfisic.pOutKYCOrgPartnerIndCountry ='Mex';
        inst.spfisic.pOutKYCOrgPartnerIndRFC ='ABXC123';
        inst.spfisic.pOutKYCOrgPartnerIndPorcent = '10%';
        inst.saveACcFIsic();
        inst.deleteAccFisica();
        
        inst.editKYCPMAAdmins();
        inst.req.pOutRequestId = '12';
        inst.sAdmin.pOutKYCOrgBizManagerName = 'Chuchita';
        inst.sAdmin.pOutKYCOrgBizManagerTitle ='GERENTE';
        inst.sAdmin.pOutKYCOrgBizManagerRFC = 'ABX12312';
        inst.savePMAdmins();
        inst.deleteManagerOrg();
        inst.editKYCPMFunciP();
        
        inst.req.pOutRequestId ='12';
        inst.funcioP.pOutKYCOrgBizMainTitle = 'GEFASO';
        inst.funcioP.pOutKYCOrgBizMainName = 'Maura';
        inst.funcioP.pOutKYCOrgBizMainRFC = 'ABC123123';
        inst.savePMFuncioP();
        inst.deleteFuncionarioPrin();
        
        
        inst.editKYCPMConsorcio();
        inst.req.pOutRequestId = '12';
        inst.grupEm.pOutKYCOrgCorpLegalName ='CHUCHITA';
        inst.grupEm.pOutKYCOrgCorpCountry ='Mex';
        inst.grupEm.pOutKYCOrgCorpAddress = 'Segunda serrada de leandro Valle';
        inst.grupEm.pOutKYCOrgCorpObjective = 'Para lo que sea';
        inst.grupEm.pOutKYCOrgCorpPercent ='60%';
        inst.savePMconsorcio();
        inst.deleteConsorcio();
        inst.vfTypeEntitieRead('INDIVIDUAL');
        inst.newcoment();

        inst.CancelTable();
        inst.cambia('10000');
        inst.yesnobtn();
        inst.passvalue('Y');
        
        
        
        inst.requestIdDoc ='12';
        inst.oraId ='10';
        inst.docUrl ='asdas/pdf';
        inst.docType ='KYC_DOCUMENT';
        inst.docId ='23';
        inst.nameDoc ='documento';
        
    }
    
    @IsTest
    static void newedocTest(){
        ES2_Controller_KWYPersonaMoral a = new ES2_Controller_KWYPersonaMoral();
        ES2_Controller_KWYPersonaMoral.newdocument('anita', '12', '12', 'Morosa', '1234');
        ES2_Controller_KWYPersonaMoral.deleteDocument('1', '1', '1', 'KYC documents', '12', '12', '1');
        ES2_Controller_KWYPersonaMoral.downloadDoctos('1', '12');
        a.doctypesList();
    }
}