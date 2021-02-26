import java.io.IOException;
import java.util.Scanner;
import java.io.File;

public class Less extends GenericCommand { 

    /* Less command 
     * only one arguments, 
     */ 

    public void handleCommand(String [] args) { 

        count++;    //counting the executed commands
		if(!args[0].equals("less")) someThingWrong(); 

        //checking the number of arguments
		if(args.length != 2) { 
			System.out.println("Usage: less <file>");
			return;
        }
        

        try {

            File myObj = new File(args[1]);         //creating a file object for the file
            Scanner myReader = new Scanner(myObj);  //scanner obj of file object

            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();  //scanning the nextline
                System.out.println(data);           //print the data
            }
            myReader.close();   //close the file object

        } catch(IOException e) {
            System.err.format("IOException : %s%n", e);
            return;
        }


    }

}