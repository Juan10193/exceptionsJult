/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-01-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-13-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement,api} from 'lwc';

export default class TkdModalSiteDetail extends LightningElement {
    @api takedownId
    @api supplierId
    @api siteId
    @api bankAccountId
    @api contactId
    @api openModalSiteDetail = false
    @api openModalBankAccount = false 
    @api openModalContact = false 

    @api disabledAcceptButton

    /*Handle Open Modals*/

    @api
    handleOpenSiteModal(){
        console.info('handleOpenSiteModal')
        this.openModalSiteDetail = true     
        this.openModalBankAccount = false  
        this.openModalContact = false 
    }

    @api
    async handleOpenBankAccountModal(event){
        console.info('handleOpenBankAccountModal')
        console.log('event ' + JSON.stringify(event))
        this.bankAccountId = await event.detail 
        this.openModalSiteDetail = await false
        this.openModalBankAccount = await true
        this.openModalContact = await false   
    }

    @api
    async handleOpenContactModal(event){
        console.info('handleOpenContactModal')
        this.contactId = await event.detail 
        this.openModalSiteDetail = await false
        this.openModalBankAccount = await false
        this.openModalContact = await true
    }

    /*Handle Close Modals*/

    handleCloseSiteModal(){
        console.info('handleCloseSiteModal')
        this.openModalSiteDetail = false
        this.openModalBankAccount = false
        this.openModalContact = false
    }

    async handleCloseContactModal(){
        console.info('handleCloseContactModal')
        this.openModalSiteDetail = await true
        this.openModalBankAccount = await false
        this.openModalContact = await false
        await this.template.querySelector('c-tkd-site-detail').handleRefreshRecord();
    }

    async handleCloseBankAccountModal(event){
        console.info('handleCloseBankAccountModal')
        this.openModalSiteDetail = await true
        this.openModalBankAccount = await false
        this.openModalContact = await false
        await this.template.querySelector('c-tkd-site-detail').handleRefreshRecord();
    }

    /* Handle Save */
    handleSaveSite(){
        console.info('handleSaveSite')
        this.template.querySelector('c-tkd-site-detail').handleSave();                
    }
    handleSaveBankAccount(){
        console.info('handleSaveBankAccount')
        this.template.querySelector('c-tkd-bank-account-detail').handleSave();                
    }
    handleSaveContact(){
        console.info('handleSaveContact')
        this.template.querySelector('c-tkd-contact-detail').handleSave();                
    }
    
    
    /* Result Save Method */
    handleGetSaveResultSite(event){
        console.info('handleGetSaveResultSite')
        console.log('event ' + JSON.stringify(event))
        this.siteId = event.deail
    }
    handleGetSaveResultNewBankAccount(event){
        console.info('handleGetSaveResultNewBankAccount')
        console.log('event ' + JSON.stringify(event))
        this.bankAccountId = event.deail
    }
    handleGetSaveResultNewContact(event){
        console.info('handleGetSaveResultNewContact')
        console.log('event ' + JSON.stringify(event))
        this.contactId = event.deail
    }
    async disablesave(event){
        console.info('disablesave')
        console.log('event.detail ' + event.detail)
        this.disabledAcceptButton = await event.detail 
    }
}