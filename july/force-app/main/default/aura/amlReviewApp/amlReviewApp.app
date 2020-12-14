<aura:application implements="force:appHostable,lightning:isUrlAddressable,flexipage:availableForAllPageTypes" extends="force:slds">
    <aura:attribute name="as__id" type="String" access="public" />
    <aura:handler name="init" value="this" action="{!c.doInit}" />
    <aura:registerEvent name="passCaId" type="c:aml_ReviewPassV" />
    <div class="slds-m-horizontal_x-small">
        <div class="slds-text-body_regular">
            <c:ES3_com_Tollgate recordId="{! v.as__id}"></c:ES3_com_Tollgate>
        </div>
    </div>

    <c:aml_Review_lwc recordId="{! v.as__id}"/>
    <c:aml_Review_Structure_lwc recordId="{! v.as__id}"></c:aml_Review_Structure_lwc>
    <c:aml_Review_Details></c:aml_Review_Details>
    <c:aml_Review_Comments recordId="{!v.as__id}"></c:aml_Review_Comments>
    <c:aml_Review_Docs_lwc recordId="{!v.as__id}"></c:aml_Review_Docs_lwc>
</aura:application>