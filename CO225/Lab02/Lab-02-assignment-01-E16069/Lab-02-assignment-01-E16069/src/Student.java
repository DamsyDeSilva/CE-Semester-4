
import java.lang.Math;

public class Student {
    private String name;
    private float height;
    private float weight;

    //class constructor
    public Student(String name, float height, float weight){
        this.name = name;
        this.height = height;
        this. weight = weight;
    }
    
    public String getName() {
		return name;
	}
    public float getHeight() {
		return height;
	}
    public float getWeight() {
		return weight;
	}

    
    //function for calculate BMI
    public float calBMI(){
        return (float) (weight/(Math.pow(height,2)));
    }

}
