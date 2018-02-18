trigger updateEmpStatus on Project_Team_Member__c (after insert) {
    
    List<Id> employeesId = new List<Id>();
    for(Project_Team_Member__c ptm : Trigger.New){
        employeesId.add(ptm.Employee__c);
    }
    
    List<Employee__c> employees = new List<Employee__c>([SELECT Id, Status__c FROM Employee__c WHERE Employee__c.Id in: employeesId]);
    
    if(employees.size() > 0){
        for(Employee__c emp : employees){
            emp.Status__c = 'Project';
        }
    }
    
    update employees;
}