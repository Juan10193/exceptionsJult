/**
 * @File Name          : ApprovalProccessInstanceStepComment.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 4/6/2020 17:16:04
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, api, wire } from 'lwc';
import APISComment from '@salesforce/apex/APInstanceStepCommentController.getApprovalProccessInstanceStepComment'

export default class ApprovalProccessInstanceStepComment extends LightningElement {
    @api recordId;

    @wire(APISComment, { proccessInstanceStepId:  "$recordId" })
    wireGetRecord
    

}