let startDate;
let ssso;
let takedownNum;
let requestId;

export default class Comments{
    constructor(strtDate,sso, takedownNumero, requesTtId) {
        startDate = strtDate;
        ssso = sso;
        takedownNum = takedownNumero;
        requestId = requesTtId;
    }

    replacer(name, val){
        return val===null?'':val;
    }

    generateComment(){
        let postJSON ={
            requestComment: {
                requestId: requestId,
                comSection: '',
                comComment: `TAKEDOWN: ${takedownNum}`,
                comCreatedBy: ssso,
                comCreationDate: startDate,
                comUpdatedBy: ssso,
                comLastUpdateDate: startDate
            }
        }

        return JSON.stringify(postJSON, this.replacer);
    }
}