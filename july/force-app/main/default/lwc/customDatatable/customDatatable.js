/**
 * @File Name          : customDatatable.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 19/5/2020 16:25:39
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    1/3/2020   eduardo.amiens@outlook.com     Initial Version
**/
import LightningDatatable from 'lightning/datatable';
import templateLookup from './customlookup.html';
import templateMultipickList from './customMultipickList.html';
import customPickListLMM from './customPickListLMM.html';
import customIcon from './customIcon.html';
import customCreditBureau from './customCreditBureau.html';

//Nuevo para invoice
import templateLookupinvoice from './customlookupinvoice.html';

export default class CustomDatatable extends LightningDatatable {
    

    static customTypes = {
        customlookup: {
            template: templateLookup,
            standardCellLayout: true,
            typeAttributes: ['customSearch','lookUpLabel','lookUpPlaceholder','initialFieldToShow']
        },
        //Nuevo para editar los invoice
        customlookupinvoice: {
            template: templateLookupinvoice,
            standardCellLayout: true,
            typeAttributes: ['customSearch','lookUpLabel','lookUpPlaceholder','initialFieldToShow']
        },
        customIcon :{
            template : customIcon,
            standardCellLayout: true,
            typeAttributes: ['iconName','alternativeText','title', 'size']           
        },
        custommultipicklist: {
            template: templateMultipickList,
            standardCellLayout: true,
            typeAttributes: ['options','titleModal','headLabel','helpLabel','sizeModal','acceptButtonName','cancelButtonName']           
        },
        custompicklistlmm: {
            template: customPickListLMM,
            standardCellLayout: true,
            typeAttributes: ['options','titleModal','headLabel','helpLabel','sizeModal','acceptButtonName','cancelButtonName']                    
        },
        customCreditBureau: {
            template: customCreditBureau,
            standardCellLayout: true,
            typeAttributes: ['opportunityId']                    
        }

    };
}