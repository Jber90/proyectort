@isTest
public class OrganigramaControllerTest {

    @isTest 
    static void testHeadManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Head Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Head Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.headManager.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testProjectManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Project Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Project Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.projectManager.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testQaManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='QA Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='QA Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.qaManager.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testResourcesManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Resources Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Resources Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.resourcesManager.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testPeManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='PE Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='PE Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.peManager.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testPeopleExperience() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='People Experience', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='People Experience', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.peopleExperience.size());
        System.assertEquals(0, controller.financialManager.size());
    }
    
    @isTest 
    static void testFinancialManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Financial Manager', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Financial Manager', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.financialManager.size());
        System.assertEquals(0, controller.peopleExperience.size());
    }
    
    @isTest 
    static void testAdministracion() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Administration', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Administration', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.administracion.size());
        System.assertEquals(0, controller.peopleExperience.size());
    }
    
    @isTest 
    static void testMarketingManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Marketing Manager', CI__c = 22222222);
        Employee__c employee2 = new Employee__c(Role__c ='Marketing Manager', CI__c = 11111111);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.marketingManager.size());
        System.assertEquals(0, controller.peopleExperience.size());
    }
    
    @isTest 
    static void testPiManager() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='PI Analyst', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='PI Analyst', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.piAnalyst.size());
        System.assertEquals(0, controller.peopleExperience.size());
    }
    
    @isTest 
    static void testTechnicalAssistance() {
        Test.startTest();
        //setup
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='Technical Assistance', CI__c = 11111111);
        Employee__c employee2 = new Employee__c(Role__c ='Technical Assistance', CI__c = 22222222);
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        OrganigramaController controller = new OrganigramaController();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.technicalAssistance.size());
        System.assertEquals(0, controller.peopleExperience.size());
    }

}