public class ErrorLog {
	
    public static void databaseErrorLog(Database.SaveResult[] Srlist, String eName, String eClass, String eMethod, List<Sobject> sobjectlist){
        List<String> errMsgList = new List<String>();
        for(integer i=0;i<srlist.size();i++){
            if(!srlist.get(i).isSuccess()){
                errMsgList.add('Failed Id: '+ sobjectlist[i].Id);
                for(Database.Error err:srlist.get(i).getErrors()){
                    errMsgList.add('Status Code:'+err.getStatusCode());
                    errMsgList.add('Message:'+err.getMessage());
                    errMsgList.add('Fields:'+err.getFields());
                }
            }
        }
        insertError(eName,eClass,eMethod,errMsgList);
    }
    
    public static void insertError(String eName, String eClass, String eMethod, List<String> errMsgList){
        String errMessage =String.join(errMsgList, '\n');
        Error_Log__c errList = new Error_Log__c(Event_Name__c = ename,
                                                      Apex_Class__c = eClass,
                                                      Apex_Method__c = eMethod,
                                                       Error_Message__c = errMessage);
        insert errList;
    }
}