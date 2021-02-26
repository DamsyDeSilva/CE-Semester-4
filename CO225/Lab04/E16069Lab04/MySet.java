
/* my array list: an array that behaves like a list 
 * E/16/069
 */

public class MySet<T/* Can we have any T */> { 

    int nextItem; 
    int currentCapacity; 
    T[] data; // DO NOT CHANGE

    private static int defaultSizeToCreate = 10; // how many elements to create 

    @SuppressWarnings("unchecked")
	public MySet(int elements) { 
		this.nextItem = 0; 
		this.defaultSizeToCreate = elements; 
		this.currentCapacity = elements; 

		this.data = (T[]) new Object[this.defaultSizeToCreate]; 
    }

    public MySet() { 
		this(defaultSizeToCreate); 
    }

    public boolean isEmpty() { return this.nextItem == 0; } 
	public boolean isFull() { return nextItem == this.currentCapacity; } 
	
	
    public boolean add(T item) {
		
		/* if there is any element delete it 
		* then add the new element. 
		* How do you handle when the array is full: 
		* crate a new array with currentCapacity+defaultSizeToCreate, 
		* copy the old conents into that
		* Accessing array when full might be a problem
		*/
		if (isFull()){ 
			resize();
		} else{
			try {
				data[nextItem] = null; // DO NOT CHANGE
			} catch (ArrayIndexOutOfBoundsException e) {
				System.out.println("Got an exception " + e);
			}		 
		}
		/* Add the item to the array if the item is not there */
		for(int i = 0; i < data.length; i++){
			if (item.equals(data[i])) {
				return false;
			}
		}

		data[nextItem] = item;
		nextItem++;
		return true; // CHANGE ME
	}

	// resizing the array 
	public void resize(){

		int new_size = this.currentCapacity + defaultSizeToCreate; // new size of the set
		@SuppressWarnings("unchecked")
		T[] new_data = (T[]) new Object[new_size];

		// copy the old content into new array
		for(int i = 0; i < this.currentCapacity; i++){
			new_data[i] = this.data[i];
		}

		this.currentCapacity = new_size;
		this.data = new_data;
	}
	


    public T remove() { 
		/* remove the first element in the array 
		* and copy the rest front. 
		* FIFO structure. 
		* If the ArrayList is empty return null
		*/
		/* Option 1: */
		
		if(isEmpty()) return null; 
		
		// IMPLEMENT THE REST
		T r_item = this.data[0];
		for(int i =0; i<data.length-1; i++){
			data[i]=data[i+1];
		}
		this.nextItem--;
		return r_item; 

		
		/*------Option 2--------*/
		/*if(!isEmpty()) { 
			// IMPLEMENT THE REST

			T r_item = this.data[0];
			for(int i =0; i<data.length-1; i++){
				data[i]=data[i+1];
			}
			this.nextItem--;
			return r_item;
		}
		return null;*/
		// which option is better? why? 
    }


}
	 

	