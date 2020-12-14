//Juand
import requestToContent from "@salesforce/apex/LMM_TolgateController.requestToContent";
import unlockRecord from "@salesforce/apex/LMM_TolgateController.unlockRecord";
import lockRecord from "@salesforce/apex/LMM_TolgateController.lockRecord";
import updateField from "@salesforce/apex/LMM_TolgateController.updateFieldValidation";

function getSObject(data) {
  return {
    sobjectType: data.apiName,
    ...Object.keys(data.fields).reduce((a, f) => {
      a[f] = data.fields[f].value;
      return a;
    }, {})
  };
}

function getExclude(data) {
  try {
    if (data.Documents_to_Exclude__c) {
      let exclude = data.Documents_to_Exclude__c.split("|");
      console.log(exclude);
      return exclude;
    }
  } catch (error) {
     console.log('Error al traer documentos a excluir')
     console.log(error)
  }
  

  return [];
}


async function callTollgate(mensaje){
  console.log('Mensaje para tollgate')
  console.log(mensaje)
   let tollgates = await requestToContent({encritpData:mensaje});
   console.log('LOS COLGATES')
   console.log(tollgates)
   let validations = compareData(JSON.parse(tollgates));
   return validations;
}


function compareData(jsonData){
  if(jsonData.identifiers !== undefined && jsonData.identifiers !== null){
      let contentValues = jsonData.identifiers.map((val)=>{
         if(val.processFiles  != null){
            val.processFiles.forEach(file => {
              file.entidad =val.name;
          });

          return val.processFiles;
         }else{
           return [];
         }
         
      })

      let contentDocs=[];

      contentValues.forEach(row=>{
          row.forEach(col=>{
            contentDocs.push(col);
          })
      })
  
      let requiredVilations = contentDocs.filter(({required, isValid})=> required ===1 & isValid ===0)
      console.log('DOCUMENTOS FALTANTES')
      console.log(requiredVilations);
      return requiredVilations;
  }

  return undefined;
}


async function updateValidatopmField (recordId, objectApiName, fieldtoUpdate){
  console.log('El record Id para desbloquear es : ')
  console.log(recordId);
  console.log('El object api name es =: ' + objectApiName);
  let recordIsBlocked;
  try {
    recordIsBlocked = await unlockRecord({recordId:recordId, objectApiName:objectApiName});
  } catch (error) {
    console.log('Erro al desbloquear el registro');
    console.log(error);
  }

  try{
    await updateField({recordId:recordId, objectApiName:objectApiName, fieldtoUpdate:fieldtoUpdate});
    console.log('TOLLGATE VALIDADO');
  }catch(error){
    console.log(`Error al actualizar el campo de validacion ${fieldtoUpdate}`);
    console.log(error);
  }

  if(recordIsBlocked = true){
    try{
      await lockRecord({recordId:recordId, objectApiName:objectApiName});
    }catch(error){
      console.log('error al volver a bloquear el registro');
      console.log(error);
    }
  }
  
}

export { getSObject, getExclude, callTollgate, updateValidatopmField };