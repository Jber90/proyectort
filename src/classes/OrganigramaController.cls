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
    public List<Employee__c> piAnalyst { get; set; }
    public List<Employee__c> technicalAssistance { get; set; }
    public List<Employee__c> teamLeader { get; set; }
    public List<Employee__c> qALead { get; set; }
    public List<Employee__c> qA { get; set; }
    public List<Employee__c> architect { get; set; }
    public List<Employee__c> developer { get; set; }
    public List<Employee__c> designer { get; set; }
    public List<Project__c> projects { get; set; }
    
    
    public OrganigramaController(){
        headManager = JSUtils.getEmployees('Head Manager');
        projectManager = JSUtils.getEmployees('Project Manager');
        qaManager = JSUtils.getEmployees('QA Manager');
        resourcesManager = JSUtils.getEmployees('Resources Manager');
        peManager = JSUtils.getEmployees('PE Manager');
        peopleExperience = JSUtils.getEmployees('People Experience');
        financialManager = JSUtils.getEmployees('Financial Manager');
        administracion = JSUtils.getEmployees('Administration');
        marketingManager = JSUtils.getEmployees('Marketing Manager');
        piAnalyst = JSUtils.getEmployees('PI Analyst');
        technicalAssistance = JSUtils.getEmployees('Technical Assistance');
        teamLeader = JSUtils.getEmployees('Team Leader');
        qALead = JSUtils.getEmployees('QA Lead');
        qA = JSUtils.getEmployees('QA');
        architect = JSUtils.getEmployees('Architect');
        developer = JSUtils.getEmployees('Developer');
    	designer = JSUtils.getEmployees('Designer');
        projects = JSUtils.getProjects();
    }
    
}