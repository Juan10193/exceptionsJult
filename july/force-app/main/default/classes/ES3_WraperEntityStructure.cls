public class ES3_WraperEntityStructure {
    public string oportunityName 			{get; set;}
    public string obligor		 			{get; set;}
    public string guarantor		 			{get; set;}
    public string riskDescisionEntity 		{get; set;}
    public string beneficialOwner 			{get; set;}
    public string legalDepositary 			{get; set;}
    //Para Special Conditions y Covenants
    public string specialCondition 			{get; set;}
    public string covenantCualitativo 		{get; set;}
    public string covenantCuantitativo		{get; set;}
    
    
    
    public ES3_WraperEntityStructure()
    {
        this.oportunityName = '';
        this.obligor = '';
        this.guarantor = '';
        this.riskDescisionEntity = '';
        this.beneficialOwner = '';
        this.legalDepositary = '';
        this.specialCondition = '';
        this.covenantCualitativo = '';
        this.covenantCuantitativo = '';
    }
}