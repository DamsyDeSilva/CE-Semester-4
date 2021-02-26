/* Lab1 - Assigmnment 2;
   E/16/069	
*/	

class Lab1 { 

    public static void main(String [] args) {
	int [] array = {0, 1, 2, 1, 0, -1, 2, 3, 5, 6, 7, 4, 3, 4, 6, 5, 4};
	showMaxima(array);
    }

    public static void showMaxima(int [] array) {
        // implement


        //checking the conditions middle elements to be a local maxima
        for(int i = 1; i < array.length -1; i++){
            //compare an element with either side
            if(array[i] >= array[i+1] && array[i] >= array[i-1]){
                System.out.println(array[i]);
            }
        }

    }
}
