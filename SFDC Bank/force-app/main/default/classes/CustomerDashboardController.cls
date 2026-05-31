public with sharing class CustomerDashboardController {

    @AuraEnabled(cacheable=true)

    public static List<Bank_Account__c>
    getCustomerAccounts(Id customerId){

        return [

            SELECT Id,
                   
                   Owner_Customer_Name__c,
                   Owner_Customer_Name__r.Name,
                   Name,
                   Account_Type__c,
                   PAN_Number__c,
                   Account_Balance__c,
                   Status__c

            FROM Bank_Account__c

            WHERE Customer__c = :customerId
        ];
    }
}