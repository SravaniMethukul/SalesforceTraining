public class OperatorCalculation {
    public void operCal(integer firstnum, integer secondnum, string operator){
        integer result;
        if(operator=='+'){
            result=firstnum+secondnum;
        }
        else if(operator=='-'){
            result=firstnum-secondnum;
        }
        else if(operator=='*'){
            result=firstnum*secondnum;
        }
        else if(operator=='/'){
            result=firstnum/secondnum;
        }
        else{
            System.debug('Invalid Operation');
        }
        System.debug('result= '+result);
    }
}