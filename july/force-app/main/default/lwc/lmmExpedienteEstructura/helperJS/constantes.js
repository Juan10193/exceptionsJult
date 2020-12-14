const columnsSelectedEntities = [
    { label: 'Entidad', fieldName: 'LMM_tx_Entity_Name__c', initialWidth: 300, clipText: true },
    {
        label: 'Rol', fieldName: 'Id', type: 'custommultipicklist', initialWidth: 250, clipText: true,
        typeAttributes: {
            titleModal: 'Asign Rol', headLabel: 'Select Roles', helpLabel: 'Select Roles',
            sizeModal: 'slds-modal slds-fade-in-open animated fadeInRight slds-modal_small', acceptButtonName: 'Save',
            cancelButtonName: 'Cancel'
        }
    },
    {
        label: 'Hits', fieldName: 'LMM_ls_Hits__c', type: 'customIcon', clipText: true,
        typeAttributes: {
            alternativeText: {fieldName: 'LMM_tl_Hits_Description__c'}, title: {fieldName: 'LMM_tl_Hits_Description__c'},
            size: 'xx-small'
        }
    },
    {
        label: 'Bil', fieldName: 'Id', type: 'custompicklistlmm',clipText: true,
        typeAttributes: {
            titleModal: 'Asign LegalAssessment (BIL)', 
            sizeModal: 'slds-modal slds-fade-in-open animated fadeInRight slds-modal_small', acceptButtonName: 'Save',
            cancelButtonName: 'Cancel'
        }
    },
    {
        label: 'Credit Bureau', type: 'customCreditBureau', fieldName: 'LMM_pd_Entity_CP__c', clipText: true,
        typeAttributes: {
            opportunityId: { fieldName: 'LMM_pd_Oportunidad__c' }
        }
        
    },
    {
        type: 'action',
        typeAttributes: { rowActions: [
            { label: 'Show Entity CP', name: 'show_entity_cp' },
            { label: 'Show Entity Detail', name: 'show_entity_detail' },
            { label: 'Delete', name: 'delete' },
        ]},
    }
]
const columnsSelectEntity = [
    { label: 'ORACLE ACCOUNT NAME', fieldName: 'oracleAccountName' },
    { label: 'ORACLE ACCOUNT NUMBER', fieldName: 'oracleAccountNumber' },
    { label: 'RFC', fieldName: 'rfc' },
    { label: 'TOP PARENT NAME', fieldName: 'topParentName' },
    { label: 'CUSTOMER TYPE', fieldName: 'customerType' }
]

const FIELDS = ['Opportunity.AccountId', 'Opportunity.Account.Name', 'Opportunity.Account.ACC_rb_Top_Parent_Account__c',
    'Opportunity.Account.ACC_rb_Top_Parent_Account__r.Name', 'Opportunity.Id']

export default { columnsSelectedEntities, columnsSelectEntity, FIELDS };