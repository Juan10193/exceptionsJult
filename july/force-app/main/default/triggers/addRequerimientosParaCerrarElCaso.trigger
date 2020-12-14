trigger addRequerimientosParaCerrarElCaso on Case (before insert, before update) {
    
    
    for(Case e : Trigger.new)
    {
        //Agregar la URL de la encuesta
        /*if (e.CaseNumber != null)
        {
            String numCase = String.valueOf(Decimal.valueOf(e.CaseNumber));
            System.debug('Numero de Caso = '+ numCase);
            List<Encuesta_Satisfaccion_Cliente__c> encuesta = new List<Encuesta_Satisfaccion_Cliente__c>();
            encuesta = [Select e.Name, e.Id, e.ENC003_ur_URLEncuesta__c, e.ENC002_tx_numeroDeCaso__c 
                        From Encuesta_Satisfaccion_Cliente__c e
                        Where e.ENC002_tx_numeroDeCaso__c =: numCase];
            if(encuesta.size()>0)
            {
                System.debug('encuesta.size()>0 = '+ encuesta.size());
                encuesta[0].ENC001_id_Caso__c = e.id;
                update encuesta;
                e.CAS050_ur_URLEncuesta__c = encuesta[0].ENC003_ur_URLEncuesta__c;
                
            }
            
        }*/        
        //Agregar las instrucciones para cerrar el caso
        if(e.CAS001_ls_requerimiento__c != null && String.isNotBlank(e.CAS001_ls_requerimiento__c) )
        {            
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Factura Manual')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Especificar la fecha del vencimiento a facturar.' + '\n' +
                    '* Montos' + '\n' +
                    '* Conceptos' + '\n' +
                    '* Moneda';
                break;
            }
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Nota de Crédito')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Especificar el folio de la factura a cancelar/condonar.' + '\n' +
                    '* Justificación de la cancelación del folio.' + '\n' +
                    '* Montos' + '\n' +
                    '* Conceptos' + '\n' +
                    '* Moneda';
                break;
            }             
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Emisión de Recibo')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Ajuntar al ticket los recibos de pago realizados por el cliente' + '\n' +
                    '* Si no se ha pagado, adjuntar correo con solicitud del cliente donde solicite el recibo para realizar el pago.' + '\n' +
                    '* Montos' + '\n' +
                    '* Conceptos' + '\n' +
                    '* Moneda';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Condonación de moratorios')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato' + '\n' +
                    '* Especificar el folio de la factura a cancelar. ' + '\n' +
                    '* Justificación de la cancelación del folio.' + '\n' +
                    '* Montos' + '\n' +
                    '* Conceptos' + '\n' +
                    '* Moneda';
                break;
            }            
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Cambio de contacto de envío de factura')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Proporcionar  correo (s) que causa (n) ALTA  o BAJA para el envío de facturas. ';
                break;
            }                    
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Confirmación de Saldos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = 'Número de contrato (Account Schedule)' + '\n' +
                    '* Adjuntar carta solicitud por parte del cliente la cual debe especificar el periodo del cual solicita la información.' + '\n' +
                    '* Proporcionar el correo electronico de los auditores a los que se debe enviar la información.' + '\n' +
                    '* Para solicitudes internas no es necesaria la carta por parte del cliente.';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Cambio de Datos Fiscales')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = 'Número de contrato (Account Schedule)' + '\n' +
                    '* Adjuntar RFC del cliente' + '\n' +
                    '* Adjuntar "Bridger.';
                break;
            }              
            if(e.CAS001_ls_requerimiento__c == 'Cambio en agrupación de Facturas')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Números de cliente' + '\n' +
                    '* Adjuntar solicitud del cliente';
                break;
            }  
            
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Certificaciones Contables')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Adjuntar contrato o anexos escaneados' + '\n' +
                    '* Fecha a la cual se requiere el Estado de Cuenta';
                break;
            }            
            
            if(e.CAS001_ls_requerimiento__c == 'Disposición de Cuentas EOL')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Adjuntar cotización que incluya número de ASSETS a terminar, monto a aplicar.' + '\n' +
                    '* Indicar tipo de terminación, si es compra de cliente, si es por siniestro o si es por Remarketing.' + '\n' +                     
                    '* Adjuntar número de vouchers a aplicar.';
                break;
            }  
            
            if(e.CAS001_ls_requerimiento__c == 'Abrir Open Item')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Números de FEE CODES  a dar de alta' + '\n' +
                    '* Montos a dar de alta' + '\n' +                     
                    '* Justificación por la cual se requiere el alta del FEE CODE.';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Modificar Open Item')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Razón Social' + '\n' +
                    '* Números de FEE CODES  a modificar' + '\n' +                     
                    '* Montos a modificar' + '\n' + 
                    '* Número de caso con el que fue solicitado la refacturación  o cancelación de los FEES a modificar.' + '\n' + 
                    '* Justificación por la cual se requiere el alta del FEE CODE.';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Eliminar Open Item')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Números de FEE CODES a eliminar' + '\n' +
                    '* Montos a eliminar' + '\n' +  
                    '* Adjuntar autorización ' + '\n' + 
                    '* Justificación por la cual se requiere eliminar el FEE CODE.';
                break;
            }                  
            if(e.CAS001_ls_requerimiento__c == 'Streams Seguro')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Montos a modificar' + '\n' +
                    '* Periodos a modificar';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Aplicación de opción de compra')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Número de FEE CODES a aplicar' + '\n' +
                    '* Adjuntar cotización' + '\n' +  
                    '* Número de voucher' + '\n' + 
                    '* Monto a aplicar';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Estados de cuenta')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Comentar en solicitud el periodo del Estado de cuenta que se requiere.' + '\n' +
                    '* Proporcionar el correo electronico al que debe se debe enviar la información.' + '\n' +                     
                    '* Adjuntar solicitud por parte del cliente.';
                break;
            }        
            if(e.CAS001_ls_requerimiento__c == 'Confirmación de Security Deposit')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Limpieza de voucher')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Número de voucher' + '\n' +
                    '* Adjuntar evidencia de pago' + '\n' +                     
                    '* Monto a dar de baja';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Negative Adjustments')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Número de FEE CODES a aplicar' + '\n' +
                    '* Adjuntar cotización' + '\n' +      
                    '* Número de voucher' + '\n' +
                    '* Montos a aplicar' + '\n' +  
                    '* Montos de nuevas rentas (capital e interes e IVA)' + '\n' +
                    '* Indicar justificación (prepago o siniestro)';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de gestoría')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = 'Los requisitos para cada caso se  mencionan en el archivo "CATALOGO DE  TRAMITES CLIENTE". Sera necesario consultas los requisitos, precios y tiempos por trámite.';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Conciliación de Cuentas')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule), en caso de ser una conciliación de varios contratos será necesario especificarlos.' + '\n' +
                    '* Adjuntra historial de pagos proporcionado por el cliente desde el principio del arrendamiento detallando la integración de los mismos';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Reaplicación de Pagos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Explicar detalladamente la corrección' + '\n' +
                    '* Adjuntar soporte/correo de solicitud por parte del cliente ';
                break;
            }      
            if(e.CAS001_ls_requerimiento__c == 'Devoluciones a Cliente')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Carta solicitud  y/o correo electrónicopor parte del cliente en hoja membretada con la solicitud de devolución' + '\n' +
                    '* Adjuntar cédula fiscal con domicilio.' + '\n' +                     
                    '* Adjuntra copia de Estado de  Cuenta no mayor a 3 meses.';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Historial de Pagos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Moneda';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de documentos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    '* Número de contrato y anexo' + '\n' +
                    '* Grupo Económico' + '\n' +      
                    '* Descripción del documento' + '\n' +
                    '* Tipo de documento (original o copia)' + '\n' +  
                    '* Tipo de salida (definitiva o préstamo)' + '\n' +      
                    '* Fecha  estimada de devolución (en caso de préstamo)' + '\n' +
                    '* Proridad (norma o urgente)' + '\n' +                      
                    '* Número de serie (si aplica)' + '\n' +
                    '* Motivo para el cual se requiere el documento';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Devolución de documentos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de solicitud (ticket)' + '\n' +
                    '* Fecha de entrega del documentoo' + '\n' +
                    '* Fecha estimada de devolución' + '\n' +      
                    '* Indicador de dentro/fuera de rango de préstamo.';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Write off (Rentas, Residuales)')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Adjuntar aprobación de riesgo (Collections) y finanzas ' + '\n' +
                    ' * Proporcionar monto a modificar ' + '\n' +      
                    ' * Proporcionar importe de IVA (si aplica) ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Cuenta bancaria')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = ' * Entidad legal de Engenium  que factura al cliente.' + '\n' +
                    ' * Tipo de moneda ' + '\n' +
                    ' * Adjuntar RFC de cliente';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Información de Seguros')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Descripcion del equipo  ' + '\n' +
                    ' * Número de serie (si aplica) ' + '\n' +      
                    ' * Número de póliza (si aplica) ' + '\n' +
                    ' * Número de siniestro (para siniestros)';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Aclaración de Cargos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar el cargo a aclarar (renta, moratorio, intereses, IVAs, diferencia de tipo de cambio,gastos de importación) ' + '\n' +
                    ' * Especificar moneda ' + '\n' +      
                    ' * Mencionar tipo de arrendamiento ' + '\n' +
                    ' * Especificar fecha del cargo a aclarar';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Soporte de pago efectuado')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Fecha de pago' + '\n' +
                    ' * Especificar monto del pago ' + '\n' +
                    ' * Especificar el concepto del pago (Depósito de buena fe, depósito de seguridad, AP, Reembolso, nueva originación) ' + '\n' +      
                    ' * Tipo de moneda ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Split de Equipos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Adjuntar detalle de equipos a separar ' + '\n' +
                    ' * Especificar el importe de los equipos ' + '\n' +      
                    ' * Especificar importe porcentajje de residual ' + '\n' +
                    ' * Especificar números de serie, marca, modelo, año ' + '\n' +  
                    ' *  Especificar descripción de los equipos ' + '\n' +
                    ' * Adjuntar facturas del proveedor ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Rebooking')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar cambio de tasa (si aplica) ' + '\n' +
                    ' * Especificar "year type" (si aplica) ' + '\n' +      
                    ' * Especificar monto de la nueva renta (si aplica) ' + '\n' +
                    ' * Especificar cuenta bancaria (si aplica) ' + '\n' +  
                    ' * Adjuntar detalle de equipo ' + '\n' +
                    ' * Especificar monto de la renta interina (si aplica) ' + '\n' +
                    ' * Especificar monto de gastos legales (si aplica) ' + '\n' +  
                    ' * Especificar monto de comisiones ( si aplica) ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'T&A')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Detalle de activos a transferir ' + '\n' +
                    ' * Fecha efectiva del cambio';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Registro de re-estructura')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Fecha efectiva del cambio ' + '\n' +
                    ' * Especificar cambio de tasa (si aplica) ' + '\n' +      
                    ' * Especificar ""year type"" (si aplica) ' + '\n' +
                    ' * Especificar monto de la nueva renta (si aplica) ' + '\n' +  
                    ' * Especificar cuenta bancaria (si aplica) ' + '\n' +
                    ' * Adjuntar detalle de equiipo ' + '\n' +
                    ' * Especificar monto de la renta interina (si aplica) ' + '\n' +  
                    ' * Especificar monto de gastos legales (si aplica) ' + '\n' +                    
                    ' * Especificar monto de comisiones ( si aplica) ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Cambios de integridad de datos')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Número de cliente ' + '\n' +
                    ' * Grupo económico ' + '\n' +      
                    ' * Especificar elcambio requerido';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Evergreens')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Monto del evergreen a corregir o "waivear" ' + '\n' +
                    ' * Número de Evergreens ' + '\n' +      
                    ' * Tipo de moneda ' + '\n' +
                    ' * Fecha de pago de cada Evergreen ' + '\n' +  
                    ' * Especificar el monto a aclarar ' + '\n' +
                    ' * Adjuntar soporte (deseable) ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Cotización de Fin de Arrendamiento')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Nombre del contacto por parte del cliente (correo y teléfono) ';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Seguimiento de Siniestro')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar los datos del equipo (*serie , marca, modelo) ';
                break;
            } 
            if(e.CAS001_ls_requerimiento__c == 'Duda en Facturación')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Folio de factura ' + '\n' +
                    ' * Especificar el conpeto y monto a aclarar ';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Información de Arrendamiento')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar la duda de la cual el cliente requiere información ';
                break;
            }    
            if(e.CAS001_ls_requerimiento__c == 'Envío de copia de documento')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar el documento requerido ' + '\n' +
                    ' * Especificar datos del equipo para envío de facturas de origen (cuando aplique)';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Emisión de Carta')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Número de contrato (Account Schedule)' + '\n' +
                    ' * Especificar motivo para la cual se requiere la carta ' + '\n' +
                    ' * Especificar datos del equipo ' + '\n' +      
                    ' * Adjuntar identificación y credencial de empleado del usuario (para los casos de carta poder) ';
                break;
            }  
            if(e.CAS001_ls_requerimiento__c == 'Solicitud de Reimplementación')
            {
                e.CAS008_tx_requisitosParaEjecutarElCaso__c = '* Razón Social/Grupo Económico' + '\n' +
                    ' * Datos del contacto (Nombre, número telefónico, correo electrónico) ';
                break;
            }  
        }
    }
}