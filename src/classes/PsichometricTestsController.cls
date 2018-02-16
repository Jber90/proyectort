public class PsichometricTestsController {
    
    public List<String> testsUrl = new List<String>();
    public String candidateId = ApexPages.currentPage().getParameters().get('Id');
    public Candidate__c candidate;
    
    public PsichometricTestsController(){
        loadTestsUrl();   
    }
    
    private void loadTestsUrl(){
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000JcSg?asPdf=false&operationContext=CHATTER');
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000Jcbi?asPdf=false&operationContext=CHATTER');
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000Jcbe?asPdf=false&operationContext=CHATTER');
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000JcbY?asPdf=false&operationContext=CHATTER');
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000Jcbd?asPdf=false&operationContext=CHATTER');
        testsUrl.add('/sfc/servlet.shepherd/version/download/0681I000000JcbZ?asPdf=false&operationContext=CHATTER');
    }
    
    public Candidate__c getCandidateInfo(){
        candidate = [SELECT Name, Role__c FROM Candidate__c WHERE Id=:candidateId];
        return candidate;
    }
    
    public String getActualDate(){
        DateTime dt = Date.today();
        String dtStr = dt.format('dd/MM/yyyy');
        return dtStr;
    }
    
    public List<String> getTests(){
        List<Integer> positionsSelected = new List<Integer>();
        List<String> testToShow = new List<String>();
        while(positionsSelected.size() < 3){
            Integer randomPosition = getRandomNumber();
            boolean isOnList = false;
            for(Integer i : positionsSelected){
                if(i == randomPosition){
                    isOnList = true;
                }
            }
            if(isOnList == false){
                positionsSelected.add(randomPosition);
                testToShow.add(testsUrl.get(randomPosition));
            }
        }
        return testToShow;
    }
    
    private Integer getRandomNumber(){
        Double d = math.random() * testsUrl.size();
        return d.intValue();
    }

}