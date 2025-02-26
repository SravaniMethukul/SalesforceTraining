public class QueueableEmailUtilityHelper implements Queueable{
    
    public List<Account> accountList;
    public QueueableEmailUtilityHelper(List<Account> acclist){
        accountList=acclist;
    }
    //List<Account> retreivedaccList = [Select Id, rating, Owner.Email From Account Where Id in:accountList];
    // send email to accord record owner on discount update
    public void execute(QueueableContext cxt){
        List<Messaging.SingleEmailMessage> emaillist = new List<Messaging.SingleEmailMessage>();
        String subject = 'Account Discount update';
        String body='Account Discount update';
        for(Account acc:accountList){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            string toaddress = acc.Owner.email;
            List<String> toAddresses = new List<String>();
            toAddresses.add(toaddress);
            mail.settoAddresses(toAddresses);
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
            emaillist.add(mail);
        }
        Messaging.sendEmail(emaillist);
    }
}