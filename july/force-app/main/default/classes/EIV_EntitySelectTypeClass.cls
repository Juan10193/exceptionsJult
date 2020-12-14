public class EIV_EntitySelectTypeClass {
    
    //Id de la entidad seleccionada y variables de la cuenta
    public String sAccountId						      {get;set;}
    public String sAccountName						      {get;set;}
    public String sTopParentId						      {get;set;}
    public String sTopParentName					      {get;set;}
    public String sPartyId							      {get;set;} 
    public String sTargetMarket						      {get;set;} 

    
    //Variable del tipo de entidad seleccionado
    public String s = 'Individual';
    
    public String getString() {
        return s;
    }
    
    public void setString(String s) {
        this.s = s;
    }
    
    //Constructor, cuando se carga la pagina se cargan los valores
    //public EIV_EntityExtendClass(ApexPages.StandardController stdController) {
    public EIV_EntitySelectTypeClass() {
        //Traemos los parametros de la pagina, por el momento dummy, si esta vacio mostramos la pantalla de busqueda
        this.sAccountId =  (String)System.currentPageReference().getParameters().get('AccountId');
        this.sAccountName =  (String)System.currentPageReference().getParameters().get('AccountName');
        this.sTopParentId =  (String)System.currentPageReference().getParameters().get('TopParentID');
        this.sTopParentName =  (String)System.currentPageReference().getParameters().get('TopParentName'); 
        this.sPartyId =  (String)System.currentPageReference().getParameters().get('PartyId'); 
        this.sTargetMarket = (String)System.currentPageReference().getParameters().get('TargetMarket');
		       
    }

    public PageReference NewEntity()
    {        
        System.debug('Entramos a Nueva Entida desde selected tipo de entidad OEJ:');
        //Bajo la supocicion de que siempre que se selecciona el tipo de entidad se esta creando una nueva entidad
        PageReference pr = new PageReference('/apex/' + this.s + '?CustomerType=' + this.s + '&AccountId=' + this.sAccountId + '&AccountName=' + this.sAccountName + '&TopParentID=' + this.sTopParentId + '&TargetMarket=' + this.sTargetMarket +  '&TopParentName=' + this.sTopParentName + '&PartyId=' );
        System.debug('Entramos a Nueva Entida desde selected tipo de entidad OEJ:' + pr);
        pr.setRedirect(true);
        return pr;        
    }  
    public PageReference Cancel()
    {        
        PageReference pr = new PageReference('/' + this.sAccountId);
        pr.setRedirect(true);
        return pr;        
    }  
    

}