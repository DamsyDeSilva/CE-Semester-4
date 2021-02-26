/*
 *	CO225 - Lab06
 *	E/16/069
 * 
 *	Model class of the Tic-Tac-Toe Game
 * 
 */

public class GameModel {
	
	private char [][] board;
	private char currentPlayer;
	private boolean hasWinner;
	private int moveCount;
	
	// class constructor
	public GameModel() {
		this.board = new char[3][3];
		this.currentPlayer = '1';
		this.hasWinner = false;
		this.moveCount = 0;
		initializeBoard();
	}
	
	
	// set player id on board
	public void setModelValue(int i, int j, char player) {
		board[i][j] = player;
	}
	
	// get hasWinner 
	public boolean getHasWinner() {
		return hasWinner;
	}
	
	// get current player
	public char getCurrentPlayer() {
		return currentPlayer;
	}
	// get current player
	public int getMoveCount() {
		return moveCount;
	}
	
	// to initialize the board at the constructor
	private void initializeBoard() {
		for (int i = 0; i < 3; i++) {
			for(int j = 0; j < 3; j++) {
				board[i][j] = ' ';
			}
		}
	}
	
	// toggle player turns
	public void togglePlayer() {
		if (currentPlayer == '1')
			currentPlayer = '2';
		else
			currentPlayer = '1';
		
		moveCount++;	// incrementing the move count
	}
	
	
	// for a new game
	public void resetBoard() {
		hasWinner = false;
		moveCount = 0;
		currentPlayer = '1';
		for (int i = 0; i < 3; i++) {
			for(int j = 0; j < 3; j++) {
				board[i][j] = ' ';
			}
		}
	}	
	
	// method for checking the winner
	public boolean checkWinner() {
		
		//horizontal win check
		for (int i = 0; i < 3; i++) {
			if((board[i][0]== currentPlayer) &&  (board[i][1] == currentPlayer) && (board[i][2] == currentPlayer) ) {
				hasWinner = true;
				return true;
			}
				     
		} 
        //vertical win check
		for (int i = 0; i < 3; i++) {
			if((board[0][i]== currentPlayer) &&  (board[1][i] == currentPlayer) && (board[2][i] == currentPlayer)) {
				hasWinner = true;
				return true; 
			}
				    
		}
		
        //diagonal win check
		if((board[0][0]== currentPlayer) &&  (board[1][1] == currentPlayer) && (board[2][2] == currentPlayer)) {
			hasWinner = true;
			return true;
		}	 
		if((board[0][2]== currentPlayer) &&  (board[1][1] == currentPlayer) && (board[2][0] == currentPlayer)) {
			hasWinner = true;
			return true;
		}
			
		//no winner
		return false;
	}
	
	
}
