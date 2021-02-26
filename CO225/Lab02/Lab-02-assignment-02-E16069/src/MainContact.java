import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Scanner;

public class MainContact {
    public static void main(String[] args) {

        BufferedReader br;
        String line = null;
        String[] lineArray = new String[3];

        
        ArrayList<Contact> student = new ArrayList<Contact>();
        try {
            br = Files.newBufferedReader(Paths.get("contacts.txt"));

            line = br.readLine();
            while(line != null){
                lineArray = line.split(",");
                student.add(new Contact(lineArray[0], lineArray[1], lineArray[2]));
                line = br.readLine();
            }
            br.close();

        } catch(IOException e) {
            System.err.format("IOException: %s%n", e);
            return;
        }

        //scanning input
        
        Scanner sc = new Scanner(System.in);
        while(true) {
        	
        	System.out.println("Enter Name : ");
        
            String [] buff = sc.nextLine().split(":");
           
            // buff[0] holds F or L
            // buff[1] holds name
            
            //Input "END to terminate the loop"
            if (buff[0].equals("END")) {
            	System.out.println("Program Ended!!");
            	sc.close();
            	break;
            }

            
           int count = 0;
            //when search from FirstName
            if (buff[0].equals("F")) {
                //iterate through student array
                for (int i = 0; i < 16; i++) {
                    if (student.get(i).getFname().equals(buff[1])) {
                    	count++;
                    	System.out.println(student.get(i).getFname() +" "+ student.get(i).getlname() + " : " + student.get(i).getContact());
                    }
                }
                if (count == 0) {
                	System.out.println("No contact found");
                }
            }
            //when search from FirstName
            else if (buff[0].equals("L")) {
                //iterate through student array
                for (int i = 0; i < 16; i++) {
                    if (student.get(i).getlname().equals(buff[1])) {
                    	count++;
                    	System.out.println(student.get(i).getFname() +" "+ student.get(i).getlname() + " : " + student.get(i).getContact());
                    }
                }
                if (count == 0) {
                	System.out.println("No contact found");
                }
            }
            else {
            	System.out.println("Input in correct format");
            }
        }     
   }
        
}