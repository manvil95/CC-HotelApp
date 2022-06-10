import { LightningElement,wire } from 'lwc';
import countryList from '@salesforce/apex/HotelController.countryList';
import cityList from '@salesforce/apex/HotelController.cityList';

export default class HotelFilterAppHome extends LightningElement {

    //Default Values
    countrySelectedValue;
    citySelectedValue;

    // Populate with APEX Data
    countryList= [];
    cityList = [];
    cityFilteredList = [];

    @wire(countryList)
    countryListfromApex({data,error}){
        if(data){

            data.forEach(element => {

                this.countryList = [...this.countryList,{"label":element.Country__c, "value":element.Country__c}];
            });

        }
        if(error){
            console.error(error);
        }
    }

    @wire(cityList)
    cityListfromApex({data,error}){
        if(data){

            data.forEach(element => {
                this.cityList = [...this.cityList,{"label":element.City__c, "value":element.City__c}];
            });
        }
        if(error){
            console.error(error);
        }
    }

/*
    getCityList(){

        cityList({countryName:this.countrySelectedValue}).then((result)=>{

            this.cityFilteredList = result;
            console.log(result);

        })
    }

    */

    get countrySelectOptions() {
        return this.countryList;
    }

        get citySelectOptions() {
        return this.cityList;
    }

    handleCountryChange(event){

        this.countrySelectedValue = event.target.value;
       // this.getCityList();

    }

        handleCityChange(event){

        this.citySelectedValue = event.target.value;
        console.log(this.citySelectedValue);
    }


}