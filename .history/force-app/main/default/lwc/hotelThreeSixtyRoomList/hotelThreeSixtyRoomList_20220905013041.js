import { LightningElement,wire } from 'lwc';
import roomList from '@salesforce/apex/roomController.roomList';
import recordSelected from '@salesforce/messageChannel/hotelId__c';

import {
    subscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';

const dataColumns = [
    {label:'Room Number',fieldName:'Room_Number__c'},
    {label:'Name',fieldName:'Name'},
    {label:'Type',fieldName:'Type__c'},
    {label:'Max Number of Guests',fieldName:'Max_Number_of_Guests__c'},
    {label:'Available',fieldName:'Available__c'},
    {label:'Jacuzzi',fieldName:'Jacuzzi__c'}

];

export default class HotelThreeSixtyRoomList extends LightningElement {

    subscription = null;
    roomList;
    roomListSize = 0;
    dataColumns = dataColumns;
    hotelValue;
    recordId;
    roomShow;
    selectedRooms = [];


    @wire(MessageContext)
    messageContext;

      // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
   subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                recordSelected,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    //  Handler for message received by component
    handleMessage(message) {
        this.hotelValue = message.hotelId;
        this.getRoomList();
        console.log('handleMessage --> This roomShow = ',this.roomShow);
    }


     getRoomList() {

        roomList({h: this.hotelValue }).then((result) => {
            this.roomList = result;
            this.roomListSize = Object.keys(this.roomList).length;
            console.log('getRoomList --> Room List size = ', this.roomListSize);
            this.roomShow = this.roomListSize > 0 ? true : false;
        }).catch((error) => {
            console.error(error);
        })
    }

    connectedCallback(){
        this.subscribeToMessageChannel();

    }

     getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        const selectedIds = [];
        console.log('selected rooms are : ',selectedRows);
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
           // this.selectedRooms = [...this.selectedRooms,selectedRows[i].Id];
           // console.log(selectedRows[i].Id);
           // selectedIds = [...selectedIds,selectedRows[i].Id];
           // console.log(selectedIds);
        }
    }


}