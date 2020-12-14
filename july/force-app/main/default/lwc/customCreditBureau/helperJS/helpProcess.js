let mapRequestStep1 = (valueInputs, valueComboBoxInputs, entityInfo, EmployeeNumber, LetterSigningDate) => {
    console.log('Inicia')
    let numberPartyID = Number(entityInfo.entityInfo.entity.partyID)
    let dateToday = new Date().toISOString().replace('Z', '-0500');
    console.log('dateToday ' + dateToday)
    let mapRequest = {
        "request": {
            "header": {
                "requestId": null,
                "requestType": "ADVANCED CREDIT BUREAU",
                "partyId": entityInfo.entityInfo.entity.partyID,
                "applicationCode": "SF",
                "startDate": dateToday,
                "requestStatus": "NEW",
                "createdBy": EmployeeNumber,
                "requestedBy": EmployeeNumber,
                "activeFlag": "Y",
                "creationDate": dateToday,
                "updatedBy": EmployeeNumber,
                "lastUpdateDate": dateToday
            }
        },
        "detail": {
            "creditBureau": {
                "cbrfc": '',
                "cbCustomerType": entityInfo.entityInfo.entity.customerType,
                "cbName": '',
                "cbSecondName": '',
                "cbLastName": '',
                "cbSecondLastName": '',
                "cbAPIRequestor": EmployeeNumber,
                "cbMunicipality": '',
                "cbOutNum": '',
                "cbaddress": "CREDIT_CONTACT",
                "cbecEntity": '',
                "cbletterSigningDate": '',
                //"cbletterSigningDate": LetterSigningDate,
                "cbalias": '',
                "cbstreetAndNumber": '',
                "cbsuburb": '',
                "cbzipCode": '',
                "cbcity": '',
                "cbstate": '',
                "cbcountry": '',
                "cbautorizationLetter": '',
                "cbTransactionId": '',
                "cbcompanyName": ''
            }
        }
    }
    
   
    /*function appendLeadingZeroes(n){
        if(n <= 9){
          return "0" + n;
        }
        return n
      }
      LetterSigningDate = Date.parse()
      //let current_datetime = new Date()
      //console.log('current_datetime.toString() ' + LetterSigningDate.toString());
      let formatted_date =   appendLeadingZeroes(LetterSigningDate.getDate()) + "/" + appendLeadingZeroes(LetterSigningDate.getMonth() + 1) + "/" + LetterSigningDate.getFullYear()
      
      console.log('formatted_date ' + formatted_date);*/

    console.log('mapRequest ' + JSON.stringify(mapRequest))
    valueInputs.forEach(function (element) {

        if (element.name === "RFC") {
            mapRequest.detail.creditBureau.cbrfc = element.value
        } else if (element.name === "Name") {
            mapRequest.detail.creditBureau.cbName = element.value
        } else if (element.name === "SecondName") {
            mapRequest.detail.creditBureau.cbSecondName = element.value
        } else if (element.name === "LastName") {
            mapRequest.detail.creditBureau.cbLastName = element.value
        } else if (element.name === "SecondLastName") {
            mapRequest.detail.creditBureau.cbSecondLastName = element.value
        } else if (element.name === "Municipality") {
            mapRequest.detail.creditBureau.cbMunicipality = element.value
        } else if (element.name === "OutNum") {
            mapRequest.detail.creditBureau.cbOutNum = element.value
        } else if (element.name === "ECEntity") {
            mapRequest.detail.creditBureau.cbecEntity = element.value
        } else if (element.name === "StreetAndNumber") {
            mapRequest.detail.creditBureau.cbstreetAndNumber = element.value
        } else if (element.name === "SubUrb") {
            mapRequest.detail.creditBureau.cbsuburb = element.value
        } else if (element.name === "ZipCode") {
            mapRequest.detail.creditBureau.cbzipCode = element.value
        } else if (element.name === "City") {
            mapRequest.detail.creditBureau.cbcity = element.value
        } else if (element.name === "State") {
            mapRequest.detail.creditBureau.cbstate = element.value
        } else if (element.name === "Country") {
            mapRequest.detail.creditBureau.cbcountry = element.value
        } else if (element.name === "CompanyName") {
            mapRequest.detail.creditBureau.cbcompanyName = element.value
        } else if (element.name === "CompanyName") {
            mapRequest.detail.creditBureau.cbcompanyName = element.value
        }
    }, this);

    valueComboBoxInputs.forEach(element => {
        if (element.name === "ECEntity") {
            mapRequest.detail.creditBureau.cbecEntity = element.value
        } else if (element.name === "AutorizationLetter") {
            mapRequest.detail.creditBureau.cbautorizationLetter = element.value
        }
    });

    return mapRequest
}



let mapRequestStep2 = (jsonRequest, jsonResponse) => {
    jsonRequest.request.header.requestId = jsonResponse.requestId
    jsonRequest.request.header.requestStatus = 'ACB REQUEST'
    
    return jsonRequest
}

