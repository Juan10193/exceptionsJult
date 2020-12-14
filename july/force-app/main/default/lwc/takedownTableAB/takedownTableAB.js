/**
 * @File Name          : takedownTableAB.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 3/3/2020 22:07:39
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    22/8/2019 11:05:09   eduardo.villegas@engeniumcapital.com     Initial Version
 **/
import { LightningElement, wire, track, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord, getRecord  } from 'lightning/uiRecordApi';
import initRecords from "@salesforce/apex/Takedown_Table_AB_Controller_cls.initRecords";
import saveData from "@salesforce/apex/Takedown_Table_AB_Controller_cls.saveData";
import getCatalogCollateral from "@salesforce/apex/Takedown_Table_AB_Controller_cls.getCatalogCollateral";
import getTakedownInvoice from '@salesforce/apex/Takedown_Table_AB_Controller_cls.getTakedownInvoice';

import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
//https://daneden.github.io/animate.css/
import Animate from  '@salesforce/resourceUrl/Animate';
import blank from './views/blank.html';
import mainpage from './takedownTableAB.html';
import exceljs from '@salesforce/resourceUrl/exceljs';
import filesaver from '@salesforce/resourceUrl/filesaver';
import {workDownload,prepareHeadersToDownload,prepareHeadersToUpload,setComments,prepareCollateralToUpload} from './helperJS/downloadAssetBreakdown';
import constantes from './helperJS/constantes';
import {setParentIdToDatatable} from './helperJS/datatableWork'
import asset_Object from '@salesforce/schema/Asset';

//EVAL News
import sendEvalApprove from '@salesforce/apex/Takedown_Table_AB_Controller_cls.sendEvalApprove';
import takedownInfo from '@salesforce/apex/Data_Connect_Eval.infoTakeDown';
import updateEntity from '@salesforce/apex/LMM_SynchronizeEntityCPController.updateEntityCP';

import deleteAsset from '@salesforce/apex/Takedown_Table_AB_Controller_cls.deleteAsset';

export default class TakedownTableAB extends LightningElement {
    @api recordid;
    @track columns = constantes.COLUMS;
    @track rowOffset = 0;
    @track tableLoadingState = true;
    @track uploadCSV = false;
    @track showLoadingSpinner = false;
    @track fileName = '';
    @track modalAskUpload = false;
    filesUploaded = [];
    file;
    fileContents;
    fileReader;
    content;
    MAX_FILE_SIZE = 1500000;
    @track headers = [];
    @track headersApi = [];
    @track paginationData = [];
    @track currentData = [];
    @track pageSize = 0;
    @track currentPage;    
    @track error;
    @track _wiredResult;

    /* News attibute for EVAL */
    @track mapData= [];
    @api isLoading = false;
    @track record;
    @track errors; 
    
