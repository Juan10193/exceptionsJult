/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-01-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-11-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement,api, track } from 'lwc';

export default class TkdModalSupplierDetail extends LightningElement {
    @api takedownId
    @api supplierId
    @api siteId
    @api isUsingModal = false
    @api openModalSupplierDetail = false
    @api openModalSiteDetail = false 

    @api
    handleOpenSupplierModal(){
        this.openModalSupplierDetail = true
        this.openModalSiteDetail = false
    }
    handleCloseSupplierModal(){
        this.openModalSupplierDetail = false
        this.openModalSiteDetail = false
    }
    
    @api
    async handleOpenSiteModal(event){
        console.info('handleOpenSiteModal')
        console.log('event ' + JSON.stringify(event))
        this.siteId = await event.detail
        this.openModalSupplierDetail = false
        this.openModalSiteDetail = true        
    }
    handleCloseSiteModal(){
        this.openModalSupplierDetail = true
        this.openModalSiteDetail = false
    }
    handleSaveSite(){
        console.info('handleSaveSite')
        this.template.querySelector('c-tkd-site-detail').handleSave();                
    }
    
}