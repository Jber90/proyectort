public class TechnicalSkillsController {
    public List<Employee__c > employees {get;set;} 
    public String searchSkill {get;set;} 
    public Integer offsetSize = 0;
    public String showHideTable {get;set;} 
    
    public TechnicalSkillsController(){
        employees = new List<Employee__c >();
        showHideTable = 'display: none';
    }
    
    public void searchSkill(){
        employees = JSUtils.searchSkill(searchSkill, JSUtils.DEFAULT_PAGE_SIZE, offsetSize); 
        showHideTable = 'display: inline';
    } 
    
    public void clear(){
        searchSkill = '';
        employees.clear();
        showHideTable = 'display: none';
    } 
    
    public Boolean getDisablePrevious(){
        if(offsetSize >0){
            return false;
        }
        else return true;
    }
    
    public Boolean getDisableNext() {
        if(JSUtils.searchSkill(searchSkill, JSUtils.DEFAULT_PAGE_SIZE, offsetSize + JSUtils.DEFAULT_PAGE_SIZE).size() >0){
            return false;
        }
        else return true;
    }
    
    public PageReference Previous() {
        offsetSize -= JSUtils.DEFAULT_PAGE_SIZE;
        searchSkill();
        return null;
    }
    
    public PageReference Next() {
        offsetSize += JSUtils.DEFAULT_PAGE_SIZE;
        searchSkill();
        return null;
    }
    
    public Boolean getEmpty() { 
        return employees.size() == 0;
    }
    
    
}