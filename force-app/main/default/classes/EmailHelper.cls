public class EmailHelper {
    public static boolean doSendEmail(String subject, String body, String toAddress){
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.toAddresses = new String[]{toAddress};
        msg.subject=subject;
        msg.htmlbody=body;
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>{msg};
        List<Messaging.sendEmailResult> results = Messaging.sendEmail(messages);
        if(results[0].success){
            return true;
        }
        else{
            return false;
        }
    }
}