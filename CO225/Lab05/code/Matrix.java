/*
	CO225 - Lab05
	E/16/069
*/
public class Matrix extends Thread { 

    private static int [][] a; 
    private static int [][] b; 
    private static int [][] c; 

	/* You might need other variables as well */
	
	private int row_Num, col_Num;

    public Matrix(int row, int col) { // need to change this, might need some information 
		this.row_Num = row;
		this.col_Num = col;
	}

	// Q1) how to use threads to parallelize the operation
	// --> create different threads as each thread evaluate a specific position in the result matrix
	
	public void run(){
		
		// Q3 - allocate work for each thread
		// -->  perform the the dotproduct of the corresponding row from the first matrix and corresponding column from the second matrix;

		for(int i = 0; i < a[this.row_Num].length; i++){
			Matrix.c[this.row_Num][this.col_Num] += Matrix.a[this.row_Num][i] * Matrix.b[i][this.col_Num]; 
		}

	}

    public static int [][] multiply(int [][] a, int [][] b) {

		/* check if multipication can be done, if not 
		* return null 
		* allocate required memory 
		* return a * b
		*/

		int x = a.length; 
		int y = b[0].length; 

		int z1 = a[0].length; 
		int z2 = b.length; 

		if(z1 != z2) { 
			System.out.println("Cannnot multiply");
			return null;
		}

		Matrix.a = a;
		Matrix.b = b;
		Matrix.c = new int [x][y]; 
		
		// Q2) the required number of threads gonna be number of elemnets in resulting Matrix
		int nuOfThreads = x * y;
		Matrix [] threads = new Matrix[nuOfThreads];

		int count = 0;
		for (int i = 0; i < x; i++){
			for (int j = 0; j < y; j++){
				threads[count] = new Matrix(i,j);
				threads[count++].start();
			}
		}
		
		// Q4) Synchronizing threads using .join() method;
		for (int i = 0; i < nuOfThreads; i++){
			try {
				threads[i].join();
			} catch (Exception e) {
				System.out.println("Exception has been caught " + e);
			}
		}
		
		return c; 
    }

}