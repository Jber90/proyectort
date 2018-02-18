public class JSUtils {
    
    public static Integer DEFAULT_PAGE_SIZE = 10;
    public static Integer DEFAULT_PAGE_SIZE_RANKING = 50;
    public static Integer NUMBER_OF_QUESTIONS = 10;
    
    public static List<Project__c> getProjects(){
        return [SELECT Id, Name FROM Project__c 
                WHERE Active__c = true
                LIMIT 100];
    }

    
    public static List<Employee__c> getEmployees(String role){
        return [SELECT Id, Name, Imagen__c FROM Employee__c 
                WHERE Role__c = :role
                AND Status__c != 'Former Employee'
                LIMIT 10];
    }
    
    public static List<Employee__c> getEmployee(Integer ci){
        List<Employee__c> emp = new List<Employee__c>();
        emp = [SELECT Id, Name, Address__c, CI__c, CompanyStartDate__c  FROM Employee__c 
                WHERE CI__c = :ci
                LIMIT 1];
        return emp;
    }
    
    public static List<Candidate__c> getCandidate(Integer ci){
        return [SELECT Id, Name FROM Candidate__c 
                WHERE CI__c = :ci
                LIMIT 1];
    }
    
    public static Boolean checkIfContainsNumber(List<Integer> listNumbers, Integer numberToCheck){
        Boolean containNumber = false;
        for(Integer numberFromList : listNumbers){
            if(numberToCheck == numberFromList){
                containNumber = true;
            }
        }
        system.debug('containNumber: ' + containNumber);
        return containNumber;
    }
    
    public static List<Option__c> getOpciones(String technicalQuestionId){
        return [SELECT Id, Option_Text__c, anwser__c FROM Option__c 
                WHERE Techincal_Question__r.Id = :technicalQuestionId
                ORDER BY Option_Text__c
                LIMIT 1000];
    }
    
    public static List<Technical_Question__c> getTechnicalQuestions(String Technology, String Seniority, String Role){
        List<Technical_Question__c> questionsForTest = new List<Technical_Question__c>(); 
        List<Technical_Question__c> questions = [SELECT Id, Name, Technical_Question_Text__c FROM Technical_Question__c 
                                                 WHERE Seniority__c = :Seniority
                                                 AND Role__c = :Role
                                                 AND Technology__r.Name = :Technology LIMIT 1000];
        
        
        if(questions.size() > 0){
            
            List<Integer> randomNumbers = new List<Integer>();
            Integer numbersRandoms = 1;
            do {
                Double random = Math.floor(Math.random() * questions.size() + 1);
                Integer randomIn = random.intValue();
                system.debug('randomIn: ' + randomIn);
                if(!checkIfContainsNumber(randomNumbers, randomIn)){
                    randomNumbers.add(randomIn);
                    questionsForTest.add(questions.get(randomIn - 1));
                    numbersRandoms++;
                }
            } while (numbersRandoms <= NUMBER_OF_QUESTIONS);
            
        }
        return questionsForTest;
    }
    
    public static List<Employee__c> searchSkill(String skill, Integer limitSize, Integer offsetSize){
        String skillToSearch = '%' + skill + '%';
        return [SELECT Id, Name, Skills__c, Role__c, Location__c, Status__c FROM 
                Employee__c 
                WHERE Skills__c  LIKE :skillToSearch
                AND Status__c != 'Former Employee'
                LIMIT :limitSize
                OFFSET :offsetSize];
    }
    
    public static List<RankingWrapper> searchRanking(String role, String seniority){
        
        List<RankingWrapper> peopleRanked = new List<RankingWrapper>();
        List<RankingWrapper> auxPeopleRanked = new List<RankingWrapper>();
        
        List<Employee__c> employees = [SELECT Id, Name, Role__c, Seniority__c FROM Employee__c 
                                       WHERE (Status__c = 'Change: Role' OR  Status__c = 'Change: Project')
                                       AND Role_Change__c = :role
                                       LIMIT 1000]; 
        if(employees.size() > 0){
            for(Employee__c emp : employees){
                Decimal rankingNumberEmp = 0;
                String colorEmp = 'orange';
                peopleRanked.add(new RankingWrapper(emp.Name, emp.Id, emp.Role__c, emp.Seniority__c, colorEmp, rankingNumberEmp));
            }
        }
        if(peopleRanked.size() < DEFAULT_PAGE_SIZE_RANKING){
            for(Candidate__c candidate : [SELECT Id, Name, Role__c, Seniority__c, Skills__c FROM Candidate__c 
                                          WHERE Role__c = :role 
                                          AND Seniority__c = :seniority
                                          AND Actual_Workplace__c != 'Altimetrik'
                                          LIMIT 1000]){
                                              Decimal result = 0;
                                              Integer numberOfTest = 0;
                                              Decimal rankingNumber = 0;
                                              String color = 'black';
                                              for(Technical_Test__c test : [SELECT Id, Result__c FROM Technical_Test__c 
                                                                            WHERE Candidate__c = :candidate.Id LIMIT 1000] ){
                                                                                result = result + test.Result__c;
                                                                                numberOfTest++;
                                                                            }
                                              if(numberOfTest > 0){
                                                  rankingNumber = (result / numberOfTest).setScale(2);
                                              } 
                                              if(candidate.Skills__c.containsIgnoreCase('salesforse')){
                                                  color = 'skyblue';
                                              }
                                              if(candidate.Skills__c.containsIgnoreCase('mobile')){
                                                  color = 'green';
                                              }
                                              auxPeopleRanked.add(new RankingWrapper(candidate.Name, candidate.Id, candidate.Role__c, candidate.Seniority__c, color, rankingNumber));
                                              
                                          }
            
        }
        
        auxPeopleRanked.sort();
        peopleRanked.addAll(auxPeopleRanked);
        return peopleRanked;
    }
    
    public static void sendMail(Id address, String subject, String body, String signature, String footer) {
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setTargetObjectId(address);
        system.debug(address);
        mail.saveAsActivity = false;
        mail.setSubject(subject);
        String bodyemail = '<html><head></head><body>' + body +'<div><br/>' + signature +'<div><br/>' + '<footer>' + footer + '</footer></body></html>';
        mail.setHtmlBody(bodyemail);
        
        // Pass this email message to the built-in sendEmail method 
        // of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { mail });
        
        // Call a helper method to inspect the returned results
        inspectResults(results);
    }
    
    /**
* @description 
* @param results 
* @return
*/
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        
        // sendEmail returns an array of result objects.
        // Iterate through the list to inspect results. 
        // In this class, the methods send only one email, 
        // so we should have only one result.
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully.');
            }
            else {
                sendResult = false;
                System.debug('[Email] The following errors occurred: ' + res.getErrors());                 
            }
        }
        return sendResult;
    }
    
}