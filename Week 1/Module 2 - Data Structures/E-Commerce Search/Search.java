public class Search {

    public static Product linearSearch(
            Product[] products,
            String target) {

        for(Product p : products) {

            if(p.name.equalsIgnoreCase(target))
                return p;
        }

        return null;
    }
}