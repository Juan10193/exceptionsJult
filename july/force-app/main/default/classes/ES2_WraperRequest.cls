public class ES2_WraperRequest {
    
    public string pOutRequestId             {get;set;}
    public string pOutRequestType           {get;set;}
    public string pOutndaType               {get;set;}
    public string pOutSourceAccountId       {get;set;}
    public string pOutSourceAccountName     {get;set;}
    public string pOutSourceTopParentId     {get;set;}
    public string pOutSourceTopParentName   {get;set;}
    public string pOutSourceOpId            {get;set;}
    public string pOutSourceCAId            {get;set;}
    public string pOutStartDate             {get;set;}
    public string pOutEndDate               {get;set;}
    public string pOutRequestStatus         {get;set;}
    public string pOutCreatedBy             {get;set;}
    public string pOutRequestedBy           {get;set;}
    public string pOutActiveFlag            {get;set;}
    public string pOutCreationDate          {get;set;}
    public string pOutLastUpdateDate        {get;set;}
    public string pOutFinantialEntity       {get;set;}
    public string nameCreatedBy             {get;set;}
    public string nameRequestedBy           {get;Set;}
    public string nameUpdatedBy             {get;Set;}
    public string nameAssignedTo            {get;set;}
    
    
    
    public string pOutProcessName           {get;set;}
    public string pOutPartyId               {get;set;}
    public string pOutPartyName             {get;set;}
    public string pOutEGPartyId             {get;set;}
    public string pOutEGPartyName           {get;set;}
    public string pOutRootRequestId         {get;set;}
    public string pOutAssignedGroup         {get;set;}
    public string pOutAssignedTo            {get;set;}
    public string pOutAssignedDate          {get;set;}
    public string pOutUpdatedBy             {get;set;}
    public string pOutSolvedBy              {get;set;}
    public string pOutSolvedDate            {get;set;}
    public string docTypesToURL             {get;set;}
    public List<ES2_Wraper_Doctype> DocTypesObj {get;set;}
    public list<EIV_PrivilegesWrapClass> privilegeObj {get;set;}
    public ES2_wraper_workflow workflowObj {get;set;}
    public ES2_Wraper_AML amlObj {get;set;}
    public list<ES4_wraper_RelatedRequest> requestHIJO{get;set;}
    public ES2_wraper_AMLHit amlhitsObj {get; set;}
    public list<ES2_Wraper_CreditApproval> creditAproval {get;set;}
    public ES2_Wraper_KWYPersonaFisica kwypfObj {get; set;}
    public ES2_Wraper_KWYPersonaMoral kwypmObj {get; set;}
    public ES4_wraper_EVAL EVALOBJ {get; set;}
    public ES2_Wraper_CREDIT_BUREAU CreditBureauObj {get;set;}
    public ES2_wraper_entityDocument documentdommy {get; set;}
    public ES5_wraper_LAH LAH {get; set;}
    public ES2_wraper_entityComment comentdommy {get; set;}
    public ES2_wraper_legalAssesment ladommy {get; set;}
    public ES2_wraper_sicCode sic {get; set;}
    public list<ES2_wraper_coments> comentarios {get; set;}
    public list<ES2_wraper_hits> hits {get;set;}
    public list<ES2_wraper_documents> documentos {get; set;}
    public list<ES2_wraper_audits> audits{get; set;}
    public ES2_wraper_status status {get; set;}
    public ES2_WraperRequest()
    {
        
        requestHIJO = new List<ES4_wraper_RelatedRequest>(); 
        DocTypesObj = new List<ES2_Wraper_Doctype>();          
        privilegeObj = new list<EIV_PrivilegesWrapClass>();        
        workflowObj = new ES2_wraper_workflow();        
        amlObj = new ES2_Wraper_AML(); 
        hits = new list<ES2_wraper_hits>();
        amlhitsObj = new ES2_wraper_AMLHit();
        creditAproval =  new list<ES2_Wraper_CreditApproval>();
        kwypfObj = new ES2_Wraper_KWYPersonaFisica();
        kwypmObj = new ES2_Wraper_KWYPersonaMoral();
        EVALOBJ = new ES4_wraper_EVAL();
        LAH = new ES5_wraper_LAH();
        CreditBureauObj = new ES2_Wraper_CREDIT_BUREAU();
        documentdommy = new ES2_wraper_entityDocument();
        comentdommy = new ES2_wraper_entityComment();
        ladommy = new ES2_wraper_legalAssesment();
        comentarios = new list<ES2_wraper_coments>();
        documentos = new list<ES2_wraper_documents>();
        audits = new list<ES2_wraper_audits>();
        status = new ES2_wraper_status();
        sic = new ES2_wraper_sicCode();
        
    }
    
}