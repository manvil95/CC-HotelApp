import { LightningElement,wire,api } from 'lwc';
import reservationList from '@salesforce/apex/ReservationController.reservationList';


export default class HotelThreeSixtyReservationList extends LightningElement {


@api getValueRoomIds;
resList;


     getReservationList() {

        reservationList({h: this.getValueRoomIds }).then((result) => {
            this.resList = result;
            console.log('getRoomList --> Room List size = ', this.roomListSize);
            this.roomShow = this.roomListSize > 0 ? true : false;
        }).catch((error) => {
            console.error(error);
        })
    }


}