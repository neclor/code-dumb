using System.Security.Cryptography.X509Certificates;
using System.Drawing;
using System.Drawing.Imaging;
using CsvHelper;

namespace AlbionBlackMarketBot;


public record ItemModel(string Name, string Category, decimal Price);


public partial class Market
{
    private static int ScanBuyPrice()
    {
        return Recognition.RecognitionNumber(MarketButton.ordinaryBuyPrice, false);
    }

    private static int ScanAveragePrice()
    {
        return Recognition.RecognitionNumber(MarketButton.averagePrice, true);
    }

    public static void Preparation()
    {
        Emulate.MouseClick(MarketButton.nothing);
        Program.screenSize = new Point(Screen.PrimaryScreen.Bounds.Width, Screen.PrimaryScreen.Bounds.Height);

        Console.WriteLine(Program.screenSize);
        MarketButton.CalculatePosition(Program.screenSize);

        Emulate.MouseClick(MarketButton.blackInset);
        Emulate.MouseClick(MarketButton.buySell);
        Emulate.MouseClick(MarketButton.openInfo);
        Emulate.MouseClick(MarketButton.days7);
        Emulate.MouseClick(MarketButton.closeInfo);
    }


    public static void ScanBlackMarket()
    {
        Preparation();

        foreach(var item in Data.itemList)
        {
            string id = item.Key;
            Tag[] tags = item.Value;
            bool checkFlag = true;

            foreach(var excludedTag in Data.excludedTags)
            {
                if(tags.Contains(excludedTag))
                {
                    checkFlag = false;
                }
            }

            if(checkFlag)
            {
                ScanItemBlackMarket(id, tags);
            }
        }
        DataFunction.SaveItemPrice();
    }

    private static void ScanItemBlackMarket(string id, Tag[] tags)
    {
        Emulate.MouseClick(MarketButton.search);

        Emulate.TextWrite(Data.engItemName[id]);

        Emulate.MouseClick(MarketButton.buySell);

        Emulate.MouseClick(MarketButton.quality);
        Emulate.MouseClick(new Point(MarketButton.quality.X, MarketButton.quality.Y + MarketButton.displacement));

        Emulate.MouseClick(MarketButton.enchantment);
        Emulate.MouseClick(new Point(MarketButton.enchantment.X, MarketButton.enchantment.Y + MarketButton.displacement));

        int additionalDisplacement = 0;

        if(tags.Contains(Tag.AdditionalTier1))
        {
            additionalDisplacement = MarketButton.displacement;
        }
        else if(tags.Contains(Tag.AdditionalTier2))
        {
            additionalDisplacement = MarketButton.displacement * 2;
        }

        for(int i = 0; i <= 4; i++)
        {
            if(Data.usingTier.Contains(i))
            {
                Emulate.MouseClick(MarketButton.tier);
                Emulate.MouseClick(new Point(MarketButton.tier.X, additionalDisplacement + MarketButton.tier.Y + MarketButton.displacement * (i + 1)));

                int price = ScanAveragePrice();

                Data.itemPrice[id][i] = price;

                Console.WriteLine($"{Data.engItemName[id]}; {id}; {i}; {price};");
            }
        }

        Emulate.MouseClick(MarketButton.closeInfo);
    }
}
