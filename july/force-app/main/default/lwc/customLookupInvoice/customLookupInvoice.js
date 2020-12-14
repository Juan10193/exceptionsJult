/**
 * @File Name          : customLookUp.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 1/3/2020 23:35:42
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/3/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, track, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchCollaterals from '@salesforce/apex/CustomDatatableController.searchCollaterals';
import { updateRecord } from 'lightning/uiRecordApi';
//import TKD_rb_collateral from '@salesforce/schema/Asset.TKD_rb_collateral__c';
import TKD_rb_takedown_Invoice from '@salesforce/schema/Asset.TKD_rb_takedown_Invoice__c';
import { getRecord } from 'lightning/uiRecordApi'
import ID_FIELD from '@salesforce/schema/Asset.Id';
import { refreshApex } from '@salesforce/apex';

export default class CustomLookupInvoice extends LightningElement {
      //row record id
      @api recordId
      //parentobject id
      @api parentId
      @api initialFieldToShow
      @api customSearch
      @api lookUpLabel
      @api lookUpPlaceholder
      @track initialSelection = [];
      @track errors = [];
      @track isMultiEntry = false;
      /*@track collateralID
      @track collateralDescription
      @track collateralType*/
      @track invoiceID;
      @track invoiceTakedown;
  
      assetRecord
  
      
      @wire(getRecord, { recordId: '$recordId', fields: ['asset.TKD_rb_takedown_Invoice__c','asset.TKD_rb_takedown_Invoice__r.Name'] })
      async wireRecord({ error, data }) {
          if(data){
              this.assetRecord = data;
              if(data.fields.TKD_rb_takedown_Invoice__r.value !== null & data.fields.TKD_rb_takedown_Invoice__r.value !== '' & data.fields.TKD_rb_takedown_Invoice__r.value !== undefined) {
                  this.invoiceTakedown = data.fields.TKD_rb_takedown_Invoice__r.value.fields.Name.value ;
                  this.initialSelection =[
                      { id: this.recordId, sObjectType: '', icon: 'custom:custom44', title: data.fields.TKD_rb_takedown_Invoice__r.value.fields.Name.value, subtitle: data.fields.TKD_rb_takedown_Invoice__r.value.fields.Name.value }
                      ]
                  //this.collateralID = data.fields.TKD_rb_collateral__r.value.id
              } else {
                  this.invoiceTakedown = ''  
              }
          }
      }
  
      handleSearch(event) {
          
          console.log('this.recordId dd ' + this.recordId)
          console.log('event.detail ' + JSON.stringify(event.detail))
          console.log('this.customSearch ' + JSON.stringify(this.customSearch))
          switch (this.customSearch) {
              case 'collateral':
                      this.optCollateral(event)
                  break;
              default:
              console.log('put an option')
          }
      }
      handleSelectionChange() {
          this.errors = [];
      }
      async handleSubmit(){
          this.checkForErrors();
          if (this.errors.length === 0) {
              console.log('this.recordId ' + this.recordId)
              console.log('this.collateralID ' + this.collateralID)
  
              const fields = {};        
              fields[ID_FIELD.fieldApiName] = this.recordId
              fields[TKD_rb_collateral.fieldApiName] = this.collateralID
              const recordInput = { fields };
              try{
                  await updateRecord(recordInput)
                  this.dispatchEvent(
                      new ShowToastEvent({
                          title: 'Success!!',
                          message: 'The collateral has been changed',
                          variant: 'success',
                      })
                  );
                  return refreshApex(this.assetRecord);
              } catch(error) {
                  this.dispatchEvent(
                      new ShowToastEvent({
                          title: 'Error!!',
                          message: 'An error has been ocurred during update record ',
                          variant: 'error',
                      })
                  );
              }
          }
      }
      optCollateral(event){
          searchCollaterals(event.detail)
              .then(results => {
                  this.template.querySelector('c-lookup').setSearchResults(results);
              })
              .catch(error => {
                  this.notifyUser('Lookup Error', 'An error occured while searching with the lookup field.', 'error');
                  // eslint-disable-next-line no-console
                  console.error('Lookup error', JSON.stringify(error));
                  this.errors = [error];
              });
      }
      checkForErrors() {
          const selection = this.template.querySelector('c-lookup').getSelection();
          console.log(' selection ' + JSON.stringify(selection));
          console.log(' this.initialSelection ' + JSON.stringify(this.initialSelection));
  
  
          if (selection.length === 0 & this.initialSelection.length > 0) {
              this.collateralID = null;
              this.errors = [];
              this.initialSelection = [];
              console.log('here');
          } else if (selection.length === 0 & this.initialSelection.length === 0) {
              this.errors = [
                  { message: 'You must make a selection before submitting!' },
                  { message: 'Please make a selection and try again.' }
              ];
          } else {
              this.collateralID = selection[0].id;
              this.errors = [];
          }
      }
}