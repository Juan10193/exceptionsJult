/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-28-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-02-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, track } from 'lwc';

export default class TkdManageSupplier extends LightningElement {

    @api takedownId
    @api supplierId
    @api siteId
    @api bankAccountId
    @api contactId

    @api supplierWithoutModal = false
    @api isOnlySiteRecord = false

    @api openModalSupplierDetail = false
    @api openModalSiteDetail = false
    @api openModalBankAccount = false
    @api openModalContact = false

    @api disabledAcceptButton

    /*Handle Open Modals*/
    @track showSpinner
    loadProgress = {
        getTKD_Vat_code : false,
        getSR_ls_Custom_Currency : false,
        getTKD_ls_State : false,
        getTKD_tx_Country : false,
        asignData : false,
        getTakedownRecord : false
    }
    

    @api
    handleOpenSupplierModal() {
        this.loadProgress = {
            getSupplierInApprovalId: false,
            wiregetSupplierWithSites: false
        }
        this.showSpinner = true
        this.openModalSupplierDetail = true
        this.openModalSiteDetail = false
        this.openModalBankAccount = false
        this.openModalContact = false
    }

    @api
    async handleOpenSiteModal(event) {
        this.loadProgress = {
            getTKD_Vat_code : false,
            getSR_ls_Custom_Currency : false,
            getTKD_ls_State : false,
            getTKD_tx_Country : false,
            asignData : false,
            getTakedownRecord : false
        }
        this.showSpinner = true
        console.info('handleOpenSiteModal')
        console.log('event ' + JSON.stringify(event))
        console.log('this.supplierId ' + this.supplierId)
        if (event !== null && event !== undefined)
            this.siteId = await event.detail
        this.openModalSupplierDetail = false
        this.openModalSiteDetail = true
        this.openModalBankAccount = false
        this.openModalContact = false
    }

    @api
    async handleOpenBankAccountModal(event) {
        
        this.loadProgress = {
            getBank_Account_Currency : false,
            getTipo_BIC : false,
            getTipo : false,
            getSR_ls_Specific_intermediary_bank : false,
            asignData : false
        }
        console.log('handleOpenBankAccountModal this.loadProgress ' + JSON.stringify(this.loadProgress))
        this.showSpinner = true
        console.info('handleOpenBankAccountModal')
        console.log('event ' + JSON.stringify(event))
        this.bankAccountId = await event.detail
        this.openModalSupplierDetail = await false
        this.openModalSiteDetail = await false
        this.openModalBankAccount = await true
        this.openModalContact = await false
    }

    @api
    async handleOpenContactModal(event) {
        console.info('handleOpenContactModal')
        this.contactId = await event.detail
        this.openModalSupplierDetail = await false
        this.openModalSiteDetail = await false
        this.openModalBankAccount = await false
        this.openModalContact = await true
    }

    /*Handle Close Modals*/

    handleCloseSupplierModal() {
        this.openModalSupplierDetail = false
        this.openModalSiteDetail = false
    }

    async handleCloseSiteModal() {
        await console.info('handleCloseSiteModal')
        this.openModalSupplierDetail = await true
        this.openModalSiteDetail = await false
        this.openModalBankAccount = await false
        this.openModalContact = await false
        if (this.isOnlySiteRecord === false)
            await this.template.querySelector('c-tkd-supplier-detail').handleRefreshRecord();
    }

    async handleCloseContactModal() {
        console.info('handleCloseContactModal')
        this.openModalSiteDetail = await true
        this.openModalBankAccount = await false
        this.openModalContact = await false
        await this.template.querySelector('c-tkd-site-detail').handleRefreshRecord();
    }

    async handleCloseBankAccountModal(event) {
        console.info('handleCloseBankAccountModal')
        this.openModalSiteDetail = await true
        this.openModalBankAccount = await false
        this.openModalContact = await false
        await this.template.querySelector('c-tkd-site-detail').handleRefreshRecord();
    }

    /* Handle Save */
    handleSaveSupplier() {
        console.info('handleSaveSupplierSite')
        this.template.querySelector('c-tkd-supplier-detail').handleSave();
    }
    handleSaveSite() {
        console.info('handleSaveSite')
        this.template.querySelector('c-tkd-site-detail').handleSave();
    }
    handleSaveBankAccount() {
        console.info('handleSaveBankAccount')
        this.template.querySelector('c-tkd-bank-account-detail').handleSave();
    }
    handleSaveContact() {
        console.info('handleSaveContact')
        this.template.querySelector('c-tkd-contact-detail').handleSave();
    }


