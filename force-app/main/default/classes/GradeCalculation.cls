public class GradeCalculation {
    public void calculation(integer mark1,integer mark2,integer mark3){
    	integer avg=(mark1+mark2+mark3)/3;
    	string res = (mark1>35 && mark2>35 & mark3>35)?'pass':'fail';
    	string grade = (res=='pass'&& avg>90)?'S grade':(res=='pass'&& avg>80)?'A grade':(res=='pass'&& avg>70)?'B grade':(res=='pass'&& avg>50)?'C grade':'No grade';
		System.debug('result: '+res);
    	System.debug('grade: '+grade);
    }
}