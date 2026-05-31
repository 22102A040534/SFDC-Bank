public with sharing class BankAccountController {

    @AuraEnabled(cacheable=true)
    public static List<Bank_Account__c> searchAccounts(String searchKey){
         String key = '%' + searchKey + '%';
        return [
            SELECT Id,
                   Owner_Customer_Name__c,
                   Owner_Customer_Name__r.Name,
                   Name,
                   Account_Balance__c,
                   PAN_Number__c,
                   Status__c,
                   Account_Type__c

            FROM Bank_Account__c
            WHERE Name LIKE :key
            OR Owner_Customer_Name__r.Name LIKE :key
            LIMIT 10
        ];
    }
}