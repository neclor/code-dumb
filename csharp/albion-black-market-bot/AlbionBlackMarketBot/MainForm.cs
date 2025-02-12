using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Reflection.Emit;
using System.Windows.Forms;
using OpenCvSharp;
using OpenCvSharp.Text;
using static System.Net.Mime.MediaTypeNames;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Text;
using System.Xml.Linq;
using System.Runtime.InteropServices;
using OpenCvSharp.XFeatures2D;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TaskbarClock;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Diagnostics.Metrics;
using System.Text.RegularExpressions;

namespace AlbionBlackMarketBot;

public partial class MainForm : Form
{
    public MainForm()
    {
        InitializeComponent();
    }

    private void ScanBlackMarketButton_Click(object sender, EventArgs e)
    {
        Market.ScanBlackMarket();
    }

    private void BuyButton_Click(object sender, EventArgs e)
    {

    }
}
