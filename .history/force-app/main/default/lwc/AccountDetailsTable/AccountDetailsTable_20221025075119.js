import { LightningElement,wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountsWithContacts.accountList';
import ACCOUNT_DATA from '@salesforce/apex/AccountsWithContacts.accountData';
import getAccountWithContact from '@salesforce/apex/AccountsWithContacts.accountWithContacts';

const  columns = [

    {label:'Id',fieldName:'Id'},
    {label:'Name',fieldName:'Name'}

]

export default class AccountDetailsTable extends LightningElement {

    accList = [];
    columns = columns;
    selectedIds = [];

    loadAccountData(){
        getAccountList().then(result=>{
            this.accList = result;
            console.log(result);
            })
                .catch(error => {
                    this.error = error;
                });
            }

            connectedCallback(){
                this.loadAccountData();
            }

            // Load Account Data with Contact Info
            loadAccountWithContacts(){
        getAccountList().then(result=>{
            this.accList = result;
            console.log(result);
            })
                .catch(error => {
                    this.error = error;
                });
            }

            connectedCallback(){
                this.loadAccountData();
            }

        getSelectedContacts(event) {

        this.selectedIds = [];
       const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
            this.selectedIds = [...this.selectedIds,selectedRows[i].Id];
        }
        console.log(this.selectedIds);


}
}