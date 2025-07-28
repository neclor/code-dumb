using CsvHelper;

namespace AlbionBlackMarketBot;

public class DataFunction
{
    public static void CreateItemPrice()
    {
        foreach(var item in Data.itemList)
        {
            string id = item.Key;
            Data.itemPrice.Add(id, new int[]{ -1, -1, -1, -1, -1});
        }
    }

    public static void SaveItemPrice()
    {
        using var writer = new StreamWriter(Data.filePath);
        using var csv = new CsvWriter(writer, CultureInfo.InvariantCulture);
        csv.WriteField("id");
        for(int i = 0; i <= 4; i++)
        {
            csv.WriteField("priceTier" + i);
        }
        csv.NextRecord();

        foreach(var item in Data.itemPrice)
        {
            csv.WriteField(item.Key);

            foreach(int price in item.Value)
            {
                csv.WriteField(price);
            }
            csv.NextRecord();
        }
    }

    public static void LoadItemPrice()
    {
        if(File.Exists(Data.filePath))
        {
            using var reader = new StreamReader(Data.filePath);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
            if(csv.Read() && csv.ReadHeader())
            {
                while(csv.Read())
                {
                    string id = csv.GetField("id");
                    int[] prices = new int[5];

                    for(int i = 0; i <= 4; i++)
                    {
                        prices[i] = csv.GetField<int>("priceTier" + i);
                    }

                    Data.itemPrice[id] = prices;
                }
            }
        }
    }
}
