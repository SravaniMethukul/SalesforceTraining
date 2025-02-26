public class DIYcalculation {
    public static void multiplyByFive(integer var){
        integer i=1,res=0;
        while(i<=10){
        	res = var*i;
            system.debug(var+' * '+i+'= '+res);
            i=i+1;
        }
    }
    public static void expressionCalculation(){
        integer n=5, x=1, sum=0;
        for(integer i=1;i<=n;i++){
            sum=sum+(i*n);
        }
        system.debug('expression sum is: '+sum);
    }
}