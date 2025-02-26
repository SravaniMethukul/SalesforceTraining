public class GradeCalculationUsingIf {
	public void calculation(integer mark1,integer mark2,integer mark3){
    	integer avg=(mark1+mark2+mark3)/3;
    	string res, grade;
        if(mark1>35 && mark2>35 & mark3>35){
            res='pass';
        }
        else{
            res='fail';
        }
        if(res=='pass' && avg>90){
            grade='S grade';
        }
        else if(res=='pass' && avg>80){
            grade='A grade';
		}
        else if(res=='pass' && avg>70){
            grade='B grade';
		}
        else if(res=='pass' && avg>50){
            grade='C grade';
		}
        else{
            grade='No grade';
        }
		System.debug('result: '+res);
    	System.debug('grade: '+grade);
    }
}