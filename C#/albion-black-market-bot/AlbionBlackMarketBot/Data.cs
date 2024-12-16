using AlbionBlackMarketBot;
using Microsoft.VisualBasic.ApplicationServices;
using System.Runtime.InteropServices;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Header;

namespace AlbionBlackMarketBot;

public enum Tag
{
    Armor,

    Cloth,
    ClothCowl,
    ClothRobe,
    ClothSandals,

    Leather,
    LeatherHood,
    LeatherJacket,
    LeatherShoes,

    Plate,
    PlateHelmet,
    PlateArmor,
    PlateBoots,


    Weapon,
	Warrior,
	Hunter,
	Mage,

	AdditionalTier1,
	AdditionalTier2,
}

public partial class Data
{
    public static List<int> usingTier = new List<int> { 0, 1, 2, 3, 4 };

    public static List<Tag> excludedTags = new List<Tag>();

    public static string filePath = $"Price.csv";

    public record ItemModel(string Name, int priceTier0, int priceTier1, int priceTier2, int priceTier3, int priceTier4);

    public static readonly Dictionary<string, int[]> itemPrice = new();

    public static readonly Dictionary<string, Tag[]> itemList = new() 
    {
        {"CLOTH_COWL_SET_1", new[] { Tag.Armor, Tag.Cloth, Tag.ClothCowl, Tag.AdditionalTier2 }},
        {"CLOTH_COWL_SET_2", new[] { Tag.Armor, Tag.Cloth, Tag.ClothCowl }},
        {"CLOTH_COWL_SET_3", new[] { Tag.Armor, Tag.Cloth, Tag.ClothCowl }},

        {"CLOTH_ROBE_SET_1", new[] { Tag.Armor, Tag.Cloth, Tag.ClothRobe, Tag.AdditionalTier2 }},
        {"CLOTH_ROBE_SET_2", new[] { Tag.Armor, Tag.Cloth, Tag.ClothRobe }},
        {"CLOTH_ROBE_SET_3", new[] { Tag.Armor, Tag.Cloth, Tag.ClothRobe }},

        {"CLOTH_SANDALS_SET_1", new[] { Tag.Armor, Tag.Cloth, Tag.ClothSandals, Tag.AdditionalTier2 }},
        {"CLOTH_SANDALS_SET_2", new[] { Tag.Armor, Tag.Cloth, Tag.ClothSandals }},
        {"CLOTH_SANDALS_SET_3", new[] { Tag.Armor, Tag.Cloth, Tag.ClothSandals }},

        /*
        {"LEATHER_HOOD_SET_1", new[] { Tag.Armor, Tag.Leather, Tag.LeatherHood, Tag.AdditionalTier2 }},
        {"LEATHER_HOOD_SET_2", new[] { Tag.Armor, Tag.Leather, Tag.LeatherHood }},
        {"LEATHER_HOOD_SET_3", new[] { Tag.Armor, Tag.Leather, Tag.LeatherHood }},

        {"LEATHER_JACKET_SET_1", new[] { Tag.Armor, Tag.Leather, Tag.LeatherJacket, Tag.AdditionalTier2 }},
        {"LEATHER_JACKET_SET_2", new[] { Tag.Armor, Tag.Leather, Tag.LeatherJacket }},
        {"LEATHERE_JACKET_SET_3", new[] { Tag.Armor, Tag.Leather, Tag.LeatherJacket }},

        {"LEATHER_SHOES_SET_1", new[] { Tag.Armor, Tag.Leather, Tag.LeatherShoes, Tag.AdditionalTier2 }},
        {"LEATHER_SHOES_SET_2", new[] { Tag.Armor, Tag.Leather, Tag.LeatherShoes }},
        {"LEATHER_SHOES_SET_3", new[] { Tag.Armor, Tag.Leather, Tag.LeatherShoes }},


        {"PLATE_HELMET_SET_1", new[] { Tag.Armor, Tag.Plate, Tag.PlateHelmet, Tag.AdditionalTier2 }},
        {"PLATE_HELMET_SET_2", new[] { Tag.Armor, Tag.Plate, Tag.PlateHelmet }},
        {"PLATE_HELMET_SET_3", new[] { Tag.Armor, Tag.Plate, Tag.PlateHelmet }},

        {"PLATE_ARMOR_SET_1", new[] { Tag.Armor, Tag.Plate, Tag.PlateArmor, Tag.AdditionalTier2 }},
        {"PLATE_ARMOR_SET_2", new[] { Tag.Armor, Tag.Plate, Tag.PlateArmor }},
        {"PLATE_ARMOR_SET_3", new[] { Tag.Armor, Tag.Plate, Tag.PlateArmor }},

        {"PLATE_BOOTS_SET_1", new[] { Tag.Armor, Tag.Plate, Tag.PlateBoots, Tag.AdditionalTier2 }},
        {"PLATE_BOOTS_SET_2", new[] { Tag.Armor, Tag.Plate, Tag.PlateBoots }},
        {"PLATE_BOOTS_SET_3", new[] { Tag.Armor, Tag.Plate, Tag.PlateBoots }}
        */
    };

    public static Dictionary<string, string> engItemName = new Dictionary<string, string>()
    {
        {"CLOTH_COWL_SET_1", "Scholar Cowl"},
        {"CLOTH_COWL_SET_2", "Cleric Cowl"},
        {"CLOTH_COWL_SET_3", "Mage Cowl"},

        {"CLOTH_ROBE_SET_1", "Scholar Robe"},
        {"CLOTH_ROBE_SET_2", "Cleric Robe"},
        {"CLOTH_ROBE_SET_3", "Mage Robe"},

        {"CLOTH_SANDALS_SET_1", "Scholar Sandals"},
        {"CLOTH_SANDALS_SET_2", "Cleric Sandals"},
        {"CLOTH_SANDALS_SET_3", "Mage Sandals"},


        {"LEATHER_HOOD_SET_1", "Mercenary Hood"},
        {"LEATHER_HOOD_SET_2", "Hunter Hood"},
        {"LEATHER_HOOD_SET_3", "Assassin Hood"},

        {"LEATHER_JACKET_SET_1", "Mercenary Jacket"},
        {"LEATHER_JACKET_SET_2", "Hunter Jacket"},
        {"LEATHERE_JACKET_SET_3", "Assassin Jacket"},

        {"LEATHER_SHOES_SET_1", "Mercenary Shoes"},
        {"LEATHER_SHOES_SET_2", "Hunter Shoes"},
        {"LEATHER_SHOES_SET_3", "Assassin Shoes"},


        {"PLATE_HELMET_SET_1", "Soldier Helmet"},
        {"PLATE_HELMET_SET_2", "Knight Helmet"},
        {"PLATE_HELMET_SET_3", "Guardian Helmet"},

        {"PLATE_ARMOR_SET_1", "Soldier Armor"},
        {"PLATE_ARMOR_SET_2", "Knight Armor"},
        {"PLATE_ARMOR_SET_3", "Guardian Armor"},

        {"PLATE_BOOTS_SET_1", "Soldier Boots"},
        {"PLATE_BOOTS_SET_2", "Knight Boots"},
        {"PLATE_BOOTS_SET_3", "Guardian Boots"},
    };
}
