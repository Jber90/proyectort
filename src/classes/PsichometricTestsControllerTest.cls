@isTest
public class PsichometricTestsControllerTest {
    
    @testSetup
    static void setupData(){
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
    static void testGetCandidateInfo(){
        Candidate__c c = [SELECT Id FROM Candidate__c WHERE Name = 'Test Candidate'];
        
        Test.startTest();
        PsichometricTestsController controller = new PsichometricTestsController();
        controller.candidateId = c.Id;
        Candidate__c fromServer = controller.getCandidateInfo();
        Test.stopTest();
        
        System.assertEquals('Test Candidate', fromServer.Name);
    }
    
    @isTest
    static void testGetActualDate(){
        Test.startTest();
        PsichometricTestsController controller = new PsichometricTestsController();
        String dateFromServer = controller.getActualDate();
        Test.stopTest();
        
        DateTime dt = Date.today();
        String dtStr = dt.format('dd/MM/yyyy');
        
        System.assertEquals(dtStr, dateFromServer);
    }
    
    @isTest
    static void testGetTests(){
        Test.startTest();
        PsichometricTestsController controller = new PsichometricTestsController();
        List<String> tests = controller.getTests();
        Test.stopTest();
        
        System.assertEquals(3, tests.size());
    }
    
    
    

}