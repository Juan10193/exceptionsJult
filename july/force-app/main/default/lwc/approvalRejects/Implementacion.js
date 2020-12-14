/*CREAR UN LOKUP DESDE EL OBJECTO Approval_Process_Reject__c HACIA EL OBJETO AL QUE QUEREMOS REGISTRAR ERRORES
POPULAR CATALOGOS Error_Type__c Y Subtype_Error__c CON LOS NUEVOS TIPOS Y SUB TIPOS DE ERROR AL CUSTOM OBJECT Approval_Process_Reject__c 


CREAR UN CUSTOM METADATA
Name =    "ObjectApiName al cual se relaciona  borrar el __c  y agregar el prefijo _Appr"   (Takedowns_Contingency_plan_Appr)

CREAR CAMPOS EN EL CUSTOM METADATA DE TIPO PICK LIST CON LOS SIGUIENTES APINAMES
Error_Type__c   (AQUI VA EL TIPO DE ERROR EN SUS VALORES)
Subtype_Error__c (AQUI VA EL SUB TIPO DE ERROR EN SUS VALORES)

POPULAR CUSTOM METADATA CON LOS VALORES Error_Type__c Y Subtype_Error_c
(subtypo de error y al tipo de error que pertenece)


@api recordId; PASAR EL RECORD ID DEL REGISTRO SI ESTA DENTRO DE OTRO COMPONENT

@api objectApiName PARAS EL objectApiName  SI ESTA DENTRO DE OTRO COMPONENT;


Esperar la magia

REJECTS ESTRUCTURA
{
    Error_Type__c: "Documentos Faltantes"
    Subtype_Error__c: "Condiciones Comerciales del Arrendamiento Anexo C (Fleet)"
    Id: "m0M8A0000008R3BUAU"
}
*/