class Dog {

    String name; 
    int age; 

    Dog(String name, int age) {
        this.name = name; 
        this.age = age;
    }

    void set_name(String name) {
        this.name = name; 
    }

    void set_age(int age) {
        this.age = age; 
    }

    String get_name() {
        return this.name; 
    }

    int get_age() {
        return this.age;
    }
    
    public static void main(String[] args) {
        Dog dog = new Dog("Frank", 11); 
        System.out.println(dog.get_name()); 
        System.out.println(dog.get_age()); 
    }
}