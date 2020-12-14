@isTest
private class ES5_Controller_LA_Modificaciones_test {
    @isTest 
    static void Call_New_Request(){
        Date expectedDate = Date.newInstance(1991, 2, 21);
        ApexPages.currentPage().getParameters().put('Tipo_Peticion','NEW');
        ApexPages.currentPage().getParameters().put('requestId','1111');
        ApexPages.currentPage().getParameters().put('Modificacion_ID','1111');        
        ES5_Controller_LA_Modificaciones inst = new ES5_Controller_LA_Modificaciones();
        inst.cambia('10000');
        inst.cambia('20000');
        inst.String_To_Date(null);
        inst.String_To_Date('18/01/2019');
        inst.Date_Format(null);
        inst.Date_Format(expectedDate);
        inst.Valida_Campos_Vacios();
        inst.Save();
        inst.redirect_RP_Modificaciones();
        inst.redirect_RP_LA_PM();
        inst.Redirect_EP_Modificaciones();
        inst.idLimitante = '20';
        inst.R_Fecha = expectedDate;
        inst.Fecha = expectedDate;
        inst.editbtn = true;
    }
    @isTest 
    static void Call_Edit_Request(){
        ApexPages.currentPage().getParameters().put('Tipo_Peticion','EDIT');
        ApexPages.currentPage().getParameters().put('requestId','1111');
        ApexPages.currentPage().getParameters().put('Modificacion_ID','1111');
        
        ES5_Controller_LA_Modificaciones inst = new ES5_Controller_LA_Modificaciones();
        
    }  

}