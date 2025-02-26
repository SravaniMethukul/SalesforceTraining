public class ATMCalculation {
    public static void calculation(){
        integer openingBalance = 200000;
        integer TransactionAmount=40000;
        System.debug('Opening Balance: ' + openingBalance);

        // Display ATM menu
        System.debug('ATM Menu:');
        System.debug('1 - Withdrawal');
        System.debug('2 - Deposit');
        
        integer userOption=1;
        if(userOption==1){
        	if(TransactionAmount<=OpeningBalance){
            	openingBalance=openingBalance-TransactionAmount;
        	}
            else{
            	System.debug('Insufficent Balance to withdraw');
            }
        }
        else if(userOption==2){
            openingBalance=openingBalance + TransactionAmount;
            System.debug('Deposit Succesfull');
        }
        else{
            System.debug('InValid Option');
        }
        System.debug('Balance In Account: '+openingBalance);
    }
}