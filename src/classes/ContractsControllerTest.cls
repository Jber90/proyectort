@isTest
public class ContractsControllerTest {
    
    @isTest 
    static void testSearch() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Head Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Head Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        Test.stopTest();
        
        ContractsController controller = new ContractsController();
        string a = controller.showHide;
        controller.employee = 11111111;
        controller.searchEmployee();
        
        System.assertEquals(employee.CI__c, controller.ci);
    }
    
     @isTest 
    static void testSave() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Head Manager', CI__c = 11111111, Address__c = 'AAA');
        Employee__c employee2 = new Employee__c(Role__c ='Head Manager', CI__c = 22222222, Address__c = 'AAA');
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        //
        ContractsController controller = new ContractsController();
        controller.employee = 22222222;
        controller.searchEmployee();
        controller.name = 'Ayessa';
        controller.jobTitle = 'Designer';
        controller.description = 'Something';
        controller.hoursOfWork = 9;
        controller.saveContract();
        
        Test.stopTest();
        
        List<EmployeeContract__c> contracts = [SELECT Id FROM EmployeeContract__c];
        
        System.assertEquals(1, contracts.size());
    }
    
}