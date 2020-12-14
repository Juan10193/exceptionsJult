import createReporte from '@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.createReporte';

async function crearReporte (reporteFields, avales, pf, pc, ppv, pac, reporteId, oppId){
    let reporte =reporteFields;
    let avals = avales;
    let pfs = pf;
    let pcs =pc;
    let ppvs = ppv;
    let pacs= pac;
    reporte.sobjectType='Reporte_de_visita_PYME__c'
    avals.sobjectType='LMM_Entidad_de_oportunidad__c';
    pfs.sobjectType ='Contact';
    pcs.sobjectType ='Contact';
    ppvs.sobjectType ='Contact';
    pacs.sobjectType ='Contact';
    try{
        await createReporte({reporte:reporte, avales:avals, pf:pfs, pc:pcs,ppv:ppvs, pac:pacs, reporteId:reporteId, oppId:oppId});
    }catch(error){
        console.log('Error al crearReporte de visita');
        console.log(error);
    }
    
}

export {crearReporte}