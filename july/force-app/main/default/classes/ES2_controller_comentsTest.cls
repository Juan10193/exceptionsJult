@isTest
public class ES2_controller_comentsTest {
    
    @isTest 
    static void ES2_controller_comentsTest(){
        ApexPages.currentPage().getParameters().put('requestId','374');
        PageReference pageRef = Page.EIV_EntityReadPageIndividual;
        Test.setCurrentPage(pageRef);
        ES2_controller_coments instCom = new ES2_controller_coments();
        instCom.sComment = 'comentaario prueba';
        instCom.saveComents();
        instCom.BackComents();
         
    }

}