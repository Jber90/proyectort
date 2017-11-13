public class OrganigramaController {
    public List<Employee__c> headManager { get; set; }
    public List<Employee__c> projectManager { get; set; }
    public List<Employee__c> qaManager { get; set; }
    public List<Employee__c> resourcesManager { get; set; }
    public List<Employee__c> peManager { get; set; }
    public List<Employee__c> peopleExperience { get; set; }
    public List<Employee__c> financialManager { get; set; }
    public List<Employee__c> administracion { get; set; }
    public List<Employee__c> marketingManager { get; set; }
    public List<Employee__c> piManager { get; set; }
    public List<Employee__c> technicalAssistance { get; set; }
    public List<Employee__c> projects { get; set; }
    
    
    public OrganigramaController(){
        headManager = Utils.getEmployees('Head Manager');
        projectManager = Utils.getEmployees('Project Managers');
        qaManager = Utils.getEmployees('QA Manager');
        resourcesManager = Utils.getEmployees('Resources Manager');
        peManager = Utils.getEmployees('PE Manager');
        peopleExperience = Utils.getEmployees('People Experience');
        financialManager = Utils.getEmployees('Financial Manager');
        administracion = Utils.getEmployees('Administration');
        marketingManager = Utils.getEmployees('Marketing Manager');
        piManager = Utils.getEmployees('PI Analyst');
        technicalAssistance = Utils.getEmployees('Technical Assistance');
    }
    
}