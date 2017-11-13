public class Utils {
    
    public static List<Employee__c> getEmployees(String role){
        return [SELECT Id, Name FROM Employee__c where Role__c = : role LIMIT 10];
    }
}