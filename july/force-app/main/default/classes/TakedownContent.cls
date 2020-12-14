global class TakedownContent {
	public String userId {get; set;}
	public String userName {get; set;}
	public String typeProcessCode {get; set;}
	public String processFKId {get; set;}
    public List<Identifiers> identifiers {get; set;}
        
	public class Identifiers {
        public String name {get; set;}
        public String rfc {get; set;}
        public Integer type {get; set;}
        public Integer person {get; set;}
    }
}