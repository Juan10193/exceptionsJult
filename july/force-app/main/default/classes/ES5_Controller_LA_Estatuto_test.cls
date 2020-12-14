@isTest
private class ES5_Controller_LA_Estatuto_test {

    @isTest 
    static void runTest(){
        ES5_Controller_LA_Estatuto inst = new ES5_Controller_LA_Estatuto();
        inst.redirect_RP_Estatutos();
        inst.redirect_EP_Estatutos();
        inst.redirect_RP_LA_PME();
        inst.estatutos.pOutlaEEstatuto = 'hola';
        //inst.Valida_Campos_Vacios();
        date myDate = date.today();
        inst.Date_Format (myDate);
        inst.Save();
        inst.cambia('10000');
        inst.idReg = '2610';
        inst.Busca_Estatuto();
        

    }
    @isTest 
    static void runTestno(){
        ES5_Controller_LA_Estatuto inst = new ES5_Controller_LA_Estatuto();
        inst.cambia('00100');
        inst.Save();
        

    }
    
}