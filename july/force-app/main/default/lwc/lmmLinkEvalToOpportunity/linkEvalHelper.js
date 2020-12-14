import blank from "./views/blank.html";
import mainpage from "./lmmLinkEvalToOpportunity.html";
import detailEval from "./views/evalDetail.html";
import { searchEval } from "./cloneEvalHelper";

async function getevalRecord(){
    console.log('en el helper')
    this.section = blank;
    if ((this.evalrequestId !== null) & (this.evalrequestId !== undefined)) {
      await searchEval(this.sso, "SF", this.evalrequestId)
        .then(result => {
          console.log("el evallll");
          console.log(result);
          this.evalRecord = result;
          this.printPdfbutton = true;
          this.evalStatus = result.requests.request[0].header.requestStatus;
          this.evalSumary = this.evalRecord.requests.request[0].eval.evalHeader;
          if (
            result.requests.request[0].header !== null &&
            result.requests.request[0].header !== undefined
          ) {
            this.endDate = result.requests.request[0].header.endDate;
          }
          if (
            (result.requests.request[0].eval.evalDetail !== null) &
            (result.requests.request[0].eval.evalDetail !== undefined)
          ) {
            this.evalAssets = this.evalRecord.requests.request[0].eval.evalDetail.evAssets.evAsset;
            console.log("los evals asset");
            console.log(this.evalAssets);
            if (this.evalAssets.length > 0) {
              try {
                let arrvalu = [...this.evalAssets].filter(
                  ({ evAssetValuations }) => evAssetValuations
                );
                console.log("ARRvalu");
                console.log(arrvalu);
                let assetVal = [...arrvalu].map(
                  ({ evAssetValuations }) => evAssetValuations
                );

                console.log("LA VALUCAION");
                console.log(assetVal);
                this.evalValuations = [];
                assetVal.forEach(val => {
                  val.evValuation.forEach(valuacion => {
                    this.evalValuations.push(valuacion);
                  });
                });
                /* assetVal.map(
                  ({ evValuation }) => evValuation
                )[0]; */
                console.log("assetVal");
                console.log(this.evalValuations);

                let totalcost = this.evalSumary.evEquipmentAmountTax;
                console.log("evaltotalcost: " + totalcost);
                this.evalAssets.forEach(assetb => {
                  this.evalValuations.forEach(valuationb => {
                    if (valuationb.evValAssetId === assetb.evAssetAssetId) {
                      let amount = {
                        fmv: valuationb.evValFmvAmount!==undefined? valuationb.evValFmvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        nrv: valuationb.evValNrvAmount!==undefined? valuationb.evValNrvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        olv: valuationb.evValOlvAmount!== undefined? valuationb.evValOlvAmount  * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        rv: valuationb.evValRvAmount!==undefined? valuationb.evValRvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        months: valuationb.evValTermMonths,
                        assetid: valuationb.evValAssetId,
                        insurance: valuationb.evValInsurancePrima
                      };
                      this.amounts.push(amount);
                    }
                  });
                });

                let elementos = [];

                this.amounts.forEach(el => {
                  let am = this.amounts.filter(
                    ({ months }) => months === el.months
                  );
                  let estru = {
                    fmv: 0,
                    nrv: 0,
                    olv: 0,
                    rv: 0,
                    months: el.months,
                    insurance: 0
                  };
                  am.forEach(co => {
                    estru.fmv = estru.fmv += co.fmv;
                    estru.nrv = estru.nrv += co.nrv;
                    estru.olv = estru.olv += co.olv;
                    estru.rv = estru.rv += co.rv;
                    estru.insurance = estru.insurance += co.insurance;
                    estru.months =
                      estru.months === co.months ? estru.months : co.months;
                    if (!elementos.includes(estru)) {
                      elementos.push(estru);
                    }
                  });
                });

                elementos.forEach(elem => {
                  elem.fmvPer = (elem.fmv * 100) / totalcost;
                  elem.nrvPer = (elem.nrv * 100) / totalcost;
                  elem.olvPer = (elem.olv * 100) / totalcost;
                  elem.rvPer = (elem.rv * 100) / totalcost;
                });

                let filteredList = [
                  ...new Set(elementos.map(JSON.stringify))
                ].map(JSON.parse);
                console.log(filteredList);
                this.amounts = filteredList;
                console.log("this amounts");
                console.log(this.amounts);
              } catch (error) {
                console.log(
                  "Error al cargar valuations: " + JSON.stringify(error)
                );
              }
            }
          }
          console.log("assets");
          console.log(this.evalAssets);
          if ((result !== null) & (result !== undefined)) {
            console.log("detail");
            this.section = detailEval;
            return {
                section:this.section,
                evalrecord:this.evalRecord,
                printpdf:this.printPdfbutton,
                evalStatus : this.evalStatus,
                evalSumary: this.evalSumary,
                endDate: this.endDate,
                evalAssets:this.evalAssets,
                evalValuations: this.evalValuations,
                amounts: this.amounts
            }
          }
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  consultar el eval ligado",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });
    } else {
      console.log("mainpage");
      this.section = mainpage;
    }
}

export {
    getevalRecord
}