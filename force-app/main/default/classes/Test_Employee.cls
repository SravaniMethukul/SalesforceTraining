@isTest
public class Test_Employee {
    @TestSetUp
    public static void LoadData(){
        //check if employee is updated
        Employee__c emp4 = new Employee__c(Employee_Name__c='Sai update Test');
        insert emp4;
        
        //check delete employee
        Employee__c emp5 = new Employee__c(Employee_Name__c = 'Test to delete');
        insert emp5;
        
        //check max salary on position
        Employee__c emp6 = new Employee__C(Employee_Name__c='Rakesh Test Salary', Position__c='IT', Salary__c=70000);
        Employee__c emp7 = new Employee__C(Employee_Name__c='Sahana Test Salary', Position__c='IT', Salary__c=65000);
        Employee__c emp8 = new Employee__C(Employee_Name__c='Sravani Test Salary', Position__c='Finance', Salary__c=60000);
        List<Employee__c> emplist = new List<Employee__c>{emp6, emp7, emp8};
        insert emplist;
    }
    
    @isTest
    public static void insertEmployeeValidation(){
        //check employee insertion
        Employee__c emp = new Employee__c(Employee_Name__c='Rakesh', Position__c='Finance', Salary__c=75000);
        
        //check duplicate employee
        Employee__c emp1 = new Employee__C(Employee_Name__c='Rakesh', Position__c='IT', Salary__c=60000);
        
        //check if position is null then it is assigned as others
        Employee__c emp2 = new Employee__c(Employee_Name__c='Sahana', Salary__c=75000);
        
        //check if employee with salary greater than 80000 and department is not HR Department is not inserted
        Employee__c emp3 = new Employee__c(Employee_Name__c='Sravani Test 101', position__c='Finance', Salary__c=90000);
        
        Test.startTest();
        string returnvalue=Employee.insertEmployee(emp);
        string returnvalue1=Employee.insertEmployee(emp1);
        string returnvalue2=Employee.insertEmployee(emp2);
        string returnvalue3=Employee.insertEmployee(emp3);
        Test.stopTest();
        
        //check employee insertion
        List<Employee__C> duplicate_emp_inserted = [Select Employee_Name__c From Employee__c where Employee_Name__c='Rakesh'];
        assert.areequal(1, duplicate_emp_inserted.size(), 'more than 1 record for Employee Rakesh is present in org');
        assert.areequal(returnvalue1, 'Record with same name already exists', 'duplicate value created');
        
        //check duplicate employee
        List<Employee__C> emp_inserted = [Select Employee_Name__c, Position__c, Salary__c From Employee__c where Employee_Name__c='Rakesh'];
        assert.areequal(1, emp_inserted.size(), 'Employee Rakesh is not inserted');
        assert.areequal('Finance', emp_inserted[0].position__c, 'position is not correctly inserted');
        assert.areequal(75000, emp_inserted[0].salary__c, 'salary not inserted correctly');
        
		//check if position is null then it is assigned as others
        List<Employee__C> emp_inserted1 = [Select Employee_Name__c, Position__c From Employee__c where Employee_Name__c='Sahana'];
        assert.areequal(1, emp_inserted1.size(), 'Record is not inserted');
        assert.areequal('Others', emp_inserted1[0].position__c, 'Position is not assigned to others');
        assert.areequal(returnvalue2,'record inserted successfully','record is created with position others ');
        
        //check if employee with salary greater than 80000 and department is not HR Department is not inserted
        List<Employee__C> emp_inserted2 = [Select Employee_Name__c, Position__c From Employee__c where Employee_Name__c='Sravani Test 101'];
        System.debug(emp_inserted2);
        assert.areequal(0, emp_inserted2.size(), 'Record is inserted even though salary is greater 80000 and postion is not HR');
        assert.areequal(returnvalue3,null,'record is created with position other than HR and salary gretaer than 80000');
        
    }
    
    @isTest
    public static void updateEmployeeValidation(){
        
        List<Employee__c> emp = [Select Employee_Name__c, Position__c From Employee__c where Employee_Name__c='Sai update Test'];
            
        //check that record not updated without inserting
        Employee__c emp1= new Employee__c(Employee_Name__c='Not updated Test');
        
        Test.startTest();
        string returnvalue1=Employee.updateEmployee(emp[0]);
        string returnvalue2=Employee.updateEmployee(emp1);
        Test.stopTest();
        
        //check if the employee name is updated
        List<Employee__c> emp_updatedlist = [Select Employee_Name__c From Employee__c where Employee_Name__c = 'Test Updated'];
        assert.areequal(1, emp_updatedlist.size(), 'The Employee name is not updated' );
        assert.areequal('Test updated', emp_updatedlist[0].Employee_Name__c, 'The Employee name is not updated' );
        assert.areequal(returnvalue1,'record updated successfully','record is not updated');
        
        //check record is not updated for unexisting records
        assert.areequal(returnvalue2, 'Record does not exist to update', 'return exist to update');
    }
    
    @isTest
    public static void deleteEmployeeValidation(){
        
        List<Employee__c> emp = [Select Employee_Name__c, Position__c From Employee__c where Employee_Name__c='Test to delete'];
            
        //check that record not updated without inserting
        Employee__c emp1= new Employee__c(Employee_Name__c='Not updated Test');
        
        Test.startTest();
        string returnvalue1=Employee.deleteEmployee(emp[0]);
        string returnvalue2=Employee.deleteEmployee(emp1);
        Test.stopTest();
        
        //check if the employee is deleted
        List<Employee__c> emp_deletedlist = [Select Employee_Name__c From Employee__c where Employee_Name__c = 'Test to delete'];
        assert.areequal(0, emp_deletedlist.size(), 'The Employee is not deleted' );
        assert.areequal(returnvalue1, 'Record deleted Successfully', 'record not deleted');
        
        //check record is not deleted for unexisting record
        assert.areequal(returnvalue2,'No record exist to delete', 'return exist to delete');
    }
    
    @isTest
    public static void maxSalaryForPositionValidation(){
        Test.startTest();
        string returnvalue1=Employee.maxSalaryForPosition('IT');
        string returnvalue2=Employee.maxSalaryForPosition('Education');
        Test.stopTest();
        
        //check if the max salary is 70000 for IT position employee
        List<AggregateResult> emp_ITlist = [Select Max(Employee__c.salary__C) Maximum_Salary, Position__c From Employee__C
                                     Where Position__C='IT' Group By Position__c];
        assert.areequal(70000, (Decimal)emp_ITlist[0].get('Maximum_Salary'), 'Max salary of IT employee is not 70000');
        assert.areequal(returnvalue1, 'Max salary found successfully', 'record not found');
        
        //check if the position with specific position not present
        List<AggregateResult> emp_educationlist = [Select Max(Employee__c.salary__C) Maximum_Salary, Position__c From Employee__C
                                     Where Position__C='Education' Group By Position__c];
        assert.areequal(0, emp_educationlist.size(), 'records with education position are found');
        assert.areequal(returnvalue2, 'No records Found', 'record found');
    }
}