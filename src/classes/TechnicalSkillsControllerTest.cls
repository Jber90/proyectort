@isTest
public class TechnicalSkillsControllerTest {
    @isTest 
    static void testSearchSkill() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Head Manager', CI__c = 11111111, Skills__c  = 'HTML5');
        Employee__c employee2 = new Employee__c(Role__c ='Head Manager', CI__c = 22222222, Skills__c  = 'HTML5');
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        Test.stopTest();
        
        TechnicalSkillsController controller = new TechnicalSkillsController();
        string a = controller.showHideTable;
        controller.searchSkill = 'HTML5';
        controller.searchSkill();
        
        System.assertEquals(2, controller.employees.size());
        System.assertEquals(false, controller.getEmpty());
        System.assertEquals(true, controller.getDisableNext());
        System.assertEquals(true, controller.getDisablePrevious());
        controller.Next();
        controller.Previous();
        controller.clear();
        
        System.assertEquals(0, controller.employees.size());
        System.assertEquals(true, controller.getEmpty());
        
        
    }

}