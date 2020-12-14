public class EIV_PrivilegesWrapClass {
    
    public string sso                               {get;set;}
    public string applicationName                   {get;set;}    
    public string applicationCode                   {get;set;}
    public string screen                            {get;set;}
    public string section                           {get;set;}
    public string employeeName                      {get;set;}
    public string screenType                        {get;set;}
    public string vCrud;
    /*
    •	V -> Visible 
    •	C -> Create
    •	R -> Read
    •	U -> Update
    •	D -> Delete
    */
    public String bVisible 						{get;set;}
    public String bCreate							{get;set;}
    public String bRead							{get;set;}
    public String bUpdate							{get;set;}
    public String bDelete							{get;set;}
    
    public String getvCrud() {
        return vCrud;
    }
    
    public void setvCrud(String VCRUD) {        
        if(VCRUD==null || VCRUD=='null' || String.isBlank(VCRUD))
        {
            bVisible = 'false';
            bCreate = 'false';
            bRead = 'false';
            bUpdate = 'false';
            bDelete = 'false';
        }
        else
        {
            try{
                
                If(VCRUD.substring(0,1) == '0')bVisible = 'false'; else bVisible = 'true';
                If(VCRUD.substring(1,2) == '0')bCreate = 'false'; else bCreate = 'true';
                If(VCRUD.substring(2,3) == '0')bRead = 'false'; else bRead = 'true';
                If(VCRUD.substring(3,4) == '0')bUpdate = 'false'; else bUpdate = 'true';
                If(VCRUD.substring(4,5) == '0')bDelete = 'false'; else bDelete = 'true';
            }catch(exception e){}
        }
    }    
}