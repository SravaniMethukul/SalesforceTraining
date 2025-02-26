public class ListDemo {
    List<integer> lst = new List<integer>{20, 50, 60, 100, 45};
    public void biggestNum(){
    	integer bignum = 0;
        for(integer num:lst){
            if(num>bignum)
            	bignum=num;
        }
        System.debug('Biggest Number: '+bignum);
    }
    public void sumOfOddAndEvenNumbers(){
        integer oddSum=0, evenSum=0;
        for(integer num:lst){
            if(Math.mod(num,2)==0){
                evenSum = evenSum+num;
            }
            else{
                oddSum = oddSum+num;
            }
        }
        System.debug('Odd numbers sum: '+oddSum);
        System.debug('even numbers sum: '+evenSum);
    }
    public void findNegativeNumber(){
        integer flag=0, count=0;
        for(integer num:lst){
            if(num<0)
            {
                flag=1;
                count = count +1;
            }
        }
        if(flag==1)
            System.debug('negative number exists');
        else
            System.debug('no negative number present');
        System.debug('count of negative numbers: '+count);
   }
   public void reverseList(){
   		List<integer> newlist = new List<integer>();
        for(integer i=lst.size()-1;i>=0;i--){
            newlist.add(lst[i]);
        }
        System.debug(newlist);
    }
}