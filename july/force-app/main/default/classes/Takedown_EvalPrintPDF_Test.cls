@Istest
public class Takedown_EvalPrintPDF_Test {
 	@Istest
    static void printPdfTest(){
       String json=		'{'+
		'  "requests": {'+
		'    "request": ['+
		'      {'+
		'        "header": {'+
		'          "requestId": 5794,'+
		'          "requestType": "EVAL",'+
		'          "ndaType": "Booking",'+
		'          "sourceTopParentId": "0018A00000NNqzS",'+
		'          "sourceTopParentName": "Fabian Brisolo",'+
		'          "partyId": 1035483,'+
		'          "partyName": "FABIANSILLO BRISOLO BRITOS PER",'+
		'          "startDate": "2020-06-11T11:35:17.000-05:00",'+
		'          "endDate": "2020-09-09T11:41:24.000-05:00",'+
		'          "requestStatus": "APPROVED",'+
		'          "createdBy": "223005130",'+
		'          "nameCreatedBy": "Narain Harjani",'+
		'          "requestedBy": "223005130",'+
		'          "nameRequestedBy": "Narain Harjani",'+
		'          "assignedGroup": "APP EVAL GROUP",'+
		'          "assignedTo": "223005130",'+
		'          "nameAssignedTo": "Narain Harjani",'+
		'          "activeFlag": "Y",'+
		'          "creationDate": "2020-06-11T11:35:17.000-05:00",'+
		'          "updatedBy": "223005130",'+
		'          "nameUpdatedBy": "Narain Harjani",'+
		'          "lastUpdateDate": "2020-06-11T11:41:24.000-05:00",'+
		'          "nameSolvedBy": " ",'+
		'          "solvedDate": "2020-06-11T11:41:24.000-05:00",'+
		'          "docTypes": {'+
		'            "docType": ['+
		'              {'+
		'                "id": 1,'+
		'                "name": "Valuations",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              },'+
		'              {'+
		'                "id": 8,'+
		'                "name": "E-Val for Prospect",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              },'+
		'              {'+
		'                "id": 29,'+
		'                "name": "Appraisals",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              },'+
		'              {'+
		'                "id": 32,'+
		'                "name": "Equipment Field Audit (EFA)",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              },'+
		'              {'+
		'                "id": 51,'+
		'                "name": "E-Val for Transaction",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              },'+
		'              {'+
		'                "id": 66,'+
		'                "name": "E-val",'+
		'                "reqFlag": "N",'+
		'                "processName": "EVAL",'+
		'                "prm1": "OK"'+
		'              }'+
		'            ]'+
		'          }'+
		'        },'+
		'        "relatedRequests": null,'+
		'        "privileges": {'+
		'          "privilege": ['+
		'            {'+
		'              "section": "PENDING",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "IN PROCESS",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "ON HOLD",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "REWORK",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "REJECTED",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "PRE APPROVED",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "APPROVED",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "AUTO APPROVED",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "CANCELLED BY REQUESTOR",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "WAITING FOR CUSTOMER",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "COMPLETED BY CUSTOMER",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "EDIT",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "NEW DOCUMENT",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "NEW COMMENT",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "SEND TO BURO",'+
		'              "vCrud": "00000"'+
		'            },'+
		'            {'+
		'              "section": "REASSIGN",'+
		'              "vCrud": "00000"'+
		'            }'+
		'          ]'+
		'        },'+
		'        "eval": {'+
		'          "evalHeader": {'+
		'            "evEvalType": "Booking",'+
		'            "evInsuranceReqFlag": "N",'+
		'            "evEfaReqFlag": "N",'+
		'            "evSlbFlag": "N",'+
		'            "evImportsReqFlag": "N",'+
		'            "evProgressPayFlag": "N",'+
		'            "evShowFMVFlag": "N",'+
		'            "evFreezeEvalFlag": "N",'+
		'            "evEquipmentAmount": 5960044,'+
		'            "evEquipmentAmountTax": 5960044,'+
		'            "evEquipmentAmountPercent": 1,'+
		'            "evCostAmount": 0,'+
		'            "evCostAmountTax": 0,'+
		'            "evCostAmountPercent": 0,'+
		'            "evCurrencyType": "MXN",'+
		'            "evExchangeRate": 20,'+
		'            "evAssetCount": 8,'+
		'            "evProductType": "True Lease",'+
		'            "evResidualMaxTermMonths": 36,'+
		'            "evSpecialTermMonths01": 0,'+
		'            "evSpecialTermMonths02": 0,'+
		'            "evSpecialTermMonths03": 0'+
		'          },'+
		'          "evalDetail": {'+
		'            "evAssets": {'+
		'              "evAsset": ['+
		'                {'+
		'                  "evAssetAssetId": 4135,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 2",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745002,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745002,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12876,'+
		'                        "evValAssetId": 4135,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670501.8,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666553.2894,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670501.8,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664318.2834,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12877,'+
		'                        "evValAssetId": 4135,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521501.4,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517552.8894,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521501.4,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515317.8834,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12878,'+
		'                        "evValAssetId": 4135,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409751.1,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405802.5894,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409751.1,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403567.5834,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12879,'+
		'                        "evValAssetId": 4135,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283100.76,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279152.2494,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283100.76,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276917.2434,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3847,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4136,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 3",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745003,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745003,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12880,'+
		'                        "evValAssetId": 4136,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670502.7,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666554.1841,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670502.7,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664319.1751,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12881,'+
		'                        "evValAssetId": 4136,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521502.1,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517553.5841,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521502.1,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515318.5751,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12882,'+
		'                        "evValAssetId": 4136,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409751.65,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405803.1341,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409751.65,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403568.1251,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12883,'+
		'                        "evValAssetId": 4136,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283101.14,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279152.6241,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283101.14,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276917.6151,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3848,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4137,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 4",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745004,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745004,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12884,'+
		'                        "evValAssetId": 4137,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670503.6,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666555.0788,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670503.6,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664320.0668,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12885,'+
		'                        "evValAssetId": 4137,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521502.8,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517554.2788,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521502.8,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515319.2668,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12886,'+
		'                        "evValAssetId": 4137,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409752.2,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405803.6788,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409752.2,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403568.6668,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12887,'+
		'                        "evValAssetId": 4137,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283101.52,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279152.9988,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283101.52,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276917.9868,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3849,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4138,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 5",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745005,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745005,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12888,'+
		'                        "evValAssetId": 4138,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670504.5,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666555.9735,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670504.5,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664320.9585,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12889,'+
		'                        "evValAssetId": 4138,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521503.5,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517554.9735,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521503.5,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515319.9585,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12890,'+
		'                        "evValAssetId": 4138,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409752.75,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405804.2235,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409752.75,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403569.2085,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12891,'+
		'                        "evValAssetId": 4138,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283101.9,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279153.3735,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283101.9,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276918.3585,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3850,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4139,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 6",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745006,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745006,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12892,'+
		'                        "evValAssetId": 4139,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670505.4,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666556.8682,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670505.4,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664321.8502,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12893,'+
		'                        "evValAssetId": 4139,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521504.2,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517555.6682,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521504.2,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515320.6502,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12894,'+
		'                        "evValAssetId": 4139,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409753.3,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405804.7682,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409753.3,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403569.7502,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12895,'+
		'                        "evValAssetId": 4139,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283102.28,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279153.7482,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283102.28,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276918.7302,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3851,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4140,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 7",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745007,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745007,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12896,'+
		'                        "evValAssetId": 4140,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670506.3,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666557.7629,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670506.3,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664322.7419,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12897,'+
		'                        "evValAssetId": 4140,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521504.9,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517556.3629,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521504.9,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515321.3419,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12898,'+
		'                        "evValAssetId": 4140,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409753.85,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405805.3129,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409753.85,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403570.2919,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12899,'+
		'                        "evValAssetId": 4140,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283102.66,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279154.1229,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283102.66,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276919.1019,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3852,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4141,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 8",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745008,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745008,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12900,'+
		'                        "evValAssetId": 4141,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670507.2,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666558.6576,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670507.2,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664323.6336,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12901,'+
		'                        "evValAssetId": 4141,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521505.6,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517557.0576,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521505.6,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515322.0336,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12902,'+
		'                        "evValAssetId": 4141,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409754.4,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405805.8576,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409754.4,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403570.8336,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12903,'+
		'                        "evValAssetId": 4141,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283103.04,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279154.4976,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283103.04,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276919.4736,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3853,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                },'+
		'                {'+
		'                  "evAssetAssetId": 4142,'+
		'                  "evAssetRequestId": 5794,'+
		'                  "evAssetOracleFACategoryId": 147,'+
		'                  "evAssetOracleFACategory": "Camion Bonito 9",'+
		'                  "evAssetCollateralType": "AGRICULTURAL EQUIPMENT",'+
		'                  "evAssetCollateralDescription": "BOILERS",'+
		'                  "evAssetAssetModel": "FK0001",'+
		'                  "evAssetAssetModelYear": "2020",'+
		'                  "evAssetManufacturer": "KENWORTH",'+
		'                  "evAssetCurrencyType": "MXN",'+
		'                  "evAssetQuantity": 1,'+
		'                  "evAssetUnitCost": 745009,'+
		'                  "evAssetUnitTax": 0,'+
		'                  "evAssetFreightCost": 0,'+
		'                  "evAssetParkingCost": 0,'+
		'                  "evAssetInstallationCost": 0,'+
		'                  "evAssetTrainingCost": 0,'+
		'                  "evAssetWarrantyCost": 0,'+
		'                  "evAssetSoftwareCost": 0,'+
		'                  "evAssetConditionType": "NEW",'+
		'                  "evAssetTotalCost": 745009,'+
		'                  "evAssetInsuranceType": "Engenium Capital",'+
		'                  "evAssetMultLocationFlag": "N",'+
		'                  "evAssetRapidTagFlag": "Y",'+
		'                  "evAssetImportFlag": "N",'+
		'                  "evAssetValuations": {'+
		'                    "evValuation": ['+
		'                      {'+
		'                        "evValValuationId": 12904,'+
		'                        "evValAssetId": 4142,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 0,'+
		'                        "evValFmvAmount": 670508.1,'+
		'                        "evValFmvPercent": 0.9,'+
		'                        "evValNrvAmount": 666559.5523,'+
		'                        "evValNrvPercent": 0.8947,'+
		'                        "evValOlvAmount": 670508.1,'+
		'                        "evValOlvPercent": 0.9,'+
		'                        "evValRvAmount": 664324.5253,'+
		'                        "evValRvPercent": 0.8917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12905,'+
		'                        "evValAssetId": 4142,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 12,'+
		'                        "evValFmvAmount": 521506.3,'+
		'                        "evValFmvPercent": 0.7,'+
		'                        "evValNrvAmount": 517557.7523,'+
		'                        "evValNrvPercent": 0.6947,'+
		'                        "evValOlvAmount": 521506.3,'+
		'                        "evValOlvPercent": 0.7,'+
		'                        "evValRvAmount": 515322.7253,'+
		'                        "evValRvPercent": 0.6917,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12906,'+
		'                        "evValAssetId": 4142,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 24,'+
		'                        "evValFmvAmount": 409754.95,'+
		'                        "evValFmvPercent": 0.55,'+
		'                        "evValNrvAmount": 405806.4023,'+
		'                        "evValNrvPercent": 0.5447,'+
		'                        "evValOlvAmount": 409754.95,'+
		'                        "evValOlvPercent": 0.55,'+
		'                        "evValRvAmount": 403571.3753,'+
		'                        "evValRvPercent": 0.5417,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      },'+
		'                      {'+
		'                        "evValValuationId": 12907,'+
		'                        "evValAssetId": 4142,'+
		'                        "evValRequestId": 5794,'+
		'                        "evValTermMonths": 36,'+
		'                        "evValFmvAmount": 283103.42,'+
		'                        "evValFmvPercent": 0.38,'+
		'                        "evValNrvAmount": 279154.8723,'+
		'                        "evValNrvPercent": 0.3747,'+
		'                        "evValOlvAmount": 283103.42,'+
		'                        "evValOlvPercent": 0.38,'+
		'                        "evValRvAmount": 276919.8453,'+
		'                        "evValRvPercent": 0.3717,'+
		'                        "evValInsurancePrima": 0,'+
		'                        "evValActiveFlag": "Y",'+
		'                        "evValCreatedBy": "223005130",'+
		'                        "evValNameCreatedBy": "Narain Harjani",'+
		'                        "evValCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                        "evValNameUpdatedBy": " ",'+
		'                        "evValLastUpdateDate": "2020-06-11T11:35:19.000-05:00"'+
		'                      }'+
		'                    ]'+
		'                  },'+
		'                  "evAssetActiveFlag": "Y",'+
		'                  "evAssetClonedAssetId": 3854,'+
		'                  "evAssetCreatedBy": "223005130",'+
		'                  "evAssetNameCreatedBy": "Narain Harjani",'+
		'                  "evAssetCreationDate": "2020-06-11T11:35:17.000-05:00",'+
		'                  "evAssetNameUpdatedBy": " ",'+
		'                  "evAssetLastUpdateDate": "2020-06-11T11:35:18.000-05:00"'+
		'                }'+
		'              ]'+
		'            }'+
		'          }'+
		'        },'+
		'        "comments": {'+
		'          "comment": ['+
		'            {'+
		'              "requestId": 1621,'+
		'              "comComment": "TAKEDOWN: TD_CP-000008797",'+
		'              "comCreatedBy": "223005130",'+
		'              "comNameCreatedBy": "Narain Harjani",'+
		'              "comCreationDate": "2020/06/11 11:35:17",'+
		'              "comUpdatedBy": "161",'+
		'              "comNameUpdatedBy": "Narain Harjani",'+
		'              "comLastUpdateDate": "2020/06/11 11:35:17"'+
		'            }'+
		'          ]'+
		'        },'+
		'        "audits": {'+
		'          "audit": ['+
		'            {'+
		'              "auditUpdatedBy": "223005130",'+
		'              "auditNameUpdatedBy": "Narain Harjani",'+
		'              "auditLastUpdateDate": "2020/06/11 11:41:23",'+
		'              "auditField": "Status",'+
		'              "auditLastValue": "3",'+
		'              "auditNewValue": "8",'+
		'              "auditComment": "El valor del campo"'+
		'            },'+
		'            {'+
		'              "auditUpdatedBy": "223005130",'+
		'              "auditNameUpdatedBy": "Narain Harjani",'+
		'              "auditLastUpdateDate": "2020/06/11 11:41:06",'+
		'              "auditField": "Status",'+
		'              "auditLastValue": "2",'+
		'              "auditNewValue": "3",'+
		'              "auditComment": "El valor del campo"'+
		'            },'+
		'            {'+
		'              "auditUpdatedBy": "223005130",'+
		'              "auditNameUpdatedBy": "Narain Harjani",'+
		'              "auditLastUpdateDate": "2020/06/11 11:41:06",'+
		'              "auditField": "Assigned To",'+
		'              "auditNewValue": "161",'+
		'              "auditComment": "El valor del campo"'+
		'            },'+
		'            {'+
		'              "auditUpdatedBy": "223005130",'+
		'              "auditNameUpdatedBy": "Narain Harjani",'+
		'              "auditLastUpdateDate": "2020/06/11 11:41:01",'+
		'              "auditField": "Status",'+
		'              "auditLastValue": "1",'+
		'              "auditNewValue": "2",'+
		'              "auditComment": "El valor del campo"'+
		'            }'+
		'          ]'+
		'        }'+
		'      }'+
		'    ]'+
		'  },'+
		'  "status": {'+
		'    "code": 200,'+
		'    "message": "Success",'+
		'    "detail": "S"'+
		'  }'+
		'}';
        try{
            Takedown_EvalPrintPDF.printPdf(json, '123');
        }catch(Exception e){
            
        }
            
        
    } 
}