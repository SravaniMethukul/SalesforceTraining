public class DIY_12_Dyanamic_SOQL {
    public static void searchRecords(String objName, List<String> fieldnames){
        
        String sObjectType = objName; 
        integer flag = 0;
		Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();

		if (globalDescribeMap.containsKey(sObjectType)) {
    		System.debug('Valid SObject type: ' + sObjectType);
            Map<String, Schema.SObjectField> fieldMap = globalDescribeMap.get(sObjectType).getDescribe().fields.getMap();
    		List<String> validFields = new List<String>();
            for(String f:fieldnames){
                if(fieldMap.containsKey(f)){
                    validFields.add(f);
                }
                else{
                    flag=1;
                    break;
                }
            }
            if(flag==0){
            	if(!validFields.isEmpty()){
            		String fields = String.join(validFields,',');
        			String strquery = 'Select ' +fields+' From '+objName;
            		List<Sobject> s = Database.query(strquery);
   					for(Sobject rec:s){
						System.debug(' Id: '+rec.Id+' Name '+rec.get('Name'));
            		}
				} 
            }
            else{
                System.debug('Invalid Fields');
            }
        }
        else {
    		System.debug('Invalid SObject type: ' + sObjectType);
		}
    }
    public static void searchRecords2(String Obj, List<String> fields, String search_field, String operator, Integer Value){
        String field_names = string.join(fields, ',');
        String strquery = 'Select '+field_names+' From '+Obj+' Where '+search_field+operator+Value;
        List<Sobject> s = Database.query(strquery);
        try{
            for(Sobject rec:s){
                System.debug('Id: '+rec.Id+' Name: '+rec.get('Name'));
            }
        }
        catch(DMLException e){
            System.debug('Error occured');
        }
    }
}