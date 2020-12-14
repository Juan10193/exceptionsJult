@isTest
private class EIV_PrivilegesWrapClassTest {
    @isTest static void setTestbotones(){
        EIV_PrivilegesWrapClass a = new EIV_PrivilegesWrapClass();
        
        a.sso='12';
        a.applicationName='chona';   
        a.applicationCode='56';
        a.screen='78';
        a.section='2';
        a.employeeName='2';
        a.screenType='3';
        a.vCrud='true';
        /*
•	V -> Visible 
•	C -> Create
•	R -> Read
•	U -> Update
•	D -> Delete
*/
        a.bVisible='V';
        a.bCreate='C';
        a.bRead='R';
        a.bUpdate='U';
        a.bDelete='D';
        
       // public String getvCrud() {
        //    return vCrud;
        //}
        
        a.setvCrud('');
        a.getvCrud();
        
                
    }
    @isTest static void setTestbotonesno(){
        EIV_PrivilegesWrapClass a = new EIV_PrivilegesWrapClass();
        
        a.sso='12';
        a.applicationName='chono';   
        a.applicationCode='56';
        a.screen='78';
        a.section='2';
        a.employeeName='2';
        a.screenType='3';
        a.vCrud='false';
        /*-
•	V -> Visible 
•	C -> Create
•	R -> Read
•	U -> Update
•	D -> Delete
*/
        a.bVisible='h';
        a.bCreate='t';
        a.bRead='3';
        a.bUpdate='e';
        a.bDelete='d';
        
       // public String getvCrud() {
        //    return vCrud;
        //}
        
        a.setvCrud('0000');
        a.getvCrud();
        
                
    }
}