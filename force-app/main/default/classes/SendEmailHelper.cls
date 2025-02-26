public class SendEmailHelper {
    public static boolean sendEmail(String subject, String body, String toAddress,List<String> catchResults){
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.toAddresses = new String[]{toAddress};
        msg.subject = subject;
        msg.htmlbody=body;
        msg.htmlbody+=catchResults;
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>{msg};
        List<Messaging.SendEmailResult> res = Messaging.SendEmail(messages);
        if(res[0].success){
            System.debug(res[0].success);
            return true;
        }
        else{
            return false;
        }
    }
}