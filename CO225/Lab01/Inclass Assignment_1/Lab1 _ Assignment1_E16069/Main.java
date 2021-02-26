/* Lab1 - Assigmnment 1;
   E/16/069 
*/

import java.math.*;
import java.util.Random; // for random
import java.io.*; // for file IO

public class Main {

    public static void main(String[] args) {

        /* Reading a file.
         */
        BufferedReader descriptor = null;
        String line = null;
        String [] names = new String[62]; // 61 names


        try {
            descriptor = new BufferedReader(
                    new FileReader("co225-classlist.txt"));

            for(int i=0; i < names.length; i++) // assume file has 61 lines
                names[i] = descriptor.readLine();

            descriptor.close();

        } catch(IOException e) {
            // IOException is more generic (FileNotFound is a type of a
            // IOException, so catching only that is sufficient
            System.out.println("Bad things happen, what do you do!" + e);
            return;
        }

	
        Student [] student = new Student[61];	//array of student objects
        int rand;

        Student.totAtt = 0;	
        Student.numStud = 0;

        // we will run only if no exceptions were thrown
        for(int i=0; i < student.length; i++){
            rand = (int)(Math.random() * 45);	//generating random number between 0 and 45
            student[i] = new Student(names[i], rand);

	    //checking the condition average percentage < 80
            if(student[i].percentageAtt() < 80){
                System.out.println(student[i].name);
            }

        }
	
	//calculate and print average attendance percentage of all the students.
        System.out.println((student[0].avgAt()/45)*100);
    }

}
