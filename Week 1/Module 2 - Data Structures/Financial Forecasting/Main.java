public class Main {

    public static void main(String[] args) {

        double futureValue =
                Forecast.predictValue(
                        10000,
                        0.10,
                        5);

        System.out.println(
                futureValue);
    }
}