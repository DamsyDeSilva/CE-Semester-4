/*
 *	CO225 - Lab06
 *	E/16/069
 * 
 *	View class of the Tic-Tac-Toe Game
 * 
 */

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;


@SuppressWarnings("serial")
public class GameView extends JFrame{
	
		private JButton [][] buttonBoard;
		private JButton newGame, quit;
		protected JFrame gui;
		
		// class constructor
		public GameView() {
			this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			this.buttonBoard = new JButton[3][3];
			this.newGame = new JButton("New Game");
			this.quit = new JButton("Quit");
			this.gui = new JFrame("Tic - Tac - Toe");
			initialize();
		}
		
		private void initialize() {
			
			// JFrame Properties
			gui.setSize(new Dimension(400, 300));
			gui.setLocationRelativeTo(null);
			
			// add JPanels and add components on them
		    JPanel gamePanel = new JPanel(new FlowLayout());
		    JPanel game = new JPanel(new GridLayout(3,3));
		    gui.add(gamePanel, BorderLayout.CENTER);
		    gamePanel.add(game, BorderLayout.CENTER);
		    
		    // Create JPanel and add newGame and quit buttons
		    JPanel options = new JPanel(new FlowLayout());
		    gui.add(options, BorderLayout.SOUTH);
		    options.add(newGame);
		    options.add(quit);
		    
		    //creating JButtons on JPanel
		    for(int row = 0; row < 3; row++) {
		        for(int column = 0; column < 3; column++) {
		        	buttonBoard[row][column] = new JButton();
		        	buttonBoard[row][column].setPreferredSize(new Dimension(75,75));
		        	buttonBoard[row][column].setText(" ");
		            game.add(buttonBoard[row][column]);		              
			    }
			}
		}
		
		// set text for a button 
		public void setButtonValue(int row, int column, String player) {
			buttonBoard[row][column].setText(player); 
		}
		
		
		// function to find the x,y-coordinates of the pressed button
	    public int[] getPosition(ActionEvent e) {
	    	int[] position = new int[2];
	    	
	    	for(int row = 0; row < 3; row++) {
		        for(int column = 0; column < 3; column++) {
		        	if(e.getSource() == buttonBoard[row][column]) {
		        		position[0] = row;
		        		position[1] = column;
		        	}
		        }
	    	}
	    	return position;
	    }
		
	    //add action for game board
		public void addActionForBoard(ActionListener e) {
			for(int row = 0; row < 3; row++) {
				for(int column = 0; column < 3; column++) {
					buttonBoard[row][column].addActionListener(e);	              
				}
			}
		}
		 
		// add Action for NewGame button
		public void addActionForNewGame(ActionListener e) {
			newGame.addActionListener(e);
		}
		 
		// add Action for NewGame button
		public void addActionForQuit(ActionListener e) {
			quit.addActionListener(e);
        }

		// Display the winner
		public void displayWinner(char player) {
			String message = "Player " + String.valueOf(player) + " Wins!" + "\n" + "Congratulations";
			JOptionPane.showMessageDialog(null, message);
		}
		 
		// Display the game draw
		public void displayDraw() {
			JOptionPane.showMessageDialog(null, "Game Draw!");
		}
		 
		// reseting the game
		public void resetGame() {
			for(int row = 0; row < 3; row++) {
				for(int column = 0; column < 3; column++) {
					buttonBoard[row][column].setText(" ");
		        }
		    }
		}

}
