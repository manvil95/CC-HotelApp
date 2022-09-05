import { LightningElement,api } from 'lwc';
import reservationList from '@salesforce/apex/ReservationController.reservationList';


export default class HotelThreeSixtyReservationList extends LightningElement {


@api roomId = [];

resList;

    @api getReservationList() {

        tempId = 

        console.log('selected room Ids are:',this.roomId);

        reservationList({rList: this.roomId }).then((result) => {

            console.log('selected room Ids are:',this.roomId);

            this.resList = result;

            //console.log('Reservation List is = ',this.resList);
        }).catch((error) => {
            console.error(error);
        })
    }


}