@istest
public class ES5_Controller_LA_Apoderados_test {
    @isTest 
    static void Execute_Constructor_Moral(){
        
        PageReference pageRef = Page.ES5_EditPage_Apoderados;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Tipo_Peticion','NEW');
        ApexPages.currentPage().getParameters().put('Tipo_Persona','1');
        ApexPages.currentPage().getParameters().put('Tipo_detalle','A');
        ES5_Controller_LA_Apoderados apoderado = new ES5_Controller_LA_Apoderados();
        Date expectedDate = Date.newInstance(1991, 2, 21);
        apoderado.getNac();
        apoderado.setNac(null);
        apoderado.redirect_RP_LA();
        apoderado.redirect_EP_Apoderados();
        apoderado.redirect_RP_Apoderados();
        apoderado.Save();
        apoderado.Valida_Campos_Vacios();
        apoderado.Date_Format(expectedDate);
        apoderado.cambia('10000');
        apoderado.String_To_Date('22/01/2019');
        apoderado.String_To_Date('f');
        apoderado.laAFecha = expectedDate;
        apoderado.laAFechaRegistro = expectedDate;
        apoderado.laAFechaNacimiento = expectedDate;
        apoderado.laAFechaRevoca = expectedDate;
        apoderado.laAvigid = expectedDate;
        apoderado.getFechas();
    }
    @isTest 
    static void Execute_Constructor_Fisica(){
        
        PageReference pageRef = Page.ES5_EditPage_Apoderados;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Tipo_Peticion','EDIT');
        ApexPages.currentPage().getParameters().put('Tipo_Persona','2');
        ApexPages.currentPage().getParameters().put('Tipo_detalle','T');
        ES5_Controller_LA_Apoderados apoderado = new ES5_Controller_LA_Apoderados();
        apoderado.APO.laAActosDominio = 'R';
        apoderado.APO.laATitulosCredito = 'R';
        apoderado.APO.laAActosAdministrativos = 'R';
        apoderado.APO.laAPleitosCobranza = 'R';
        apoderado.Valida_Campos_Vacios();
    }
    @isTest 
    static void Execute_Constructor_MoraExtranjera(){
        Test.setMock(HttpCalloutMock.class, new Mockhttptabla_Apoderados());        
        PageReference pageRef = Page.ES5_EditPage_Apoderados;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Tipo_Peticion','NEW');
        ApexPages.currentPage().getParameters().put('Tipo_Persona','3');
        ApexPages.currentPage().getParameters().put('Tipo_detalle','A');
        ES5_Controller_LA_Apoderados apoderado = new ES5_Controller_LA_Apoderados();
        apoderado.APO.laANombreFacultado = 'Test';
        apoderado.APO.laAEscrituraNum = 'Test';
        apoderado.Save();
    }

}