@isTest
public class CotizadorWSWrapper_test {
    @isTest
    static void fillWrapper(){
        CotizadorWSWrapper.HeadRequest HeadRequest = new CotizadorWSWrapper.HeadRequest();  
        	HeadRequest.userId = 'userId';
        HeadRequest.programId = 'programId';

        CotizadorWSWrapper.data data  = new CotizadorWSWrapper.data(); 
        
        CotizadorWSWrapper.detFreeQuotationDTO detFreeQuotationDTO = new CotizadorWSWrapper.detFreeQuotationDTO();
        detFreeQuotationDTO.strRfc = 'detFreeQuotationDTO';
        detFreeQuotationDTO.strPersonType = '';
        CotizadorWSWrapper.annualIncomeTypeDTO annualIncomeTypeDTO = new CotizadorWSWrapper.annualIncomeTypeDTO();
        annualIncomeTypeDTO.strDescription = 'strDescription';
        annualIncomeTypeDTO.dtModifiedOn = null;
        annualIncomeTypeDTO.intAnnualIncomeTypeId = 1;
        annualIncomeTypeDTO.dtCreatedOn = null;
        detFreeQuotationDTO.annualIncomeTypeDTO = annualIncomeTypeDTO;
        data.detFreeQuotationDTO = detFreeQuotationDTO;
        data.strClientName= 'strClientName';
        
        CotizadorWSWrapper.financialType financialType = new CotizadorWSWrapper.financialType();
        financialType.strDescription = 'strDescription';
        financialType.strFinancialTypeKey = 'financialType';
        
        CotizadorWSWrapper.statusDTO statusDTO = new CotizadorWSWrapper.statusDTO();
        statusDTO.strDescription= 'strDescription';
        statusDTO.strStatusKey = 'strStatusKey';
        statusDTO.intStatusId = 1;
        statusDTO.dtCreatedOn = null;
        
        financialType.statusDTO = statusDTO;
        financialType.intFinancialTypeId = 1;
        financialType.dtCreatedOn = null;
        financialType.selected =false;
        data.financialType = financialType;
        
        CotizadorWSWrapper.stateDTO stateDTO = new CotizadorWSWrapper.stateDTO();
        CotizadorWSWrapper.countryDTO countryDTO = new CotizadorWSWrapper.countryDTO();
        countryDTO.intCountryId = 'intCountryId';
        countryDTO.intNumber = 1;
        countryDTO.strCode = 'strCode'; 
        countryDTO.strName = 'strName';
        stateDTO.countryDTO = countryDTO;
        stateDTO.intNumber = 1;
        stateDTO.intStateId = 2;
        stateDTO.strCode = 'strCode';
        stateDTO.strName = 'strName';
        
        data.stateDTO = stateDTO;
        CotizadorWSWrapper.financialTermsDTO financialTermsDTO = new CotizadorWSWrapper.financialTermsDTO();
        financialTermsDTO.strDescription = 'strDescription';
        financialTermsDTO.intTermValue = 1;
        financialTermsDTO.statusDTO = statusDTO;
        financialTermsDTO.intFinancialTermId = 'intFinancialTermId';
        financialTermsDTO.dtCreatedOn = 0;
        financialTermsDTO.selected = true;
        data.financialTermsDTO = financialTermsDTO;
        
        list<CotizadorWSWrapper.lstQuotationAssets> listlstQuotationAssets = new list<CotizadorWSWrapper.lstQuotationAssets>();
        CotizadorWSWrapper.lstQuotationAssets lstQuotationAssets = new CotizadorWSWrapper.lstQuotationAssets();
        lstQuotationAssets.lngAssetId = 1;
        CotizadorWSWrapper.coverageDTO coverageDTO = new CotizadorWSWrapper.coverageDTO();
        coverageDTO.strDescription = 'strDescription';
        coverageDTO.bgdCoverageCost = 1;
        coverageDTO.intCoverageId = 1;
        coverageDTO.bgdFactor = 1;
        
        lstQuotationAssets.coverageDTO = coverageDTO;
        lstQuotationAssets.intYear = 1;
        
        CotizadorWSWrapper.assetDTO assetDTO = new CotizadorWSWrapper.assetDTO();
        assetDTO.strDescription = 'strDescription';
        assetDTO.lngAssetId = 1;  
        assetDTO.strModel = 'strModel';
        
        CotizadorWSWrapper.groupDTO groupDTO = new CotizadorWSWrapper.groupDTO();
        groupDTO.intGroupId = 1;
        groupDTO.strDescription = 'strDescription';
        
        assetDTO.groupDTO = groupDTO;
        assetDTO.strBrand = 'strBrand';
        lstQuotationAssets.assetDTO = assetDTO;
        lstQuotationAssets.fltAmount = 'fltAmount';
        lstQuotationAssets.intQuantity = 1;
        listlstQuotationAssets.add(lstQuotationAssets);
        data.lstQuotationAssets = listlstQuotationAssets;
        
        CotizadorWSWrapper.currencyDTO currencyDTO = new CotizadorWSWrapper.currencyDTO();
        currencyDTO.intCurrencyId = 1;
        currencyDTO.selected = true;
        currencyDTO.statusDTO = statusDTO; 
        currencyDTO.strCurrencyCode = 'strCurrencyCode';
        currencyDTO.strDescription = 'strDescription';
        data.currencyDTO = currencyDTO;
        
        CotizadorWSWrapper.quoteDetailDTO quoteDetailDTO = new CotizadorWSWrapper.quoteDetailDTO();
        CotizadorWSWrapper.currencyAssetsDTO currencyAssetsDTO = new CotizadorWSWrapper.currencyAssetsDTO();
        currencyAssetsDTO.intCurrencyId = 1;
        currencyAssetsDTO.selected = true;
        currencyAssetsDTO.statusDTO = statusDTO;
        currencyAssetsDTO.strCurrencyCode = 'strCurrencyCode';
        currencyAssetsDTO.strDescription = 'strDescription';
        
        quoteDetailDTO.currencyAssetsDTO = currencyAssetsDTO;
        
        data.quoteDetailDTO = quoteDetailDTO;
        
        CotizadorWSWrapper.financialInsuranceDTO financialInsuranceDTO = new CotizadorWSWrapper.financialInsuranceDTO(); 
        financialInsuranceDTO.dtCreatedOn = null;
        financialInsuranceDTO.intFinancialInsuranceId = 1;
        financialInsuranceDTO.statusDTO = 'statusDTO';
        financialInsuranceDTO.strDescription = 'strDescription';
        data.financialInsuranceDTO = financialInsuranceDTO;
        
        CotizadorWSWrapper.financialTypeDTO financialTypeDTO = new CotizadorWSWrapper.financialTypeDTO();
        financialTypeDTO.dtCreatedOn = null;
        financialTypeDTO.intFinancialTypeId = 1;
        financialTypeDTO.selected = true;
        financialTypeDTO.statusDTO = statusDTO;
        financialTypeDTO.strDescription = 'strDescription';
        financialTypeDTO.strFinancialTypeKey = 'strFinancialTypeKey';
        data.financialTypeDTO = financialTypeDTO;
        HeadRequest.data = data;
            
    }

}