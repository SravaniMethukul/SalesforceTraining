public class SumOfNumbers {
    public static void numbersSum(){
        integer oddsum=0, evensum=0;
        for(integer i=1;i<=20;i++){
            if(Math.mod(i,2)!=0){
                oddsum=oddsum+i;
            }
            else{
                evensum=evensum+i;
            }
        }
        System.debug('Sum of Odd Numbers: '+oddsum);
        System.debug('Sum of Even Numbers: '+evensum);
    }
}