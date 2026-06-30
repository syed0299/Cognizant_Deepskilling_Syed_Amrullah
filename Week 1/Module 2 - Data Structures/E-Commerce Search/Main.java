public class Main {

    public static void main(String[] args) {

        Product[] products = {

                new Product(1,"Laptop"),
                new Product(2,"Mouse"),
                new Product(3,"Keyboard")
        };

        Product result =
                Search.linearSearch(
                        products,
                        "Mouse");

        if(result != null)
            System.out.println(result.name);
    }
}