@istest
public class ES5_Controller_LA_Limitantes_Test {
    @isTest
    private static void Execute_Constructor(){
        ES5_Controller_LA_Limitantes instancia = new ES5_Controller_LA_Limitantes();
        Date expectedDate = Date.newInstance(1991, 2, 21);
        instancia.cambia('10000');
        instancia.cambia('20000');
        instancia.String_To_Date(null);
        instancia.String_To_Date('18/01/2019');
        instancia.Date_Format(null);
        instancia.Date_Format(expectedDate);
        instancia.Valida_Campos_Vacios();
        instancia.Save();
        instancia.redirect_RP_Limitantes();
        instancia.redirect_RP_LA_PM();
        instancia.Redirect_EP_Limitantes();
        instancia.Busca_Limitante();
        
    }
    

}