let initialiceForm = (valueInputs, valueComboBoxInputs, jsonRequest) => {
    console.log('jsonRequest ' + JSON.stringify(jsonRequest))

    valueInputs.forEach(function (element) {
        if (element.name === "RFC") {
            element.value = jsonRequest.detail.creditBureau.cbrfc
        } else if (element.name === "Name") {
            element.value = jsonRequest.detail.creditBureau.cbName
        } else if (element.name === "SecondName") {
            element.value = jsonRequest.detail.creditBureau.cbSecondName
        } else if (element.name === "LastName") {
            element.value = jsonRequest.detail.creditBureau.cbLastName
        } else if (element.name === "SecondLastName") {
            element.value = jsonRequest.detail.creditBureau.cbSecondLastName
        } else if (element.name === "Municipality") {
            element.value = jsonRequest.detail.creditBureau.cbMunicipality
        } else if (element.name === "OutNum") {
            element.value = jsonRequest.detail.creditBureau.cbOutNum
        } else if (element.name === "ECEntity") {
            element.value = jsonRequest.detail.creditBureau.cbecEntity
        } else if (element.name === "StreetAndNumber") {
            element.value = jsonRequest.detail.creditBureau.cbstreetAndNumber
        } else if (element.name === "SubUrb") {
            element.value = jsonRequest.detail.creditBureau.cbsuburb
        } else if (element.name === "ZipCode") {
            element.value = jsonRequest.detail.creditBureau.cbzipCode
        } else if (element.name === "City") {
            element.value = jsonRequest.detail.creditBureau.cbcity
        } else if (element.name === "State") {
            element.value = jsonRequest.detail.creditBureau.cbstate
        } else if (element.name === "Country") {
            element.value = jsonRequest.detail.creditBureau.cbcountry
        } else if (element.name === "AutorizationLetter") {
            element.value = jsonRequest.detail.creditBureau.cbautorizationLetter
        } else if (element.name === "CompanyName") {
            element.value = jsonRequest.detail.creditBureau.cbcompanyName
        }
    }, this);

    valueComboBoxInputs.forEach(element => {
        if (element.name === "ECEntity") {
            element.value = jsonRequest.detail.creditBureau.cbecEntity
        } else if (element.name === "AutorizationLetter") {
            element.value = jsonRequest.detail.creditBureau.cbautorizationLetter 
        }
    });
}

let initialiceFormWithEntity = (valueInputs, addressData, entityData) => {

    valueInputs.forEach(function (element) {
        if (element.name === "RFC") {
            element.value = entityData.entityInfo.entity.rfc
        } else if (element.name === "Name") {
            element.value = entityData.entityInfo.entity.firstName
        } else if (element.name === "SecondName") {
            element.value = entityData.entityInfo.entity.middleName
        } else if (element.name === "LastName") {
            element.value = entityData.entityInfo.entity.firstLastName
        } else if (element.name === "SecondLastName") {
            element.value = entityData.entityInfo.entity.secondLastName
        } else if (element.name === "Municipality") {
            element.value = addressData.municipality
        } else if (element.name === "OutNum") {
            element.value = addressData.outdoorNumber
        }/* else if (element.name === "ECEntity") {
            element.value = jsonRequest.detail.creditBureau.cbecEntity 
        } */else if (element.name === "StreetAndNumber") {
            element.value = addressData.street
            /*} else if (element.name === "SubUrb") {
                element.value = jsonRequest.detail.creditBureau.cbsuburb */
        } else if (element.name === "ZipCode") {
            element.value = addressData.zipCode
        } else if (element.name === "City") {
            element.value = addressData.city
        } else if (element.name === "State") {
            element.value = addressData.state
        } else if (element.name === "Country") {
            element.value = addressData.county
        } /*else if (element.name === "AutorizationLetter") {
            element.value = jsonRequest.detail.creditBureau.cbautorizationLetter 
        } else if (element.name === "CompanyName") {
            element.value = jsonRequest.detail.creditBureau.cbcompanyName 
        }*/
    }, this);
}

let makeRequestStepThree = (entityData, selectedRequestId, EmployeeNumber) => {
    let dateToday = new Date().toISOString().replace('Z', '-0500');
    console.log('dateToday ' + dateToday)

    console.log('entityData ' + JSON.stringify(entityData))
    console.log('entityData.entityInfo.entity.partyID ' + entityData.entityInfo.entity.partyID)
    console.log('entityData.entityInfo.entity.economicGroupId ' + entityData.entityInfo.entity.economicGroupId)
    console.log('entityData.entityInfo.entity.economicGroupName ' + entityData.entityInfo.entity.economicGroupName)
    return {
        "getRequest": {
            "parameter": {
                "type": "REQUEST",
                "subtype": "DETAIL",
                "createdBy": EmployeeNumber,
                "creationDate": dateToday,
                "request": {
                    "requestId": Number(selectedRequestId),
                    "applicationName": "SF",
                    "requestType": "ADVANCED CREDIT BUREAU",
                    "partyId": entityData.entityInfo.entity.partyID,
                    "economicGroupId": entityData.entityInfo.entity.economicGroupId,
                    "partyName": "",
                    "economicGroupName": entityData.entityInfo.entity.economicGroupName
                }
            }
        }
    }
    /*return {
        "getRequest": {
          "parameter": {
            "type": "REQUEST",
            "subtype": "DETAIL",
            "createdBy": "500001000",
            "creationDate": "2020-04-16T04:14:22.000Z",
            "request": {
              "requestId": 5592,
              "applicationName": "SF",
              "requestType": "ADVANCED CREDIT BUREAU",
              "partyId": 0,
              "economicGroupId": 0,
              "partyName": "",
              "economicGroupName": ""
            }
          }
        }
      }*/
}





export { mapRequestStep1, mapRequestStep2, initialiceForm, initialiceFormWithEntity, makeRequestStepThree }