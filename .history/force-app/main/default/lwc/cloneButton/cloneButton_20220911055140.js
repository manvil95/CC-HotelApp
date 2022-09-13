import { LightningElement,api } from 'lwc';

import cloneRecords from '@salesforce/apex/CloneRecordController.cloneRecords';

export default class CloneButton extends LightningElement {

  @api ClassName;
  @api RecordId;
  error;

    cloneRecords(){

        cloneRecords({recordId:this.RecordId,className:this.ClassName}).then((result) => {
               console.log(result);
            }).catch((error) => {

                this.error = error;
                console.log(this.error);

            });

    }


}