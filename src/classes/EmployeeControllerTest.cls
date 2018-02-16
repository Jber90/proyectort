@isTest
public class EmployeeControllerTest {

    @testSetup
    static void setupData(){
        Employee__c e = new Employee__c();
        e.Name = 'Test Tester';
        e.CI__c = 00000000;
        e.Role__c = 'Developer';
        e.Skills__c = 'Test Skills';
        insert e;
        
        Project__c p = new Project__c();
        p.Name = 'Test Project';
        p.Client__c = 'Test Client';
        insert p;
        
        Project__c p2 = new Project__c();
        p2.Name = 'Test Project 2';
        p2.Client__c = 'Test Client 2';
        insert p2;
        
        Project_Team_Member__c ptm = new Project_Team_Member__c();
        ptm.Employee__c = e.Id;
        ptm.Project__c = p.Id;
        ptm.Role__c = 'Developer';
        insert ptm;
        
        Candidate__c c = new Candidate__c();
        c.Actual_Workplace__c = 'Test';
        c.CI__c = 11111111;
        c.Name = 'Test Candidate';
        c.Role__c = 'Developer';
        c.Seniority__c = 'Junior';
        c.Skills__c = 'Test Skills';
        insert c;
    }
    
    @isTest
    static void terminateEmployeeFired(){
        Employee__c emp = [SELECT Id FROM Employee__c WHERE Name = 'Test Tester'];
        Id empId = emp.Id;
        
       	Test.startTest();
        EmployeeController.updateTerminateEmployee(empId, 'Fired');
        Test.stopTest();
        
        Employee__c employee = [SELECT Id, DepartureDate__c, DepartureReason__c, Name, Status__c FROM Employee__c WHERE Id =: empId];
        
        System.assertEquals(Date.Today(), employee.DepartureDate__c);
        System.assertEquals('Fired', employee.DepartureReason__c);
        System.assertEquals('Test Tester (Former Employee)', employee.Name);
        System.assertEquals('Former Employee', employee.Status__c);
        
    }
    
    @isTest
    static void terminateEmployeeQuit(){
        Employee__c emp = [SELECT Id FROM Employee__c WHERE Name = 'Test Tester'];
        Id empId = emp.Id;
        
       	Test.startTest();
        EmployeeController.updateTerminateEmployee(empId, 'Quit');
        Test.stopTest();
        
        Employee__c employee = [SELECT Id, DepartureDate__c, DepartureReason__c, Name, Status__c FROM Employee__c WHERE Id =: empId];
        
        List<Project_Team_Member__c> ptms = [SELECT Id FROM Project_Team_Member__c WHERE Employee__c =: empId];
        
        System.assertEquals(Date.Today(), employee.DepartureDate__c);
        System.assertEquals('Quit', employee.DepartureReason__c);
        System.assertEquals('Test Tester (Former Employee)', employee.Name);
        System.assertEquals('Former Employee', employee.Status__c);
        System.assertEquals(0, ptms.size());
        
    }
    
    @isTest
    static void testConvertCandidateToEmployeeNoProject(){
        Candidate__c c = [SELECT Id, Name, Actual_Workplace__c, Role__c, Seniority__c FROM Candidate__c WHERE Name = 'Test Candidate'];
        
        String startDate = '2018-02-02';
        String location = 'Torre 1';
        String status = 'Bench';
        String project = null;
        
        Test.startTest();
        Integer returnFromServer = EmployeeController.convertCandidateToEmployee(c.Id, startDate, location, status, project);
        Test.stopTest();
        
        Employee__c newEmp = [SELECT Id, Name, CI__c, Role__c, Seniority__c, Location__c, CompanyStartDate__c, Status__c FROM Employee__c WHERE Name = 'Test Candidate'];
        Candidate__c updatedCand = [SELECT Name, Actual_Workplace__c FROM Candidate__c WHERE Name LIKE 'Test Candidate%'];
        
        System.assertEquals(0, returnFromServer);
        System.assertEquals('Test Candidate', newEmp.Name);
        System.assertEquals(11111111, newEmp.CI__c);
        System.assertEquals('Developer', newEmp.Role__c);
        System.assertEquals('Junior', newEmp.Seniority__c);
        System.assertEquals('Torre 1', newEmp.Location__c);
        System.assertEquals('Bench', newEmp.Status__c);
        System.assertEquals(Date.valueOf('2018-02-02'), newEmp.CompanyStartDate__c);
        System.assertEquals('Test Candidate - (Converted to Employee)', updatedCand.Name);
        System.assertEquals('Altimetrik', updatedCand.Actual_Workplace__c);
        
    }
    
    @isTest
    static void testConvertCandidateToEmployeeErrorTwo(){
        Candidate__c c = [SELECT Id, Name, Actual_Workplace__c, Role__c, Seniority__c FROM Candidate__c WHERE Name = 'Test Candidate'];
        c.Name += ' - (Converted to Employee)';
        update c;
        
        String startDate = '2018-02-02';
        String location = 'Torre 1';
        String status = 'Bench';
        String project = null;
        
        Test.startTest();
        Integer returnFromServer = EmployeeController.convertCandidateToEmployee(c.Id, startDate, location, status, project);
        Test.stopTest();
        
        System.assertEquals(2, returnFromServer);
    }
    
    @isTest
    static void testConvertCandidateToEmployeeWithProject(){
        Candidate__c c = [SELECT Id, Name, Actual_Workplace__c, Role__c, Seniority__c FROM Candidate__c WHERE Name = 'Test Candidate'];
        Project__c p = [SELECT Id, Name FROM Project__c WHERE Name = 'Test Project'];
        
        String startDate = '2018-02-02';
        String location = 'Torre 1';
        String status = 'Project';
        String project = 'Test Project';
        
        Test.startTest();
        Integer returnFromServer = EmployeeController.convertCandidateToEmployee(c.Id, startDate, location, status, project);
        Test.stopTest();
        
        Employee__c newEmp = [SELECT Id, Name, CI__c, Role__c, Seniority__c, Location__c, CompanyStartDate__c, Status__c FROM Employee__c WHERE Name = 'Test Candidate'];
        Candidate__c updatedCand = [SELECT Name, Actual_Workplace__c FROM Candidate__c WHERE Name LIKE 'Test Candidate%'];
        Project_Team_Member__c ptm = [SELECT Id, Project__c, Employee__c FROM Project_Team_Member__C WHERE Employee__c =: newEmp.Id];
        
        System.assertEquals(0, returnFromServer);
        System.assertEquals('Test Candidate', newEmp.Name);
        System.assertEquals(11111111, newEmp.CI__c);
        System.assertEquals('Developer', newEmp.Role__c);
        System.assertEquals('Junior', newEmp.Seniority__c);
        System.assertEquals('Torre 1', newEmp.Location__c);
        System.assertEquals('Project', newEmp.Status__c);
        System.assertEquals(Date.valueOf('2018-02-02'), newEmp.CompanyStartDate__c);
        System.assertEquals('Test Candidate - (Converted to Employee)', updatedCand.Name);
        System.assertEquals('Altimetrik', updatedCand.Actual_Workplace__c);
        System.assertEquals(p.Id, ptm.Project__c);
        System.assertEquals(newEmp.Id, ptm.Employee__c);
        
    }
    
    @isTest
    static void testGetProjects(){
        Test.startTest();
        List<Project__c> projects = EmployeeController.getProjects();
        Test.stopTest();
        
        System.assertEquals('Test Project', projects[0].Name);
        System.assertEquals('Test Project 2', projects[1].Name);
        
    }
}