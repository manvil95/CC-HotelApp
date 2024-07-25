import { LightningElement, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";

import RESERVATION_OBJECT from "@salesforce/schema/Reservation__c";
import RESERVATION_NAME from "@salesforce/schema/Reservation__c.Name";
import RESERVATION_ROOM from "@salesforce/schema/Reservation__c.Room__c";
import RESERVATION_CHECKIN from "@salesforce/schema/Reservation__c.Check_In_Date__c";
import RESERVATION_CHECKOUT from "@salesforce/schema/Reservation__c.Check_out_Date__c";
import RESERVATION_GUEST from "@salesforce/schema/Reservation__c.Guest_name__c";
import RESERVATION_BREAKFAST from "@salesforce/schema/Reservation__c.Breakfast__c";
import RESERVATION_BREAKFASTTYPE from "@salesforce/schema/Reservation__c.Breakfast_Type__c";

import { subscribe, MessageContext } from "lightning/messageService";

import SELECTED_ID from "@salesforce/messageChannel/roomId__c";
import HOTEL_NAME from "@salesforce/schema/MV_Hotel__c.Name";

const FIELDS = [
  "MV_Room__c.Name",
  "MV_Room__c.MV_FLG_Available__c",
  "MV_Room__c.MV_MDR_Hotel__c",
  "MV_Room__c.MV_FLG_MiniBar__c",
  "MV_Room__c.MV_URL_Photo__c",
  "MV_Room__c.MV_NUM_RoomNumber__c",
  "MV_Room__c.MV_SEL_Type__c",
  "MV_Room__c.MV_NUM_MaxNumberGuests__c"
];

export default class HotelAppHomeRoomDetails extends NavigationMixin(
  LightningElement
) {
  reservation_Object = RESERVATION_OBJECT;

  //Reservation fields
  reservationName = RESERVATION_NAME;
  reservationRoom = RESERVATION_ROOM;
  reservationCheckIn = RESERVATION_CHECKIN;
  reservationCheckOut = RESERVATION_CHECKOUT;
  reservationGuest = RESERVATION_GUEST;
  reservationBreakfast = RESERVATION_BREAKFAST;
  reservationBreakfastType = RESERVATION_BREAKFASTTYPE;

  showReservation = null;

  recordId;
  roomName;
  MV_FLG_Available__c;
  MV_FLG_MiniBar__c;
  MV_URL_Photo__c;
  MV_NUM_RoomNumber__c;
  MV_SEL_Type__c;
  hotel;
  hotelName;
  roomIdSubscription;

  //Wire message context
  @wire(MessageContext)
  messageContext;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  rooomData({ data, error }) {
    if (data) {
      (this.roomName = data.fields.Name.value),
        (this.MV_FLG_Available__c = data.fields.MV_FLG_Available__c.value),
        (this.MV_FLG_MiniBar__c = data.fields.MV_FLG_MiniBar__c.value),
        (this.MV_URL_Photo__c = data.fields.MV_URL_Photo__c.value),
        (this.MV_NUM_RoomNumber__c = data.fields.MV_NUM_RoomNumber__c.value),
        (this.MV_SEL_Type__c = data.fields.MV_SEL_Type__c.value),
        (this.MV_NUM_MaxNumberGuests__c =
          data.fields.MV_NUM_MaxNumberGuests__c.value),
        (this.hotel = data.fields.MV_MDR_Hotel__c.value);
    }
    if (error) {
      console.error(error);
    }
  }

  @wire(getRecord, { recordId: "$hotel", fields: HOTEL_NAME })
  hotelData({ data, error }) {
    if (data) {
      this.hotelName = data.fields.Name.value;
    }
    if (error) {
      console.error(error);
    }
  }

  openRecord() {
    this.navigateToRecordPage();
  }

  navigateToRecordPage() {
    // Navigate to the Record page
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.recordId,
        objectApiName: "MV_Room__c",
        actionName: "view"
      }
    });
  }

  // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
  subscribeHandler() {
    this.roomIdSubscription = subscribe(
      this.messageContext,
      SELECTED_ID,
      (message) => this.handleSelectedId(message)
    );
  }

  // Handler for message received by component
  handleSelectedId(message) {
    this.recordId = message.roomId;
  }

  connectedCallback() {
    this.subscribeHandler();
  }

  //Reset Record Form
  handleReset(event) {
    // hide form component
    this.showReservation = null;

    const inputFields = this.template.querySelectorAll("lightning-input-field");
    if (inputFields) {
      inputFields.forEach((field) => {
        field.reset();
      });
    }
  }

  showReservationForm() {
    this.showReservation = 1;
  }

  handleSuccess(event) {
    this.showReservation = null;
    console.log("new record created " + event.detail.id);
    const newrecord = event.detail.id;
    this.showToast(newrecord);
  }

  showToast(newrecord) {
    const event = new ShowToastEvent({
      title: "Success!",
      variant: "success",
      message: "New Reservation Created! See it {1}.",
      messageData: [
        "Record",
        {
          url:
            "https://cunning-unicorn-mla094-dev-ed.lightning.force.com/lightning/r/Reservation__c/" +
            newrecord +
            "/view",
          label: "here"
        }
      ]
    });
    this.dispatchEvent(event);
  }
}
