import { LightningElement, api, wire, track } from "lwc";
import getComments from "@salesforce/apex/Aml_Review_cls.getComments";
import Id from "@salesforce/user/Id";
import getUserPhotos from "@salesforce/apex/Aml_Review_cls.getUserPhotos";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from "lightning/platformShowToastEvent"; // import toast message event .

export default class Aml_Review_Comments extends LightningElement {
  @api recordId;
  @api requestId='';
  @api userId = Id;
  @api commentType='';
  @track commentRecord = [];
  @track commentarios = [];
  @track commentsUsIds;
  @track error;
  @track datos;

  wiredCommentsResult;

  @wire(getComments, { recordId: "$recordId",requestId:"$requestId", commentType:"$commentType" })
  wireComments(result) {
    this.wiredCommentsResult = result;
    var usersId = [];
    var userrec = [];

    if (result.data) {
      // eslint-disable-next-line vars-on-top
      for (var item of result.data) {
        var userUs = {
          id: item.Id,
          userName: item.LWC_User_Name__c,
          comment: item.LWC_Comment__c,
          ownerId: item.OwnerId,
          photo: "",
          createDate: item.LWC_fm_Creation_Date__c,
          isActualUser: null
        };

        usersId.push(userUs.ownerId);
        userrec.push(userUs);
      }
      this.commentRecord = userrec;
      this.commentsUsIds = usersId;

      getUserPhotos({ userIds: this.commentsUsIds })
        .then(result => {
          if (result) {
            console.log("photos");
            console.log(result);
            console.log(this.commentRecord);
            let coms =[];
            for (let comRecord of this.commentRecord) {
              for (let photo of result) {
                if (comRecord.ownerId === photo.Id) {
                  comRecord.photo = photo.SmallPhotoUrl;
                }
                if (comRecord.ownerId === this.userId) {
                  comRecord.isActualUser = true;
                } else {
                  comRecord.isActualUser = false;
                }
              }
              coms.push(comRecord);
            }
            console.log("koooo");
            this.commentarios = coms;
            console.log(this.commentarios);
            let a = this.template.querySelector("[data-id=chat]");
            let xH = a.scrollHeight;
            a.scrollTop=xH + xH; 
            this.error = undefined;
          }
        })
        .catch(error => {
          this.error = error;
          console.log(error.message);
          let showWarning = new ShowToastEvent({
            title: "Error!!",
            message: this.error.message,
            variant: "warning"
          });
          this.dispatchEvent(showWarning);
        });
    } else if (result.error) {
      this.error = result.error;
      console.log("error comments");
      console.log(this.error);
      this.commentRecord = undefined;
    }
  }


  handleSuccess(event) {
    let showWarning = new ShowToastEvent({
      title: "Success!!",
      message: "Comentario creado con exito",
      variant: "success"
    });
    this.dispatchEvent(showWarning);
    return refreshApex(this.wiredCommentsResult);
  }
  
  onRecordSubmit(event){
    event.preventDefault();
    console.log('evento submit');
    console.log(event.detail.fields);
    
    
    const fields = event.detail.fields;
    fields.LWC_Related_RecordId__c=this.recordId;
    fields.LWC_RequestId__c=this.requestId;
    fields.LWC_Comment_Type__c=this.commentType;
    this.template.querySelector("[data-id=commForm]").submit(fields);
    this.template.querySelector("[data-id=commInput]").value="";
  }

  gobot (){
      let a = this.template.querySelector("[data-id=chat]");
      a.scrollTop =a.scrollHeight;
  }
}