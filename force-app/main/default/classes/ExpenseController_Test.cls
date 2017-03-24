/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an org are executed whenever Apex code is deployed
* to a production org to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production org. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the org size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest(SeeAllData=FALSE)
private class ExpenseController_Test {

    @testSetup
    static void setupMethod()
    {
        
        Expense__c expenseList = new Expense__c();
        
            expenseList.name = 'Raintree';
            expenseList.amount__c = 100;
            expenseList.client__c= 'ABC';
            expenseList.date__c = system.today();
            expenseList.reimbursed__c = false;
       
            system.debug(expenseList);
        
            INSERT expenseList;
    }

    @isTest
    static void TestExpense(){
        
        Expense__c expenseDataList = [SELECT id, name, amount__c, client__c, date__c,
                reimbursed__c, createdDate FROM Expense__c];

        expenseDataList.reimbursed__c = true;

        ExpenseController.getExpenses();

        Expense__c obj = ExpenseController.saveExpense(expenseDataList);

        system.assertEquals(false, obj.Reimbursed__c);
       
    }   

}