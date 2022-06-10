import { LightningElement } from 'lwc';

export default class HotelFilterAppHome extends LightningElement {

    get options() {
        return countrySelectOptions[
            { label: "US", value: "US" },
            { label: "Poland", value: "Poland" }
        ];
    }

    countrySelectedValue = 'US';

    handleCountryChange(event){
        console.log()

        this.countrySelectedValue = event.target.value;
    }


}