public class OptionWrapper {
    public Option__c option { get; set; }
    public Boolean selected { get; set; }
    
    public OptionWrapper(Option__c optionsForTest){
        option = optionsForTest;
        selected = false;
    }

}