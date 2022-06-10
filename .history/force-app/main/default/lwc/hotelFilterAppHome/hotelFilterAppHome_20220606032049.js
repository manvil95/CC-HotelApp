import { LightningElement,wire } from 'lwc';
import countryList from '@salesforce/apex/HotelController.countryList';

export default class HotelFilterAppHome extends LightningElement {

    countryList= [
    ];

    @wire(countryList)
    countryListfromApex({data,error}){
        if(data){

            this.countryList = data;
            //console.log(data);

            data.forEach(element => {

                console.log(element)

                console.log(element.Country__c)
                this.countryList = [...this.countryList,{"label":element.Country__c, "value":element.Country__c}];
                console.log()

            });

        }
        if(error){
            console.error(error);
        }
    }


    get countrySelectOptions() {
        return [
            { label: "US", value: "US" },
            { label: "Poland", value: "Poland" }
        ];
    }

        get citySelectOptions() {
        return [
            { label: "San Francisco", value: "San Francisco" },
            { label: "Wroclaw", value: "Wroclaw" }
        ];
    }

    countrySelectedValue = 'US';
    citySelectedValue;

    handleCountryChange(event){

        this.countrySelectedValue = event.target.value;
    }

        handleCityChange(event){

        this.citySelectedValue = event.target.value;
        console.log(this.citySelectedValue);
    }


}