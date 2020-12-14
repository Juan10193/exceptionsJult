@isTest
public class ES2_controller_DownloadDocTest {
	@isTest
    static void ES2_controller_DownloadDocTest(){
        ES2_controller_DownloadDoc inst = new ES2_controller_DownloadDoc();
        inst.detail = new  EIV_DetailWrapClass ();
        inst.doctod = 'asd';
        
        inst.req.docContentB64 = 'asdasd';
        
        inst.getDoc();
    }
    
}