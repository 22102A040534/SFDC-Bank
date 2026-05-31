import { LightningElement, track } from 'lwc';

import searchAccounts
from '@salesforce/apex/BankAccountController.searchAccounts';

export default class AccountDashboard
extends LightningElement {

    @track accounts = [];

    searchKey = '';

    connectedCallback(){

        this.loadAccounts();
    }

    handleSearch(event){

        this.searchKey = event.target.value;

        this.loadAccounts();
    }

    loadAccounts(){

        searchAccounts({

            searchKey:this.searchKey

        })

        .then(result=>{

            this.accounts = result;

        })

        .catch(error=>{

            console.log(error);
        });
    }
}