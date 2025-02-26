trigger EmployeeTrigger on Employee__c (after delete) {
    Switch on Trigger.OperationType{
        When After_Delete{
            Set<Id> accIds = new Set<Id>();
            for(Employee__c emp:Trigger.old){
                if(emp.Account__c!=null)
                	accIds.add(emp.Account__c);
            }
            List<Account> accToEmpCheck = [Select Id, (Select Employee_Name__c From Employees__r)
                                        From Account
                                        Where Id In: accIds];
            List<Account> UpdateAcc = new List<Account>();
            if(!accToEmpCheck.isEmpty()){
            	for(Account acc:accToEmpCheck){
                    if(acc.Employees__r.size()==0){
                        UpdateAcc.add(acc);
                    }
            	}
            }
            if(!UpdateAcc.isEmpty()){
                for(Account a:UpdateAcc){
                    a.Active__c = 'No';
                }
                update UpdateAcc;
            }
        }
    }
}