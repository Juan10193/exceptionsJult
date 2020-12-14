import searchRequestId from '@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.searchRequestId';
import Request from './postRequest';
import Comments from './postComments';
import cloneEval from '@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.cloneEval';
import postComment from '@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.postEvalComments';
import { updateRecord } from 'lightning/uiRecordApi';
import LINKEDEVAL_FIELD from '@salesforce/schema/Opportunity.LMM_Linked_Eval__c';
import ID_FIELD from '@salesforce/schema/Opportunity.Id';

let searchEval =(sso, app, requestId)=>{
    return new Promise((resolve, reject) => {
        searchRequestId({sso:sso, app:app, requestId:requestId})
        .then(result=>{
            let resultData = JSON.parse(result);
            resolve(resultData);

        }).catch(error=>{

            reject(new Error(error));
        })
    });
}


let cloneEvalFromEnt = (requestJson, startDate, sso, fromOp, partyid, entityName)=>{
    return new Promise((resolve, reject) => {
        let req = new Request(requestJson, startDate,sso, fromOp, partyid, entityName );
        let jsonPost = req.generatePost();
        console.log(jsonPost);
        cloneEval({jsonReq:jsonPost})
        .then(result =>{
            console.log('resultado del clonado');
            resolve(result);
        }).catch(error=>{
            console.log(error);
            reject(new Error(error));
        })
    });
}

let updateOPPWhitEval=(recordId,evalReqId)=>{

    return new Promise((resolve, reject) => {
        const fields = {};
        fields[LINKEDEVAL_FIELD.fieldApiName] = String(evalReqId);
        fields[ID_FIELD.fieldApiName] = recordId;
        const recordInput = {fields};

        updateRecord(recordInput)
        .then(()=>{
            resolve(
                'Eval added to takedown'
            )
        }).catch(error=>{
            console.log(error);
            reject(
                new Error('Error al linkear el eval al takedown: ' + error.body.message)
            )
        })
    });
}

let postComments = (startDate,sso, takedownNumero, requestId)=>{
    console.log('EL REQUES PORMISE ' + requestId)
    return new Promise((resolve, reject)=>{
        console.log('EL REQUES PORMISE2 ' + requestId)
        let jsonComentReq = new Comments(startDate,sso, takedownNumero, requestId);
        let jsonNcomment = jsonComentReq.generateComment();
        console.log('jsonNcomment')
        console.log(  jsonNcomment)
        postComment({jsoNcomment:jsonNcomment})
        .then(()=>{
            resolve('Takedown added to eval comments')
        }).catch(error=>{
            console.log('Error al agregar takedown a eval comments')
            console.log(error);
            reject(new Error('Error al agregar takedown a eval comments: '  +error.body.message))
        })
    })
}

export {searchEval, cloneEvalFromEnt, updateOPPWhitEval, postComments};