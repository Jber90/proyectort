@isTest
public class TechnicalControllerTest {
    
    @isTest 
    static void testSearch() {
        Test.startTest();
        //setup
        List<Technology__c> technologies  = new List<Technology__c >();
        Technology__c technology1 = new Technology__c(Name = 'Java');
        Technology__c technology2 = new Technology__c(Name = 'C#');
        technologies.add(technology1);
        technologies.add(technology2);
        insert technologies;
        
        List<Technical_Question__c> technicalQuestions = new List<Technical_Question__c>();
        List<Option__c> options = new List<Option__c>();
        Technical_Question__c technicalQuestions2 = new Technical_Question__c(Technical_Question_Text__c  ='Something', Role__c = 'QA', Seniority__c = 'Junior', Technology__c = technology1.Id);
        technicalQuestions.add(technicalQuestions2);
        
        for(Integer i = 1; i <= 10; i++){
            Technical_Question__c technicalQuestions1 = new Technical_Question__c(Technical_Question_Text__c  ='Something' + i, Role__c = 'Developer', Seniority__c = 'Senior', Technology__c = technology2.Id);
            technicalQuestions.add(technicalQuestions1);
        }
        
        insert technicalQuestions;
        
        for(Technical_Question__c tq : technicalQuestions){
            Option__c option1 = new Option__c(Techincal_Question__c = tq.Id, anwser__c = 'Correct', Option_Text__c = '1' );
            Option__c option2 = new Option__c(Techincal_Question__c  = tq.Id, anwser__c = 'Incorrect', Option_Text__c = '2' );
            Option__c option3 = new Option__c(Techincal_Question__c = tq.Id, anwser__c = 'Incorrect', Option_Text__c = '3' );
            Option__c option4 = new Option__c(Techincal_Question__c  = tq.Id, anwser__c = 'Incorrect', Option_Text__c = '4' );
            
            options.add(option1);
            options.add(option2);
            options.add(option3);
            options.add(option4);
        }
        
        insert options;
        
        List<Candidate__c> candidates = new List<Candidate__c>();
        Candidate__c candidate = new Candidate__c(Role__c ='QA', CI__c = 11111111, Seniority__c = 'Junior', Skills__c = 'Something');
        Candidate__c candidate2 = new Candidate__c(Role__c ='Developer', CI__c = 22222222, Seniority__c = 'Junior', Skills__c = 'Something');
        Candidate__c candidate3 = new Candidate__c(Role__c ='Developer', CI__c = 33333333, Seniority__c = 'Junior', Skills__c = 'Something');
        candidates.add(candidate);
        candidates.add(candidate2);
        candidates.add(candidate3);
        insert candidates;
        
        
        //end setup
        Test.stopTest();
        
        TechnicalController controller = new TechnicalController();
        controller.getRoleItems();
        controller.getSeniorityItems();
        controller.getTechnologyItems();
        controller.ciCandidate = 11111111;
        controller.role = 'Developer';
        controller.seniority = 'Senior';
    	controller.technology = 'C#';
        
        controller.start();
		System.assertEquals(JSUtils.NUMBER_OF_QUESTIONS, controller.questions.size());
        controller.Next();
        controller.Previous();
        System.assertEquals(true, controller.getDisablePrevious());
        System.assertEquals(false, controller.getDisableNext());
        controller.checkResults();
        
        List<Technical_Test__c> technicalTest = [SELECT Id FROM Technical_Test__c];
        
        System.assertEquals(1, technicalTest.size());
        
        controller.otherTest();
        System.assertEquals('display: none', controller.showHideName);
        
    }

}