    connectedCallback() {
        console.log('asset_Object')
        console.log(asset_Object)
        Promise.all([
            loadStyle(this, Animate),
            loadScript(this, exceljs),
            loadScript(this, filesaver)
        ])
        .then(() => { 'scripts cargadinos' })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading resourse',
                    message: error.message,
                    variant: 'error',
                }),
            );
        });
        //this.columns = setParentIdToDatatable(constantes.COLUMS,this.recordid)
    }

    @wire(getRecord , { recordId: "$recordid", fields: ["Takedowns_Contingency_plan__c.CPL_rb_Opp__r.AccountId"] })
    wiredAccount({ error, data }) {
        if (data) {
            console.log('Its data: ' + JSON.stringify(data));
            this.record = data;
            this.errors = undefined;
        } else if (error) {
            console.log('Its error: ' + error);
            this.errors = error;
            this.record = undefined;
        }
    }

    @wire(initRecords, { recordId: "$recordid" })
    wiredInitRecord(result) {
        this.paginationData = [];
        this.currentData = [];
        this.pageSize = 0;
        this._wiredResult = result;
        console.log('_wiredResult ' + JSON.stringify(this._wiredResult))
        if (result.data) {
            console.log('result.data ' + result.data)
            let pagination = [];
            result.data.forEach(dataInit => {
                pagination.push(dataInit);
                if(pagination.length === 10){
                    this.paginationData.push(pagination);
                    pagination = [];    
                }

            });
            console.log('pagination ' + pagination);
            if(pagination.length > 0){
                this.paginationData.push(pagination);
            } 
            if(this.paginationData.length > 0){
                this.currentData = this.paginationData[0];
                this.currentPage = 1;

            } else {
                this.currentPage = 0;    
            }
            console.log('this.currentPage = 0;  ' + this.currentPage )
;            console.log('this.paginationData.length ' + this.paginationData.length);
            this.pageSize = this.paginationData.length;
            
        } else if (result.error) {
            console.log('result.error ' + result.error)
            this.error = result.error;
            this.record = undefined;
        }
    }
    handleFilesChange(event) {
        if (event.target.files.length > 0) {
            this.modalAskUpload = true;
            this.filesUploaded = event.target.files;
            this.fileName = event.target.files[0].name;
        }
    }
    handleSave(event) {
        const recordInputs =  event.detail.draftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
    
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(assets => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Assets has been updated',
                    variant: 'success'
                })
            );
             // Clear all draft values
             this.draftValues = [];
             //eval("$A.get('e.force:refreshView').fire();");
             // Display fresh data in the datatable
             return refreshApex(this._wiredResult);
        }).catch(error => {
            // Handle error
        });
    }
    handleSaveDocument() {
        if (this.filesUploaded.length > 0) {
            this.modalAskUpload = false;
            this.uploadHelper();            
        } else {
            this.fileName = 'Please select file to upload!!';
        }
        return refreshApex(this._wiredResult);
    }

    async deleteRecords(asset) {
        deleteAsset({assetList : asset, idTakedown : this.recordid}).then(result => {
            this.showErrorToast('Success','Some assets were successfully removed', 'success');
        }).catch(error => {
            this.showErrorToast('Error', error.body.message, 'error');
        });
    }
    
    async uploadHelper() {
        let idAccount = this.record.fields.CPL_rb_Opp__r.value.fields.AccountId.value;
        this.file = this.filesUploaded[0];
        console.log('this.file ' + this.file);
        if (this.file.size > this.MAX_FILE_SIZE) {
            window.console.log('File Size is to long');
            return;
        }
        this.showLoadingSpinner = true;
        let catalogCollateral = await getCatalogCollateral()
        console.log('catalogCollateral ' + JSON.stringify(catalogCollateral))
        let invoiceTakedown = await getTakedownInvoice({ idTakedown: this.recordid });
        //alert(JSON.stringify(invoiceTakedown));

        // create a FileReader object 
        this.fileReader = new FileReader();
        // set onload function of FileReader object  
        this.fileReader.onloadend = (() => {
            this.fileContents = this.fileReader.result;
            let workbook = XLSX.read(this.fileContents, {
                type: 'binary'
            });
            let firstSheet = workbook.SheetNames[0];
            let jsonUploaded = XLSX.utils.sheet_to_json(workbook.Sheets[firstSheet])
            console.log('-----')
            console.log('1 ' + JSON.stringify(jsonUploaded))
            jsonUploaded = prepareCollateralToUpload(jsonUploaded,catalogCollateral,invoiceTakedown)
            console.log('2 ' + JSON.stringify(jsonUploaded))
            let final = prepareHeadersToUpload(jsonUploaded);
            console.log('+++++++')
            console.log('final ' + JSON.stringify(final))
            console.log('Id de la cuenta de los activos: ' + idAccount)
            this.deleteRecords(final);
             saveData({activos:final, idAccount: idAccount, idTakedown: this.recordid})
            .then(result => {
                this.showLoadingSpinner = false;
                // Showing Success message after file insert
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: this.file.name + ' - Uploaded Successfully!!!',
                        variant: 'success',
                    }),
                );
                location.reload(true); 
                return refreshApex(this._wiredResult);

            })
            .catch(error => {
                this.showLoadingSpinner = false;
                console.log(error)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error while uploading File',
                        message: error.message,
                        variant: 'error',
                    }),
                );
            })
        });
        this.fileReader.readAsBinaryString(this.file);
        
    }
    async downloadWorkBook(){ 
        this.section = blank;
        
        let data = await initRecords({ recordId: this.recordid })
        console.log('data ' + JSON.stringify(data))
        await this.makeXLSX(data);
        this.section = mainpage;
    }

    /* New send EVAL method */
    async updateEntidad(idEntity) {
        updateEntity ({ enitytCPId : idEntity }).then(response => {
            this.showErrorToast('Success','Entity updated successfully', 'success');
            this.createEval();
        }).catch(error => {
            console.error(error);
            this.showErrorToast('Error', error.body.message, 'error');
            this.isLoading = false;
        })
    }

    async createEval() {
        let data = await initRecords({ recordId: this.recordid });
        console.log(JSON.stringify(data));
        sendEvalApprove({json : JSON.stringify(data), IdTakeDown : this.recordid}).then (response=> {
            var map = response;
            var error;
            var message;
            if(map['status'] == '500') {
                this.showErrorToast('Error',map['message'], 'error');
                this.isLoading = false;
            }
            else {
                for (let i in map) {
                    message = map[i]['message'];
                    error =  map[i]['code'];                  
                }
                if(message == 'Fail'){
                    this.showErrorToast('Warning',error, 'warning');
                    this.isLoading = false;
                }
                else {
                    this.showErrorToast('Success','EVAL created successfully', 'success');
                    this.isLoading = false;
                }
            }
            console.log(response);
        }).catch(error=>{
            console.error(error);
            this.showErrorToast('Error', error.body.message, 'error');
            this.isLoading = false;
        })
    }

    async sendEval() {
        this.isLoading = true;
        takedownInfo({ idTakeDown :this.recordid }).then(response => {
            console.log(response);
            if(response.CPL_rb_Entity_Name_CP__r.EM_Top_Parent_ID__c == null || response.CPL_rb_Entity_Name_CP__r.EM_Party_ID__c == null){
                this.updateEntidad(response.CPL_rb_Entity_Name_CP__c);
            }
            else {
                this.createEval();
            }
        }).catch(error => {
            console.error(error);
            this.showErrorToast('Error', error.body.message, 'error');
            this.isLoading = false;
        })
    }

    /* Created message error */
    showErrorToast(title ,message , error) {
        const evt = new ShowToastEvent({
            'title': title,
            'message': message,
            'variant': error,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    makeXLSX(data){        
        //Creas un workbook
        
        console.log('JSON.stringify(data) ' + JSON.stringify(data))
        let datad = prepareHeadersToDownload(data)
        console.log('makeXLSX data ' + JSON.stringify(datad));
        let wb = XLSX.utils.book_new();
        wb.props = {
            Title: "AssetBreakdowwn ",
            subject: "AssetBreakdowwn",
            Author: "EngeniumCapital"
        };
        let sheetData = XLSX.utils.json_to_sheet(datad);
        sheetData = setComments(sheetData);
        /*if(!sheetData['A1'].c) 
        sheetData['A1'].c = [];
        sheetData['A1'].c.hidden = true;
        sheetData['A1'].c.push({a:"SheetJS", t:"hola"});

        if(!sheetData['B1'].c)
        sheetData['B1'].c = [];
        sheetData['B1'].c.hidden = true;
        sheetData['B1'].c.push({a:"SheetJS", t:"bien y tu"});
        */
        console.log('log')
        console.log(JSON.stringify(sheetData))
        
        //XLSX.utils.sheet_add_json(sheetData, constantes.fieldTypes, {skipHeader: true, origin: "A2"});
        XLSX.utils.book_append_sheet(wb, sheetData, 'AssetBreakdown');
        let wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
        saveAs(new Blob([workDownload(wbout)], {type:'text/plain'}), 'AssetBreakdown.xlsx');
    }

    closeModal() {
        this.modalAskUpload = false;
    }
    closeModalAB() {
        this.dispatchEvent(new CustomEvent('closemodal'));
    } 
    get showFirstButton() {
            if (this.currentPage === 1 || this.currentPage === 0) {
                return true;
            }
            return false;
        } 
    get showLastButton() {
            if (this.currentPage === this.pageSize) {
                return true;
            }
            return false;
        } 
    pagePrevious() {       
        this.currentPage = this.currentPage - 1;
        this.currentData = this.paginationData[this.currentPage - 1];
    }
    pageNext() {
        this.currentPage = this.currentPage + 1;
        this.currentData = this.paginationData[this.currentPage - 1];
    }
    pageFirst() {
        this.currentPage = 1;
        this.currentData = this.paginationData[this.currentPage - 1] ;

    }
    pageLast() {
        this.currentPage = this.pageSize;
        this.currentData = this.paginationData[this.currentPage - 1];
    }
}