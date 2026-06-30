public class Forecast {

    public static double predictValue(
            double currentValue,
            double growthRate,
            int years) {

        if(years == 0)
            return currentValue;

        return predictValue(
                currentValue *
                        (1 + growthRate),
                growthRate,
                years - 1);
    }
}