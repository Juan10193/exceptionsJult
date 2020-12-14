@IsTest
public class Tkd_Wrapper_assets_test {
	static testMethod void testParse() {
		String json = '{'+
		'            \"request\" : {'+
		'              \"header\" : {'+
		'                \"requestId\" : \"\",'+
		'                \"requestType\" : \"EVAL\",'+
		'                \"applicationCode\" : \"SF\",'+
		'                \"partyId\" : \"13073\",'+
		'                \"requestStatus\" : \"NEW\",'+
		'                \"requestedBy\" : \"\",'+
		'                \"startDate\" : \"2020-05-22T13:48:06.000-00:00\",'+
		'                \"endDate\" : \"\",'+
		'                \"rootRequestId\" : \"\",'+
		'                \"assignedTo\" : \"\",'+
		'                \"ndaType\" : \"\",'+
		'                \"sourceAccountId\" : \"\",'+
		'                \"sourceAccountName\" : \"\",'+
		'                \"sourceTopParentId\" : \"001R000001YspD9\",'+
		'                \"sourceTopParentName\" : \"Aselec Electricidad\",'+
		'                \"partyName\" : \"ABA, S.A. DE C.V.\",'+
		'                \"egPartyId\" : \"\",'+
		'                \"egPartyName\" : \"\",'+
		'                \"sourceOpId\" : \"\",'+
		'                \"sourceCAId\" : \"\",'+
		'                \"createdBy\" : \"\",'+
		'                \"assignedGroup\" : \"\",'+
		'                \"assignedDate\" : \"\",'+
		'                \"activeFlag\" : \"Y\",'+
		'                \"creationDate\" : \"2020-05-22T13:48:06.000-00:00\",'+
		'                \"updatedBy\" : \"\",'+
		'                \"lastUpdateDate\" : \"2020-05-22T13:48:06.000-00:00\",'+
		'                \"solvedBy\" : \"\",'+
		'                \"solvedDate\" : \"\",'+
		'                \"finantialEntity\" : \"\"'+
		'              }'+
		'            },'+
		'            \"detail\" : {'+
		'              \"eval\" : {'+
		'                \"evalHeader\" : {'+
		'                  \"evEvalType\" : \"Proposal\",'+
		'                  \"evInsuranceReqFlag\" : \"N\",'+
		'                  \"evEfaReqFlag\" : \"\",'+
		'                  \"evSlbFlag\" : \"N\",'+
		'                  \"evImportsReqFlag\" : \"\",'+
		'                  \"evProgressPayFlag\" : \"N\",'+
		'                  \"evShowFMVFlag\" : \"\",'+
		'                  \"evFreezeEvalFlag\" : \"\",'+
		'                  \"evFreezeStartDate\" : \"\",'+
		'                  \"evFreezeEndDate\" : \"\",'+
		'                  \"evProgressPayTermMonths\" : \"\",'+
		'                  \"evEquipmentAmount\" : \"\",'+
		'                  \"evEquipmentAmountTax\" : \"\",'+
		'                  \"evEquipmentAmountPercent\" : \"\",'+
		'                  \"evCostAmount\" : \"\",'+
		'                  \"evCostAmountTax\" : \"\",'+
		'                  \"evCostAmountPercent\" : \"\",'+
		'                  \"evCurrencyType\" : \"USD\",'+
		'                  \"evExchangeRate\" : \"\",'+
		'                  \"evAssetCount\" : \"\",'+
		'                  \"evProductType\" : \"Quasi Lease\",'+
		'                  \"evResidualMaxTermMonths\" : \"120\",'+
		'                  \"evSpecialTermMonths01\" : \"23\",'+
		'                  \"evSpecialTermMonths02\" : \"23\",'+
		'                  \"evSpecialTermMonths03\" : \"23\",'+
		'                  \"evEndorsementComment\" : \"\"'+
		'                }'+
		'              },'+
		'              \"sicCode\" : {'+
		'                \"sicProposedId\" : \"\",'+
		'                \"sicProposedDescription\" : \"\",'+
		'                \"sicId\" : \"\",'+
		'                \"sicDescription\" : \"\"'+
		'              },'+
		'              \"laActiveFlag\" : \"Y\",'+
		'              \"laCreatedBy\" : \"Daniel\",'+
		'              \"PINCREATEDBY\" : \"Xico\",'+
		'              \"laCreationDate\" : \"2020-05-22T13:48:06.000-00:00\",'+
		'              \"laLastUpdatedBy\" : \"\",'+
		'              \"laLastUpdateDate\" : \"2020-05-22T13:48:06.000-00:00\"'+
		'            }'+
		'          }';
		Tkd_Wrapper_assets obj = Tkd_Wrapper_assets.parse(json);
		System.assert(obj != null);
	}
}