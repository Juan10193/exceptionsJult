public class ES2_WraperDoc {
	 public string docContentB64 {get;set;}
    public string contentDocId {get;set;}
    public string docFormat {get;set;}
    public string docType {get;set;}
    public string originalDocName {get;set;}
    public string contentDocName {get;set;}
    public ES2_wraper_status status {get; set;}
    
    public  ES2_WraperDoc(){
        status = new ES2_wraper_status();
    }
}