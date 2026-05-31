import { LightningElement, wire }from 'lwc';

import { CurrentPageReference }
from 'lightning/navigation';

import getCustomerAccounts
from '@salesforce/apex/CustomerDashboardController.getCustomerAccounts';

export default class CustomerDashboard
extends LightningElement {

    customerId;

    @wire(CurrentPageReference)

    pageRef(currentPageReference){

        if(currentPageReference){

            this.customerId =
currentPageReference.state.c__customerId;
        }
    }

    @wire(getCustomerAccounts,
    {customerId:'$customerId'})

    accounts;
}
