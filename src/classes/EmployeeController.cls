public with sharing class EmployeeController {
    
    @AuraEnabled
    public static void updateTerminateEmployee(String empId, String option){
        Employee__c emp = [SELECT Id, Name, DepartureDate__c, DepartureReason__c, Status__c FROM Employee__c WHERE Id=:empId];
        if(emp.Status__c != 'Former Employee'){
        	emp.DepartureDate__c = Date.Today();
           	emp.DepartureReason__c = option;
            emp.Name = emp.Name + ' (Former Employee)';
            emp.Status__c = 'Former Employee';
            unlinkEmployeeFromProject(emp);
            update emp;
        }
    }
    
    private static void unlinkEmployeeFromProject(Employee__c emp){
        
        List<Project_Team_Member__c> ptmRecords = [SELECT Id, Employee__r.Id, Project__r.Id FROM Project_Team_Member__c WHERE Employee__r.Id =: emp.Id];
        try{
            delete ptmRecords;
        }catch(DmlException e){
            System.debug('Unknown error while deleting Project_Team_Member__c record.');
        }
        
    }
    
    @AuraEnabled
    public static Integer convertCandidateToEmployee(String candidateId, String startDate, String location, String status, String project){
        //returns: 0 - all good, 1 - error, 2 - already converted
        Candidate__c candidate = [SELECT Name, Birthdate__c, CI__c, Role__c, Seniority__c, Skills__c, Languages__c FROM Candidate__c WHERE Id =: candidateId];
        if(candidate.Name.contains('- (Converted to Employee)')) return 2;
        Employee__c newEmployee = new Employee__c();
        newEmployee.Name = candidate.Name;
        newEmployee.Birthdate__c = candidate.Birthdate__c;
        newEmployee.CI__c = candidate.CI__c;
        newEmployee.Role__c = candidate.Role__c;
        newEmployee.Seniority__c = candidate.Seniority__c;
        newEmployee.Skills__c = candidate.Skills__c;
        newEmployee.CompanyStartDate__c = convertDate(startDate);
        newEmployee.Location__c = location;
        newEmployee.Status__c = status;
        newEmployee.Languages__c = candidate.Languages__c;
        
        Database.SaveResult insRslt = Database.insert(newEmployee);
        if(insRslt.isSuccess()){
            candidate.Name = candidate.Name + ' - (Converted to Employee)';
            candidate.Actual_Workplace__c = 'Altimetrik';
            update candidate;
            if(project != null){
                createNewPTM(project, newEmployee);
            }
            return 0;
        }else{
            System.debug('Error while converting a Candidate to Employee');
            return 1;
        }
    }
    
    private static void createNewPTM(String projectName, Employee__c employee){
        Project__c project = [SELECT Id FROM Project__c WHERE Name =: projectName];
        
        Project_Team_Member__c ptm = new Project_Team_Member__c();
        ptm.Employee__c = employee.Id;
        ptm.Project__c = project.Id;
        ptm.Role__c = employee.Role__c;
        insert ptm;
    }
    
    @AuraEnabled
    public static List<Project__c> getProjects(){
        List<Project__c> projects = [SELECT Id, Name FROM Project__c ORDER BY Name];
        return projects;
    }
    
    private static Date convertDate(String dateString){
        return Date.valueOf(dateString);
    }

}