public with sharing class CustomerLoginController {

    @AuraEnabled(cacheable=true)

    public static Id customerLogin(
        String email,
        String password
    ){

        List<Customer> customers = [

            SELECT Id,
                   Name,                   
                   Customer_Email__c,
                   Password__c

            FROM Customer

            WHERE Customer_Email__c = :email
            AND Password__c = :password

            LIMIT 1
        ];

        if(!customers.isEmpty()){

            return customers[0].Id;
        }

        return null;
    }
}