/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-31-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-30-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getEntitiesWithContacts from "@salesforce/apex/lmmKYCController.getEntitiesWithContacts";
import getContactsWithKYCs from "@salesforce/apex/lmmKYCController.getContactsWithKYCs";



export default class LmmKYC extends LightningElement {
    @api recordId
    @track disableButtonEmail = true;
    @track selectContacts;

    EntitiesWithContacts

    @wire(getEntitiesWithContacts, {opportunityId:"$recordId"})
    getEntitiesWithContactsResult(result){
        console.log('Inicia lmmKYC ' + this.recordId)
        console.log('result ' + JSON.stringify(result))
        if(result.data){
            this.EntitiesWithContacts = result.data
            console.log('this.EntitiesWithContacts ' + JSON.stringify(this.EntitiesWithContacts))
        }
    }
    /*
    @wire(getContactsWithKYCs, { opportunityId: "$recordId" })
    getEntitiesWithContactsResult(result) {
        console.log('Inicia lmmKYC ' + this.recordId)
        console.log('result ' + JSON.stringify(result))
        if (result.data) {
            this.EntitiesWithContacts = result.data
            console.log('this.EntitiesWithContacts ' + JSON.stringify(this.EntitiesWithContacts))
        }
    }*/

    handleSendKYC() {

        let conIds = new Set();

        for (let contact of this.selectContacts) {
            conIds.add(contact.Id);
        }
        console.log('Id de los contactos');
        console.log(conIds);
        
        /*
        var div = document.getElementById("tablet");
        var tabla   = document.createElement("table");
        var tblBody = document.createElement("tbody");

        // Crea las celdas
        for (var i = 0; i < 2; i++) {
            // Crea las hileras de la tabla
            var hilera = document.createElement("tr");

            for (var j = 0; j < 2; j++) {
                // Crea un elemento <td> y un nodo de texto, haz que el nodo de
                // texto sea el contenido de <td>, ubica el elemento <td> al final
                // de la hilera de la tabla
                var celda = document.createElement("td");
                var textoCelda = document.createTextNode("celda en la hilera " + i + ", columna " + j);
                console.log('1')
                celda.appendChild(textoCelda);
                console.log('2')
                hilera.appendChild(celda);
                console.log('3')
            }

            // agrega la hilera al final de la tabla (al final del elemento tblbody)
            console.log('4')
            tblBody.appendChild(hilera);
            console.log('5')
        }

        // posiciona el <tbody> debajo del elemento <table>
        console.log('6')
        tabla.appendChild(tblBody);
        console.log('7')
        div.appendChild(tabla);
 
        // modifica el atributo "border" de la tabla y lo fija a "2";
        tabla.setAttribute("border", "2");*/

        /*

        var table = this.template.querySelector("[data-field='entityContacts']")
        var tbody = createElement('tbody')
        var fila = createElement('tr')
        var columna = createElement('td')
        var texto = createTextNode('ovos')
        columna.appendChild(texto)
        fila.appendChild(columna)
        tbody.appendChild(fila)
        table.appendChild(tbody)*/
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Éxito',
                message: 'Se han enviado correos a los contactos',
                variant: 'success',
            }),
        );

    }

    handleSendContacts(event) {
        this.selectContacts = event.detail;
        console.log('List contacts: ' + this.selectContacts);

        if (this.selectContacts == null || this.selectContacts === undefined || this.selectContacts.length === 0) {
            this.disableButtonEmail = true;
        } else {
            this.disableButtonEmail = false;
        }
    }

}