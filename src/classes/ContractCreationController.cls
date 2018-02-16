public class ContractCreationController {
    public String contratId = ApexPages.currentPage().getParameters().get('Id');
    public EmployeeContract__c contract = new EmployeeContract__c();
    
    
    public EmployeeContract__c getEmployeeContractInfo(){
        
        contract = [SELECT Id, Address__c, CI__c, FullName__c, Description__c, HoursOfWork__c , JobTitle__c, ProbationaryPeriod__c, Salary__c, StartDate__c  
                    FROM EmployeeContract__c WHERE Id=:contratId];
        return contract;
    }

}