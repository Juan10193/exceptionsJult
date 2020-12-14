let asignPickListValues = (datatableColumns, pkValues) => {
    datatableColumns[1].typeAttributes.options = pkValues
    return datatableColumns
}
/*let asignSelectedValuesToPickList = (data,value) => {
    data
    console.log('Hay datos  ' + value)
    let listSelectedValue = []
    if (value !== null & value !== undefined) {
        for (let element of value.split(";")) {
            listSelectedValue.push({
                label: value,
                value: value
            })
        }
    }   
    console.log('final value ' + JSON.stringify(listSelectedValue))
    return listSelectedValue
}*/


export { asignPickListValues }