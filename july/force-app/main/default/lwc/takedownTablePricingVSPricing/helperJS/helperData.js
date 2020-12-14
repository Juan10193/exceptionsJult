let parseData = (objectData)=>{
    let PricingVSPricing = {cA_Wrapper:
        {creditApprovalId:objectData.cA_Wrapper.creditApprovalId,
        creditApprovalName:objectData.cA_Wrapper.creditApprovalName,
        pricingName:objectData.cA_Wrapper.pricingId},
                            sT_Wrapper:
        {pricingcreditApprovalId:objectData.sT_Wrapper.pricingName,
            pricingName:objectData.sT_Wrapper.pricingcreditApprovalId}};
    return PricingVSPricing;
}



export { parseData };