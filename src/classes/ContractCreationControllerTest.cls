@isTest
public class ContractCreationControllerTest {
    
    @isTest 
    static void testCreateContract() {
        Test.startTest();
        //setup
        DateTime dT = System.now();
        Date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
        EmployeeContract__c employeeContract = new EmployeeContract__c(Address__c = 'Something', CI__c = 22222222, FullName__c = 'Taylor Swift', StartDate__c = myDate);
        insert employeeContract;
        //end setup
        
        ContractCreationController controller = new ContractCreationController();
        controller.contratId = employeeContract.Id;
        controller.getEmployeeContractInfo();
        Test.stopTest();
        
        System.assertEquals('Taylor Swift', controller.contract.FullName__c);
    }

}