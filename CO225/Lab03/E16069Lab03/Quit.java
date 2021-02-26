public class Quit extends GenericCommand { 

    /* Quit command 
     * Only quit should be there. 
     * no arguments, 
     */ 
    public void handleCommand(String [] args) { 

		count++; //counting the executed commands
		if(!args[0].equals("quit")) someThingWrong(); 

		if(args.length != 1) { 
			System.out.println("Usage: quit");
			return;
		}

		
		/***
		 * ###### You need to print the number of commands 
		 * that was executed before exiting
		 */

		/* OK, so just die */

		//Print the Executed command counts
		System.out.println("Executed " + count + " commands since starting");
		
		System.exit(0); 

    }

}