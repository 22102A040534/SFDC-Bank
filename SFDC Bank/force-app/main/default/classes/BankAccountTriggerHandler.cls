public class BankAccountTriggerHandler {

    public static void updateAccountStatus(
        List<Bank_Account__c> accountList
    ){

        List<Messaging.SingleEmailMessage> emails = 
            new List<Messaging.SingleEmailMessage>();

        for(Bank_Account__c acc : accountList){

            if(acc.Account_Balance__c != null){

                if(acc.Account_Balance__c < 1000){

                    acc.Status__c = 'Inactive';

                    // Send Email
                    if(acc.Customer__r.Customer_Email__c != null){

                        Messaging.SingleEmailMessage mail =
                            new Messaging.SingleEmailMessage();

                        mail.setToAddresses(
                            new List<String>{acc.Customer__r.Customer_Email__c}
                        );

                        mail.setSubject(
                            'Bank Account Deactivated'
                        );

                        mail.setPlainTextBody(
                            'Dear Customer,\n\n' +
                            'Your bank account has been deactivated ' +
                            'because your balance fell below the minimum ' +
                            'required balance of $1000.\n\n' +
                            'Please deposit funds to reactivate your account.\n\n' +
                            'Thank You.'
                        );

                        emails.add(mail);
                    }

                } else {

                    acc.Status__c = 'Active';
                }
            }
        }

        // Send all emails together (Bulk Safe)
        if(!emails.isEmpty()){

            Messaging.sendEmail(emails);
        }
    }
}