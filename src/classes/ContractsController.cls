public class ContractsController { 
    
    public String showHide { get{
        return 'slds-hide';
    } set;}
    public String name {get;set;}
    public Integer employee {get;set;}
    public Decimal ci {get;set;}
    public String address {get;set;}
    public Date startDate{ get{
        if(startDate==null){
            startDate = Date.today();
        }
        return startDate;
    } set;}
    public String jobTitle {get;set;}
    public String description {get;set;}
    public Decimal hoursOfWork {get;set;}
    public Decimal probationaryPeriod {get;set;}
    public Decimal salary {get;set;}
    public Id employeeId;
    
    
    public void saveContract(){
        if(name != '' && address != '' ){
            EmployeeContract__c contract = new EmployeeContract__c();
            contract.CI__c = ci;
            contract.FullName__c  = name;
            contract.StartDate__c  = startDate;
            contract.Description__c =  description;
            contract.Address__c  = address;
            contract.JobTitle__c  = jobTitle;
            contract.HoursOfWork__c  = hoursOfWork;
            contract.ProbationaryPeriod__c  = probationaryPeriod;
            contract.Salary__c  = salary;
            contract.Employee__c = employeeId;
            insert contract;
            
        }
    }
    
    public void searchEmployee(){
        if(employee != null && employee > 0){
            List<Employee__c> employeeData = JSUtils.getEmployee(employee);
            system.debug('employeeData');
            system.debug(employeeData);
            if(employeeData.size() > 0){
                ci = employeeData[0].CI__c;
                address = employeeData[0].Address__c;
                startDate = employeeData[0].CompanyStartDate__c;
                name = employeeData[0].Name;
                employeeId = employeeData[0].Id;
                hoursOfWork  = 9;
                probationaryPeriod = 3;
                salary = 25000;
            }
        }
        
        
    }
    
}