    /* Result Save Method */
    handleGetSaveResultSupplier(event) {
        console.info('handleGetSaveResultSupplier')
        console.log('event ' + JSON.stringify(event))
        this.supplierId = event.detail
        console.log('this.supplierId = event.detail ' + JSON.stringify(this.supplierId))
    }
    handleGetSaveResultSite(event) {
        console.info('handleGetSaveResultSite')
        console.log('event ' + JSON.stringify(event))
        this.siteId = event.detail
    }
    handleGetSaveResultNewBankAccount(event) {
        console.info('handleGetSaveResultNewBankAccount')
        console.log('event ' + JSON.stringify(event))
        this.bankAccountId = event.detail
    }
    handleGetSaveResultNewContact(event) {
        console.info('handleGetSaveResultNewContact')
        console.log('event ' + JSON.stringify(event))
        this.contactId = event.detail
    }
    async disablesave(event) {
        console.info('disablesave')
        console.log('event.detail ' + event.detail)
        this.disabledAcceptButton = await event.detail
    }

    handleLoadSupplier(event) {
        console.log('load event ' + JSON.stringify(event))
        if(event.detail){
            if(event.detail.getSupplierInApprovalId){
                this.loadProgress.getSupplierInApprovalId = event.detail.getSupplierInApprovalId
            } else if(event.detail.wiregetSupplierWithSites){
                this.loadProgress.wiregetSupplierWithSites = event.detail.wiregetSupplierWithSites
            }
            if(this.loadProgress.getSupplierInApprovalId === true 
                && this.loadProgress.wiregetSupplierWithSites === true){
                    this.showSpinner = false
                    console.log('spinner apagado Supplier')
                }
        }
    }
    handleLoadSite(event) {
        console.log('load event ' + JSON.stringify(event))
        if(event.detail){
            if(event.detail.getTKD_Vat_code){
                this.loadProgress.getTKD_Vat_code = event.detail.getTKD_Vat_code
            } else if(event.detail.getSR_ls_Custom_Currency){
                this.loadProgress.getSR_ls_Custom_Currency = event.detail.getSR_ls_Custom_Currency
            } else if(event.detail.getTKD_ls_State){
                this.loadProgress.getTKD_ls_State = event.detail.getTKD_ls_State
            } else if(event.detail.getTKD_tx_Country){
                this.loadProgress.getTKD_tx_Country = event.detail.getTKD_tx_Country
            } else if(event.detail.asignData){
                this.loadProgress.asignData = event.detail.asignData
            } else if(event.detail.getTakedownRecord){
                this.loadProgress.getTakedownRecord = event.detail.getTakedownRecord
            }
            if(this.loadProgress.getTKD_Vat_code === true 
                && this.loadProgress.getSR_ls_Custom_Currency === true
                && this.loadProgress.getTKD_ls_State === true
                && this.loadProgress.getTKD_tx_Country === true
                && this.loadProgress.asignData === true
                && this.loadProgress.getTakedownRecord === true){
                    this.showSpinner = false
                    console.log('spinner apagado Site')
                }
        }
    }
    handleLoadBankAccount(event) {
        console.log('load event ' + JSON.stringify(event))
        if(event.detail){
            if(event.detail.getBank_Account_Currency){
                this.loadProgress.getBank_Account_Currency = event.detail.getBank_Account_Currency
            } else if(event.detail.getTipo_BIC){
                this.loadProgress.getTipo_BIC = event.detail.getTipo_BIC
            } else if(event.detail.getTipo){
                this.loadProgress.getTipo = event.detail.getTipo
            } else if(event.detail.getSR_ls_Specific_intermediary_bank){
                this.loadProgress.getSR_ls_Specific_intermediary_bank = event.detail.getSR_ls_Specific_intermediary_bank
            } else if(event.detail.asignData){
                this.loadProgress.asignData = event.detail.asignData
            }
            console.log('this.loadProgress ' + JSON.stringify(this.loadProgress))
            if(this.loadProgress.getBank_Account_Currency === true
                && this.loadProgress.getTipo_BIC === true
                && this.loadProgress.getTipo === true
                && this.loadProgress.getSR_ls_Specific_intermediary_bank === true
                && this.loadProgress.asignData === true){
                    this.showSpinner = false
                    console.log('spinner apagado BankAccount')
                }
        }
    }
}