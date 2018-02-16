public class TechnicalController {
    public Integer ciCandidate {get;set;}
    public String showHideInput {get;set;} 
    public String showHideName {get;set;} 
    public String showHideResult {get;set;} 
    public String candidateName {get;set;} 
    public String questionText;
    public String showHide { get; set; }
    public String message { get; set; }
    public List<Technical_Question__c> questions = new List<Technical_Question__c>();
    public List<Option__c> opciones {get;set;} 
    public TechnicalTestWrapper question {get;set;}
    public Integer numberOfQuestion = 0;
    public Integer stringNumberOfQuestion = 1;
    public Map<Integer, List<OptionWrapper>> answers = new Map<Integer, List<OptionWrapper>>();
    public List<String> results {get;set;} 
    public String allTestResult {get;set;}
    public String role {get;set;} 
    public String seniority {get;set;} 
    public String technology {get;set;} 
    public Candidate__c candidate;
    
    public TechnicalController(){
        showHide = 'slds-hide';
        showHideInput = 'display: inline';
        showHideName = 'display: none';
        showHideResult = 'display: none';
        opciones = new List<Option__c>();
    }
    
    public void start(){
        List<Candidate__c> candidates = JSUtils.getCandidate(ciCandidate);
        system.debug('candidate: ' + candidates.size());
        if(candidates.size() > 0){
            showHide = 'slds-hide';
            candidate = candidates.get(0);
            candidateName = candidates.get(0).Name;
            questions = JSUtils.getTechnicalQuestions(technology, seniority, role);
            if(questions.size() > 0){
                showHide = 'slds-hide';
                showHideInput = 'display: none';
                showHideName = 'display: inline';
                showHideResult = 'display: none';
                questionText = stringNumberOfQuestion + '. ' + questions.get(numberOfQuestion).Technical_Question_Text__c;
                opciones = JSUtils.getOpciones(questions.get(numberOfQuestion).Id);
                question = new TechnicalTestWrapper(opciones,questionText);                
            } else {
                message = 'The options choose don\'t have a Test related';
                showHide = '';
            } 
        } else {
            system.debug('error');
            message = 'The candidate isn\'t in the system Let know to the administrator';
            showHide = '';
            
        }
        
    }
    
    public void checkResults(){
        if(!answers.containsKey(numberOfQuestion)){
            answers.put(numberOfQuestion, question.options);
        } 
        
        Integer corrects = 0;
        results = new List<String>();
        Map<Integer, String> allResults = new Map<Integer, String>();
        for (Integer key : answers.keySet()) {
            List<OptionWrapper> answerOptions = new List<OptionWrapper>();
            List<Option__c> listOptions = new List<Option__c>();
            answerOptions = answers.get(key);
            listOptions = JSUtils.getOpciones(questions.get(key).Id);
            Boolean allCorrect = true;
            Integer counter = 0;
            String answerOption = '';
            for(Option__c op : listOptions){
                if(answerOptions.get(counter).selected == true){
                    answerOption = 'correct';
                } else {
                    answerOption = 'incorrect';
                }
                if(!op.anwser__c.equalsIgnoreCase(answerOption)){
                    allCorrect = false;
                }
                counter++;
            }
            if(allCorrect){
                allResults.put(key, 'correct');  
                corrects++;
            } else {
                allResults.put(key, 'incorrect');  
            }
        }
        
        for(Integer i = 0; i < JSUtils.NUMBER_OF_QUESTIONS; i++){
            if(allResults.containsKey(i)){
                results.add(i+1 + ' - ' + allResults.get(i));
            } else{
                results.add(i+1 + ' - ' + 'incorrect');
            }
            
        }
        
        allTestResult = corrects + ' / '+ JSUtils.NUMBER_OF_QUESTIONS;
        String questionsIds = '';
        String allStringResults = '';
        for(Technical_Question__c ques : questions){
            questionsIds += ques.Id + ',';
        }
        for(String res : results){
            allStringResults += res + ',';
        }
        
        Technical_Test__c tt = new Technical_Test__c();
        tt.Answer__c = allStringResults;
        tt.Candidate__c = candidate.Id;
        tt.Result__c = corrects;
        tt.Techincal_Question__c = questionsIds;
        tt.Role__c = role;
        tt.Seniority__c = seniority;
        tt.Technology__c = technology;
        insert tt;
        
        showHideInput = 'display: none';
        showHideName = 'display: none';
        showHideResult = 'display: inline';
        
        sendEmail(allStringResults, allTestResult, tt.Id);
        
    }
    
    public void otherTest(){
        showHideInput = 'display: inline';
        showHideName = 'display: none';
        showHideResult = 'display: none';
        
    }
    
    public Boolean getDisablePrevious(){
        if(numberOfQuestion > 0){
            return false;
        }
        else return true;
    }
    
    public Boolean getDisableNext() {
        if(numberOfQuestion < questions.size() - 1){
            return false;
        }
        else return true;
    }
    
    public PageReference Previous() {
        answers.put(numberOfQuestion, question.options);
        numberOfQuestion -= 1;
        stringNumberOfQuestion--;
        questionText = stringNumberOfQuestion + '. ' + questions.get(numberOfQuestion).Technical_Question_Text__c;
        if(answers.containsKey(numberOfQuestion)){
            question = new TechnicalTestWrapper(answers.get(numberOfQuestion),questionText);
        } else {
            opciones = JSUtils.getOpciones(questions.get(numberOfQuestion).Id);
            question = new TechnicalTestWrapper(opciones,questionText);
        }
        return null;
    }
    
    public PageReference Next() {
        answers.put(numberOfQuestion, question.options);
        numberOfQuestion += 1;
        stringNumberOfQuestion++;
        questionText = stringNumberOfQuestion + '. ' + questions.get(numberOfQuestion).Technical_Question_Text__c;
        if(answers.containsKey(numberOfQuestion)){
            question = new TechnicalTestWrapper(answers.get(numberOfQuestion),questionText);
        } else {
            opciones = JSUtils.getOpciones(questions.get(numberOfQuestion).Id);
            question = new TechnicalTestWrapper(opciones,questionText);
        }
        return null;
    }
    
    public List<SelectOption> getRoleItems() {
        List<SelectOption> options = new List<SelectOption>();
        AggregateResult[] roles = [SELECT Role__c 
                                   FROM Technical_Question__c 
                                   GROUP BY Role__c];
        for (AggregateResult ar : roles)  {
            options.add(new SelectOption(ar.get('Role__c')+'',ar.get('Role__c')+''));
        }
        return options;
    }
    
    public List<SelectOption> getSeniorityItems() {
        List<SelectOption> options = new List<SelectOption>();
        AggregateResult[] seniorities = [SELECT Seniority__c 
                                         FROM Technical_Question__c 
                                         GROUP BY Seniority__c];
        for (AggregateResult ar : seniorities)  {
            options.add(new SelectOption(ar.get('Seniority__c')+'',ar.get('Seniority__c')+''));
        }
        return options;
    }
    
    public List<SelectOption> getTechnologyItems() {
        List<SelectOption> options = new List<SelectOption>();
        AggregateResult[] technologies = [SELECT Technology__r.Name 
                                          FROM Technical_Question__c 
                                          GROUP BY Technology__r.Name];
        for (AggregateResult ar : technologies)  {
            options.add(new SelectOption(ar.get('Name')+'',ar.get('Name')+''));
        }
        return options;
    }
    
    public void sendEmail(String Result, String ResultTotals, String TestId){
        String subject = 'Candidate ' + candidate.Name + ' finished Technical Test';
        String body = '';
        if(UserInfo.getFirstName() != null){
            body = '<p>Hello '+UserInfo.getFirstName()+',</p>';
        }else{
            body = '<p>Hello '+UserInfo.getLastName()+',</p>';
        }  
        body += '<div>These are ' + candidate.Name + ' results:</div><br>';
        body += '<div>'+ Result.replaceAll(',', '<br>') +'</div><br>';
        body += '<div>'+ ResultTotals +'</div><br>';
        String url =  ApexPages.currentPage().getUrl();
        if(url != null){ 
            List<String> parts = url.split('%2F%2F');
            List<String> part2 = parts[1].split('&technical');
            String urlCandidate = '/one/one.app#/sObject/'+ candidate.Id +'/view';
            String urlTest = '/one/one.app#/sObject/'+ TestId +'/view';
            body += '<div><a href="'+ part2[0] + urlCandidate + '">Candidate Info</a></div><br>';
            body += '<div><a href="'+ part2[0] + urlTest + '">Test Info</a></div><br>';
        } 
        String signature = 'Automatic email';
        String footer = '';
        
        JSUtils.sendMail(UserInfo.getUserId(), subject, body, signature, footer); 
    }
    
}