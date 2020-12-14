public  class Wrapper_ClosingMemoTakedown_REST {
   public ClosingMemoTKDGralInfo generalInformation                             {get;set;}
   public string caSummary                                                      {get;set;}
   public list<ClosingMemoTKDentiteStructure> entitiesStructure                 {get;set;}
   public ClosingMemoTKDOpportunity oportunidad                                 {get;set;}
   public ClosingMemoTKDPricing  pricing                                        {get;set;}
   public list <CovenanQualitativo> covenanQualitativos                         {get;set;}
   public list <CovenanQuantitativo> covenanQuantitativos                       {get;set;}
   public list <SpecialCondition> specialConditions                             {get;set;}
   public string caComments                                                     {get;set;}

    
   public class ClosingMemoTKDGralInfo{
    public string creditApprovalType {get;set;}
    public string srUW               {get;set;}
    public string uw                 {get;set;}
    public string statusAML          {get;set;}
    public string vendor             {get;set;}
    public string economicGroup      {get;set;}
    public string approvalLevel      {get;set;}
    public Date approvalDate         {get;set;}
    public string originador         {get;set;}
    public string satusRisk          {get;set;}
    public string ca                 {get;set;}
    public string caId               {get;set;}
    public string statusCA           {get;set;}
    public string bussinesType       {get;set;}
   }

   public class ClosingMemoTKDentiteStructure{
    public Integer obligor               {get;set;}
    public Integer guarantor             {get;set;}
    public Integer riskDesicionEntity    {get;set;}
    public Integer legalDepositary       {get;set;}
    public Integer beneficialOwner       {get;set;}
    public string entityLink            {get;set;}
    public string topParentId           {get;set;}
    public string topParentName         {get;set;}
    public string partyId               {get;set;}
    public string customerType          {get;set;}
    public string entityName            {get;set;}
    public string rFC                   {get;set;}
   }

   public class ClosingMemoTKDOpportunity{
    public string stage                         {get;set;}
    public string product                       {get;set;}
    public string productApproved               {get;set;}
    public string aditionalServices             {get;set;}
    public string brokerName                    {get;set;}
    public string oppCurrency                   {get;set;}
    public string financialNed                  {get;set;}
    public string brokerFeeComission            {get;set;}
    public Boolean multiCurrency                 {get;set;}
    public string lineOfBussines                {get;set;}
    public Decimal amount                       {get;set;}
    public string collateral                    {get;set;}
    public Decimal brokerFeeCommisionPercent    {get;set;}
    public string opportunityName               {get;set;}
    public string opportunityId                 {get;set;}
   }

   public class ClosingMemoTKDPricing{
    public ClosingMemoTKDPricingEstructure estructure {get;set;}
    public ClosingMemoTKDPricingEconomics  economics  {get;set;}
    public string pricingName            {get;set;}
    public string pricingId              {get;set;}
   }

   public class ClosingMemoTKDPricingEstructure{
       public string pcngProduct            {get;set;}
       public string pcngCurrency           {get;set;}
       public Decimal amountToFinancek      {get;set;}
       public string freqMontlyQuartely     {get;set;}
       public string arrears                {get;set;}
       public Integer termInMontsIPP        {get;set;}
       public Integer termInMontsWPP        {get;set;}
       public Integer progressPaymentsM     {get;set;}
       public Integer gracePeriodM          {get;set;}
       public string typeOfGracePeriod      {get;set;}
       public string lowHig_HigLow          {get;set;}
       public string lhDescription          {get;set;}
       public Decimal advancePayment        {get;set;}
       public string eFA                    {get;set;}
       public string usedNew                {get;set;}
       public string sYLByesNo              {get;set;}
       public string progressDescription    {get;set;}
       public string eBO                    {get;set;}
       public string eBoDescription         {get;set;}
       public string equipmentToFinance     {get;set;}
       public string assetDescription       {get;set;}
       public string returnCondition        {get;set;}
       public Decimal remarketingFee        {get;set;}
       public Decimal splitTrack            {get;set;}
       public Decimal lockFee               {get;set;}
       public string  bootCollateralType    {get;set;}
       public string eolOption              {get;set;}
       public string promNote               {get;set;}
       public string cargaPeligrosa         {get;set;}
       public string cashCollateral         {get;set;}
       public string collectionRights       {get;set;}
       public string crossCollateral        {get;set;}
       public string directDebit            {get;set;}
   }

   public class ClosingMemoTKDPricingEconomics{
    public Decimal expenseAni               {get;set;}
    public Decimal rOIWithInsurance         {get;set;}
    public Decimal rOINoInsurance           {get;set;}
    public Decimal bookYield                {get;set;}
    public Decimal openingFee               {get;set;}
    public Decimal sd                       {get;set;}
    public Decimal sdPercent                {get;set;}
    public string sdComment                 {get;set;}
    public string rateFixedFloating         {get;set;}
    public Decimal rate                     {get;set;}
    public Decimal rv                       {get;set;}
    public Decimal ballonBulletPayment      {get;set;}
    public Decimal pOption                  {get;set;}
    public Date lastUpdate                  {get;set;}
   }

   public class SpecialCondition{
    public string specialCondition {get;set;}
   }

   public class CovenanQualitativo{
    public string covenantCualitativo {get;set;}
   }

   public class CovenanQuantitativo{
       public string covenantCuantitativo {get;set;}
   }
}