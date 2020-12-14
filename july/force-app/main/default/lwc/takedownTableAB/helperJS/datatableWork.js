/* eslint-disable no-confusing-arrow */
//let setParentIdToDatatable = (datatableColumns,parentId) => {
function setParentIdToDatatable(datatableColumns,parentId){
    return datatableColumns.map(index =>{
        if(index.fieldName ==='TKD_rb_collateral__c'){
            console.log('index.typeAttributes ' + JSON.stringify(index.typeAttributes))
            index.typeAttributes.recordId = parentId
        }
         return index   
    })
       
}
export {setParentIdToDatatable};