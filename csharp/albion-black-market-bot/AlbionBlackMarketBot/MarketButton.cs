namespace AlbionBlackMarketBot;

public partial class MarketButton
{
    static int screenWidth, screenHeight;

    public static int displacement;

    public static Rectangle ordinaryBuyPrice, averagePrice;

    public static Point
        nothing,
        search,
        openInfo,
        days7,
        closeInfo,
        buySell,

        quality,

        enchantment,

        tier, // +4

        blackInset,

        ordinaryInfoBuy,
        ordinarySetQuantity,
        ordinaryGetQuantity,

        ordinaryQuality,
        ordinaryQuality0,
        ordinaryQuality1,
        ordinaryQuality2,
        ordinaryQuality3,
        ordinaryQuality4;

    static Point Coord(double x, double y) => new((int)(screenWidth * x), (int)(screenHeight * y));

    public static void CalculatePosition(Point screenSize)
    {
        (screenWidth, screenHeight) = (screenSize.X, screenSize.Y);

        displacement = Convert.ToInt32(screenHeight * 0.03);

        ordinaryBuyPrice = new Rectangle(Convert.ToInt32(screenWidth * 0.5708), Convert.ToInt32(screenHeight * 0.325), Convert.ToInt32(screenWidth * 0.09), Convert.ToInt32(screenHeight * 0.09));
        averagePrice = new Rectangle(Convert.ToInt32(screenWidth * 0.79), Convert.ToInt32(screenHeight * 0.69), Convert.ToInt32(screenWidth * 0.04), Convert.ToInt32(screenHeight * 0.04));

        nothing = Coord(0.27, 0.12);
        search = Coord(0.293, 0.188);
        openInfo = Coord(0.69, 0.2546);
        days7 = Coord(0.5825, 0.709);
        closeInfo = Coord(0.485, 0.235);
        buySell = Coord(0.7, 0.376);

        quality = Coord(0.4, 0.34);

        enchantment = Coord(0.3, 0.34);

        tier = Coord(0.2, 0.34); // +4

        blackInset = Coord(0.78, 0.355);

        ordinaryInfoBuy = Coord(0.45, 0.725);

        ordinarySetQuantity = Coord(0.25, 0.544);
        ordinaryGetQuantity = Coord(0.427, 0.544);

        ordinaryQuality = Coord(0.7, 0.188);
        ordinaryQuality0 = Coord(0.7, 0.25);
        ordinaryQuality1 = Coord(0.7, 0.285);
        ordinaryQuality2 = Coord(0.7, 0.315);
        ordinaryQuality3 = Coord(0.7, 0.345);
        ordinaryQuality4 = Coord(0.7, 0.38);
    }
}
