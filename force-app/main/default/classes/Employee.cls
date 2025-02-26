public class Employee {
    public static string insertEmployee(Employee__c emp){
		List<Employee__c> emplist = [SELECT Employee_Name__c From Employee__c Where Employee_Name__c=:emp.Employee_Name__c];
        if(emplist.size()>0){
			//System.debug('Record with same name already exists');
			return 'Record with same name already exists';
        }
        else{
            emp.Employee_Name__c = emp.Employee_Name__c;
            if(emp.Position__c==null){
                emp.Position__c='Others';
            }
            if(emp.Position__c!='HR Department' && emp.Salary__c != null && emp.Salary__c>80000){
				System.debug('Salary of employee other than HR department should be less than 80000');
                return null;
            }
            insert emp;
            System.debug('Inserted record ID'+emp.Id);
            return 'record inserted successfully';
        }
    }
    
    public static string updateEmployee(Employee__c emp){
		List<Employee__c> emplist = [SELECT Id, Employee_Name__c From Employee__c Where Employee_Name__c=:emp.Employee_Name__c];
        if(emplist.isEmpty()){
			//System.debug('Record does not exist to update');
			return 'Record does not exist to update';
        }
        else{
            emp.Employee_Name__c = 'Test updated';
            update emp;
            System.debug('updated record ID:'+emp.Id);
            System.debug('updated ' + emplist.size() + ' record');
            return 'record updated successfully';
        }
    }
    
    public static string deleteEmployee(Employee__c emp){
		List<Employee__c> emplist = [SELECT Id, Employee_Name__c From Employee__c Where Employee_Name__c=:emp.Employee_Name__c];
        if(emplist.isEmpty()){
			//System.debug('No record exist to delete');
			return 'No record exist to delete';
        }
        delete emplist;
        System.debug('Deleted ' + emplist.size() + ' record');
        return 'Record deleted Successfully';
    }
    
    public static string maxSalaryForPosition(String Position){
        List<AggregateResult> emp = [Select Max(Employee__c.salary__C) Maximum_Salary, Position__c 
                                 From Employee__C
                                 Where Position__c=:Position
                                 Group By Position__c];
        if(emp.size()>0){
        	for(AggregateResult a : emp){
                if(a.get('Position__c')!=null){
            		System.debug('Position: '+a.get('Position__c'));
					System.debug('Maximum Salary: '+a.get('Maximum_Salary'));
                }
        	}
            return 'Max salary found successfully';
        }
        else{
			//System.debug('No records Found');
			return 'No records Found';
        }
    }
    
}