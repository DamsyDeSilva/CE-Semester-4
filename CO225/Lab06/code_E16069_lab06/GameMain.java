/*
 * CO225 - Lab06
 * E/16/069
 * 
 * Implement the classical tic-tac-toe
 * Using Model View Control (MVC) architecture
 * 
 */

public class GameMain {

	public static void main(String[] args) {
		
		GameView theView = new GameView();
		GameModel theModel = new GameModel();
		
		@SuppressWarnings("unused")
		GameController theController = new GameController(theView, theModel);
		
		// display GUI in theView 
		theView.gui.setVisible(true);
		
	}

}
