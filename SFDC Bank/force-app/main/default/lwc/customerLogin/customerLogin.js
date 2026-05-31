import { LightningElement }from 'lwc';
import Loginimg from '@salesforce/resourceUrl/Loginimg';

import customerLogin
from '@salesforce/apex/CustomerLoginController.customerLogin';

import { NavigationMixin }
from 'lightning/navigation';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CustomerLogin
extends NavigationMixin(LightningElement){

    email;
    password;
    loginImg = Loginimg;
    
    handleEmail(event){

        this.email = event.target.value;
    }

    handlePassword(event){

        this.password = event.target.value;
    }

    handleLogin(event){

        if (!this.email || !this.password) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Validation Error',
                    message: 'Please enter both email and password.',
                    variant: 'error'
                })
            );
            return;
        }

        customerLogin({

            email:this.email,
            password:this.password

        })

        .then(result=>{

            if(result){

                
                this[NavigationMixin.Navigate]({

                    type:'standard__navItemPage',
                    //type:'standard__webPage',


                    attributes:{

                        apiName:'customerDashboard'
                       // url:'/customerdashboard?c__customerId=' + result
                        

                    },
                     state:{

                             c__customerId:result
                         }
                });

            } else {

                alert('Invalid Credentials');
            }
        })

        .catch(error=>{

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Login Error',
                    message: error.body ? error.body.message : error.message,
                    variant: 'error'
                })
            );
            console.error(error);
        });
    }
}