/**
 * @File Name          : CotizadorWSWrapper.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 5/5/2020 17:37:32
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    5/5/2020   eduardo.amiens@outlook.com     Initial Version
**/
public class CotizadorWSWrapper {
    public class HeadRequest {
        public string userId{get;set;}  
        public string programId{get;set;}
        public data data{get;set;}
    }
    public class data{
        public detFreeQuotationDTO detFreeQuotationDTO      {get;set;}
        public string strClientName                         {get;set;}
        public financialType financialType                  {get;set;}
        public stateDTO stateDTO                            {get;set;}
        public financialTermsDTO financialTermsDTO          {get;set;}
        public list<lstQuotationAssets> lstQuotationAssets  {get;set;}
        public currencyDTO currencyDTO                      {get;set;}
        public quoteDetailDTO quoteDetailDTO                {get;set;}
        public financialInsuranceDTO financialInsuranceDTO  {get;set;}
        public financialTypeDTO financialTypeDTO            {get;set;}
    }
    public class detFreeQuotationDTO {
        public string strRfc                                {get;set;}
        public annualIncomeTypeDTO annualIncomeTypeDTO      {get;set;}
        public string strPersonType                         {get;set;}
    }
    public class annualIncomeTypeDTO {
        public string strDescription                        {get;set;}
        public long dtModifiedOn                            {get;set;} //null
        public integer intAnnualIncomeTypeId                {get;set;}
        public long dtCreatedOn                             {get;set;} //null
    }


    public class financialType {
        public string strDescription                        {get;set;}
        public string strFinancialTypeKey                   {get;set;}
        public statusDTO statusDTO                          {get;set;}
        public integer intFinancialTypeId                    {get;set;}
        public long dtCreatedOn                           {get;set;} // no pelar
        public boolean selected                             {get;set;}
    }
    public class statusDTO {
        public string strDescription                        {get;set;}
        public string strStatusKey                          {get;set;}
        public integer intStatusId                          {get;set;}
        public long dtCreatedOn                          {get;set;} //no pelar
    }
    public class stateDTO {
        public countryDTO countryDTO                        {get;set;}
        public string strName                               {get;set;}
        public string strCode                               {get;set;}
        public integer intNumber                            {get;set;}        
        public integer intStateId                           {get;set;}
    }
    public class countryDTO {
        public string strName                               {get;set;} //null no pelar
        public string intCountryId                          {get;set;} //
        public string strCode                               {get;set;}
        public integer intNumber                            {get;set;}
    }
    public class financialTermsDTO {
        public string strDescription                        {get;set;}
        public integer intTermValue                         {get;set;}
        public statusDTO statusDTO                          {get;set;}
        public string intFinancialTermId                    {get;set;}
        public long dtCreatedOn                          {get;set;}
        public boolean selected                             {get;set;} 
    }
    public class lstQuotationAssets {
        public integer lngAssetId                           {get;set;}
        public coverageDTO coverageDTO                      {get;set;}
        public integer intYear                               {get;set;}
        public assetDTO assetDTO                            {get;set;}
        public string fltAmount                             {get;set;}
        public integer intQuantity                          {get;set;}

    }
    public class coverageDTO {
        public string strDescription                        {get;set;}
        public integer bgdCoverageCost                      {get;set;}
        public integer intCoverageId                        {get;set;}
        public double bgdFactor                              {get;set;}
    }
    public class assetDTO {
        public string strDescription                        {get;set;}
        public integer lngAssetId                           {get;set;}
        public string strModel                              {get;set;}
        public groupDTO groupDTO                            {get;set;}
        public string strBrand                              {get;set;}
    }
    public class groupDTO {
        public string strDescription                        {get;set;}
        public integer intGroupId                            {get;set;}
    }
    public class currencyDTO {
        public string strDescription                        {get;set;}
        public statusDTO statusDTO                          {get;set;}
        public string strCurrencyCode                       {get;set;}
        public integer intCurrencyId                        {get;set;}
        public boolean selected                             {get;set;}
    }
    public class quoteDetailDTO {
        public currencyAssetsDTO currencyAssetsDTO          {get;set;}    
    }
    public class currencyAssetsDTO {
        public string strDescription                        {get;set;}  
        public statusDTO statusDTO                          {get;set;}
        public string strCurrencyCode                       {get;set;}
        public integer intCurrencyId                        {get;set;}  
        public boolean selected                             {get;set;}
    }
    public class financialInsuranceDTO {
        public string strDescription                        {get;set;}
        public integer intFinancialInsuranceId              {get;set;}
        public string statusDTO                             {get;set;}
        public long dtCreatedOn                           {get;set;}
    }
    public class financialTypeDTO {
        public string strDescription                        {get;set;}
        public string strFinancialTypeKey                   {get;set;}
        public statusDTO statusDTO                          {get;set;}
        public integer intFinancialTypeId                   {get;set;}
        public long dtCreatedOn                           {get;set;}
        public boolean selected                             {get;set;}
    }
}