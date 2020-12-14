public class ES2_wraper_AMLHit {
    public string RFC {get;set;}
	public string EntityName {get;set;}
    public string hitExpirationDate {get;set;}
	public boolean Flag {get;set;}
	public string UwStatus {get;set;}
	public string UwComments {get;set;}
	public string AMLStatus {get;set;}
	public string AMLComments {get;set;}
	public string AMLMaxPercent {get;set;}
    public list<ES2_wraper_hits> hits {get;set;}
}