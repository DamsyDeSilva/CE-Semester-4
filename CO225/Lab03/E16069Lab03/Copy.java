import java.io.IOException;
import java.util.Scanner;
import java.io.FileWriter;
import java.io.File;

public class Copy extends GenericCommand { 

    /* Copy command 
     * two arguments, 
     */ 
    public void handleCommand(String [] args) { 

        count++;    //counting the executed commands
		if(!args[0].equals("copy")) someThingWrong(); 


        //checking the number of arguments
		if(args.length != 3) { 
			System.out.println("Usage: copy <Source File> <Destination File>");
			return;
		}
     
        try {

            //creating a file object of source file
            File myObj = new File(args[1]);
            Scanner myReader = new Scanner(myObj);  //scanner obj of file object

            //FileWriter object for destination file
            FileWriter myWriter = new FileWriter(args[2]);
            
            
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();  //scanning the nextline
                myWriter.write(data);               //write the scanned data
                myWriter.write(String.format("%n"));//print newline
            }
            //close the file objects
            myReader.close();   
            myWriter.close();

        } catch(IOException e) {
            System.err.format("IOException : %s%n", e);
            return;
        }
    }

}