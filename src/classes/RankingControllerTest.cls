@isTest
public class RankingControllerTest {
    @isTest 
    static void testRankingSetUp() {
        Test.startTest();
        //setup
        List<Candidate__c> candidates = new List<Candidate__c>();
        Candidate__c candidate = new Candidate__c(Role__c ='QA', CI__c = 11111111, Seniority__c = 'Junior', Skills__c = 'Something');
        Candidate__c candidate2 = new Candidate__c(Role__c ='Developer', CI__c = 22222222, Seniority__c = 'Junior', Skills__c = 'Something');
        Candidate__c candidate3 = new Candidate__c(Role__c ='Developer', CI__c = 33333333, Seniority__c = 'Junior', Skills__c = 'Something');
        candidates.add(candidate);
        candidates.add(candidate2);
        candidates.add(candidate3);
        insert candidates;
        
        List<Employee__c> employees = new List<Employee__c>();
        Employee__c employee = new Employee__c(Role__c ='QA', CI__c = 44444444, Seniority__c = 'Senior');
        Employee__c employee2 = new Employee__c(Role__c ='Head Manager', CI__c = 55555555, Seniority__c = 'Senior');
        employees.add(employee);
        employees.add(employee2);
        insert employees;
        //end setup
        
        RankingController controller = new RankingController();
        controller.getRoleItems();
        controller.getSeniorityItems();
        System.assertEquals(true, controller.getEmpty());
        controller.role = 'Developer';
        controller.seniority = 'Junior';
        controller.searchPeopleForRanking();
        
        Test.stopTest();
        
        System.assertEquals(2, controller.people.size());
        System.assertEquals(false, controller.getEmpty());
        
    }

}