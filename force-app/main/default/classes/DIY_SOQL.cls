public class DIY_SOQL {
    public static void displayAllOpportunities(){
        List<Opportunity> oppList = [SELECT Name, stagename, closedate FROM OPPORTUNITY];
        for(Opportunity opp:oppList){
            System.debug('Name: '+opp.name+' stage: '+opp.StageName+' close date : '+opp.CloseDate);
        } 
    }
    public static void displayOpportunityAmount(integer amount){
        List<Opportunity> oppList = [SELECT Name, stagename, closedate, amount FROM OPPORTUNITY
                                    WHERE AMOUNT>:amount];
        for(Opportunity opp:oppList){
            System.debug('Name: '+opp.name+' stage: '+opp.StageName+' close date : '+opp.CloseDate+' Amount : '+opp.Amount);
        } 
    }
    
    public static void displayOpportunityCount(String Stage){
        List<AggregateResult> oppList = [SELECT count(Id) Total,stageName FROM OPPORTUNITY
                                         WHERE stageName=:Stage
                                        GROUP BY stageName];
        for(AggregateResult opp:oppList){
            System.debug('Total: '+opp.get('Total')+' stage: '+opp.get('StageName'));
        } 
    }
    
    public static void displayOpportunity(String Stage, String Source){
        List<Opportunity> oppList = [SELECT Name, Amount, stageName, LeadSource FROM OPPORTUNITY
                                        WHERE stageName=:Stage AND LeadSource=:Source];
        for(Opportunity opp:oppList){
            System.debug('Name: '+opp.Name+' stage: '+opp.StageName+' Lead Source :'+opp.LeadSource);
        } 
    }
    
    public static void displayOpportunityWithLikeName(String strName){
        List<Opportunity> oppList = [SELECT Name, Amount, stageName FROM OPPORTUNITY
                                        WHERE Name LIKE :strName];
        for(Opportunity opp:oppList){
            System.debug('Name: '+opp.Name+' stage: '+opp.StageName);
        } 
    }
    
    public static void displayOpportunityTotalAmount(String Stage){
        List<AggregateResult> oppList = [SELECT count(Amount) Total_Amount,stageName FROM OPPORTUNITY
                                         WHERE stageName=:Stage
                                         GROUP BY stageName];
        for(AggregateResult opp:oppList){
            System.debug('Total Amount: '+opp.get('Total_Amount')+' stage: '+opp.get('StageName'));
        } 
    }
    
    public static void displayMaxSalaryForPosition(String Position){
		List<AggregateResult> emp = [SELECT max(Salary__c) Maximum_Salary,Position__c FROM Employee__c 
                                     WHERE position__c =: Position GROUP BY Position__c Having Max(Salary__c)>20000];
        if(emp.size()>0){
        		for(AggregateResult e:emp){
                    if(e.get('position__c')!=null){
            			System.debug('Maximum Salary: '+e.get('Maximum_Salary')+' Position: '+e.get('Position__c'));
        		} 
            }
        }
        else{
            System.debug('No records found with the required position');
		}
    }
    
    public static void displayMaxAndMinSalaryForPostion(String position){
        List<AggregateResult> emplist = [Select Max(Salary__c) Maximum_Salary, Min(Salary__c) Minimum_Salary, position__c
                                  From Employee__c
                                  Where Position__c =: position
                                  Group By position__c];
        if(emplist.size()>0){
            for(AggregateResult e:emplist){
                if(e.get('position__c')!=null){
                    System.debug('Maximum Salary: '+e.get('Maximum_Salary')+' Minimum Salary: '+e.get('Minimum_Salary')+' Position: '+e.get('Position__c'));
                }
            }
        }
        else{
            System.debug('No records found with the required position');
		}
    }
    
    public static void displayDepartmentWithMaximumEmployeeCount(){
        List<AggregateResult> deplist = [Select Count(Id) empCount,department__c, department__r.Name
                                        From Employee__c
                                        Where department__c!=null
                                        Group By department__c, department__r.Name
                                        Order By count(Id) Desc
                                        Limit 1];
        System.debug(deplist);
        if(deplist.size()>0){
            for(AggregateResult d:deplist){
            	Department__c depname = [Select name From Department__C Where id=:(string)d.get('department__c')];
                System.debug('employee count: '+d.get('empCount')+' Department Name: '+depname.name);
            }
        }
        else{
            System.debug('No records to display');
        }
        
    }
}