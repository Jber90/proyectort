public class RankingController {
     public List<RankingWrapper> people {get;set;} 
    public Integer offsetSize = 0;
    public String role {get;set;} 
    public String seniority {get;set;} 
    public String showHideTable {get;set;}
    
    public RankingController(){
        people = new List<RankingWrapper>();
        showHideTable = 'display: none';
    }
    
    public void searchPeopleForRanking(){
        system.debug('searchPeopleForRanking');
        people = JSUtils.searchRanking(role, seniority);
        showHideTable = 'display: inline';
    }
    
    public Boolean getEmpty() { 
        return people.size() == 0;
    }
    
    public List<SelectOption> getRoleItems() {
        List<SelectOption> options = new List<SelectOption>();
        List<String> optionsString = new List<String>();
        AggregateResult[] roles = [SELECT Role__c 
                                   FROM Employee__c 
                                   GROUP BY Role__c];
        for (AggregateResult ar : roles)  {
            if(ar.get('Role__c') != null){
                options.add(new SelectOption(ar.get('Role__c')+'',ar.get('Role__c')+''));
                optionsString.add(ar.get('Role__c')+'');
            }
        }
        AggregateResult[] rolesCandidate = [SELECT Role__c 
                                            FROM Candidate__c
                                            WHERE Role__c NOT IN :optionsString
                                            GROUP BY Role__c];
        for (AggregateResult ar : rolesCandidate)  {
            if(ar.get('Role__c') != null){
                options.add(new SelectOption(ar.get('Role__c')+'',ar.get('Role__c')+''));
            }
        }
        return options;
    }
    
    public List<SelectOption> getSeniorityItems() {
        List<SelectOption> options = new List<SelectOption>();
        List<String> optionsString = new List<String>();
        AggregateResult[] seniorities = [SELECT Seniority__c 
                                         FROM Employee__c 
                                         GROUP BY Seniority__c];
        for (AggregateResult ar : seniorities)  {
            if(ar.get('Seniority__c') != null){
                options.add(new SelectOption(ar.get('Seniority__c')+'',ar.get('Seniority__c')+''));
                optionsString.add(ar.get('Seniority__c')+'');
            }
        }
        AggregateResult[] senioritiesCandidate = [SELECT Seniority__c 
                                            FROM Candidate__c
                                            WHERE Seniority__c NOT IN :optionsString
                                            GROUP BY Seniority__c];
        for (AggregateResult ar : senioritiesCandidate)  {
            if(ar.get('Seniority__c') != null){
                options.add(new SelectOption(ar.get('Seniority__c')+'',ar.get('Seniority__c')+''));
            }
        }
        
        return options;
    }

}