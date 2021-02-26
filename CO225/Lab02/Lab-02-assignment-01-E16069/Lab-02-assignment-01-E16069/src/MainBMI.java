import java.io.BufferedReader;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;


public class MainBMI {
    public static void main(String[] args) {

        BufferedReader br;
        String line = null;
        String[] lineArray = new String[3];

        ArrayList<Student> student = new ArrayList<Student>();
        try {
            br = Files.newBufferedReader(Paths.get("input.txt"));

            line = br.readLine();
            while(line != null){
                lineArray = line.split(",");
                student.add(new Student(lineArray[0], Float.parseFloat(lineArray[1]), Float.parseFloat(lineArray[2]))) ;
                line = br.readLine();
            }
            br.close();

        } catch(IOException e) {
            System.err.format("IOException: %s%n", e);
            return;
        }

        //calculate bmi for student objects
        for (int i = 0; i < student.size(); i++){
            float bmi = student.get(i).calBMI();

            String status;
            if(bmi > 25) {
                status = "You are overweight";
            }
            else if(bmi > 18.5) {
                status = "You are healthy";
            }
            else {
                status = "Not healthy";
            }

            System.out.println("Name :" + student.get(i).getName() + ", Height(m) :"+ student.get(i).getHeight() + ", Weight(kg) :" + student.get(i).getWeight() + ", BMI :"+ bmi + ", Status :" + status);
        }
    }
}