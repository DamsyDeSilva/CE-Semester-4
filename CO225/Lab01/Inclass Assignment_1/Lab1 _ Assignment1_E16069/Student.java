/* Lab1 - Assigmnment 1;
   E/16/069 
*/


public class Student {

    String name;		//student name
    float attendance;		
    static float totAtt;	//total attendance 
    static int numStud;

    //student class constructor
    public Student(String name, int attendance){
        this.name = name;
        this.attendance = attendance;
        totAtt += attendance;	//add the individual attendance to the totalAttendance 
        numStud++;		//counting number of students
    }

    //method for attendance percentage of a student
    public float percentageAtt(){
        return (attendance/45)*100;
    }

    //method for average attendance per student
    public float avgAt(){
        return (totAtt/numStud);
    }


}
