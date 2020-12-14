let validateIfChange = (valueInputs, valueRecord) => {
    let someFileHasChanged = false
    valueInputs.forEach(function (element) {
        console.log('element ' + JSON.stringify(element))
    }, this);
    return true;    
}
export {validateIfChange};