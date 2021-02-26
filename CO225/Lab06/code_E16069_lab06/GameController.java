/*
 *	CO225 - Lab06
 *	E/16/069
 * 
 *	Controller class of the Tic-Tac-Toe Game
 * 
 */

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

public class GameController {
	
	private GameView theView;
	private GameModel theModel;
	
	// class constructor
	public GameController(GameView theView, GameModel theModel) {
		this.theView = theView;
		this.theModel = theModel;
		
		//ActionListners
		this.theView.addActionForBoard(new GameListener());
		this.theView.addActionForNewGame(new NewGameListener());
		this.theView.addActionForQuit(new QuitListener());
	}
	
	// implementing ActionListener for JButton game grid 
	class GameListener implements  ActionListener{
		// Listens for JButton grid 
		@Override
		public void actionPerformed(ActionEvent e) {
			
			int [] position = new int[2];
			position = theView.getPosition(e);	// get the clicked button position
			
			// if the performed action is valid :- clicked on empty button--> proceed
			if (((JButton) e.getSource()).getText().equals(" ") && theModel.getHasWinner() == false) {
				
				// set the button value in view , board value in Model as currentPlayer Number
				theView.setButtonValue(position[0], position[1], String.valueOf(theModel.getCurrentPlayer()));	
				theModel.setModelValue(position[0], position[1], theModel.getCurrentPlayer());
				
				// check for a winner
				if (theModel.checkWinner()) {
					// if has a winner then display winner message and reset the game
					theView.displayWinner(theModel.getCurrentPlayer());
					theView.resetGame();   // reset the view
					theModel.resetBoard(); // reset the model
					
				} else {
					// if there's a no winner then toggle the player
					theModel.togglePlayer();
			
					// after toggle the player: check for draw condition
					if(theModel.getMoveCount() == 9) {
						theView.displayDraw();
						theView.resetGame();	// reset the view
						theModel.resetBoard();	// reset the model
					}
				}
				
			}
			
		}
		
	}

	// implementing ActionListener for NewGame JButton  
	class NewGameListener implements ActionListener{
		// if new button reset the game
		@Override
		public void actionPerformed(ActionEvent e) {
			theView.resetGame();
			theModel.resetBoard();				
		}
	}

	// implementing ActionListener for Quit JButton 
	class QuitListener implements ActionListener{
		// if quit button clicked close the window
		@Override
		public void actionPerformed(ActionEvent e) {
			theView.gui.dispose();			
		}
	}

}
