public class TechnicalTestWrapper {
    public String questionText { get; set; }
    public List<OptionWrapper> options { get; set; }
    
    public TechnicalTestWrapper(List<Option__c> optionsForTest, String question){
        options = new List<OptionWrapper>();
        questionText = question.replaceAll('\n', '<br/>');
        if(optionsForTest.size() > 0){
            for(Option__c option :optionsForTest){
                options.add(new OptionWrapper(option));
            }
        }     
    }
   
    public TechnicalTestWrapper(List<OptionWrapper> optionsForTest, String question){
        options = new List<OptionWrapper>();
        questionText = question.replaceAll('\n', '<br/>');
        options =  optionsForTest;
    }
    
}