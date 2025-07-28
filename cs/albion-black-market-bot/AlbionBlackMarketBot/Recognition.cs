using System.Drawing.Imaging;
using System.Drawing;
using System.Text.RegularExpressions;
using OpenCvSharp.Text;
using OpenCvSharp;
using OpenCvSharp.Extensions;

namespace AlbionBlackMarketBot;

public partial class Recognition
{
    public static int RecognitionNumber(Rectangle rect, bool checkAveragePrice)
    {
        Thread.Sleep(200);

        Bitmap priceCanvas = IncreaseContrast(MakeBlackWhite(AddMargin(TakeScreenshot(rect), checkAveragePrice)));

        using Mat priceMat = BitmapConverter.ToMat(priceCanvas);
        using Mat src = new Mat();

        Cv2.CvtColor(priceMat, src, ColorConversionCodes.BGRA2BGR);

        string recognizedText;

        using (var tesseract = OCRTesseract.Create(@"C:\Git\CSharp\AlbionBlackMarketBot\AlbionBlackMarketBot\_data\tessdata", "eng", "0123456789KkMmTt ,."))
        {
            tesseract.Run(src, out recognizedText, out var componentRects, out var componentTexts, out var componentConfidences);
        }

        string correctedText = StringCorrection(recognizedText);

        bool success = Int32.TryParse(correctedText, out int outputNumber);

        if (success)
        {
            Console.WriteLine($"SUCCESSFUL recognition. Recognized text: '{recognizedText.Replace("\n", "")}', corrected text: '{correctedText.Replace("\n", "")}', received number: {Convert.ToString(outputNumber).Replace("\n", "")}");

            return outputNumber;
        }
        else
        {
            Console.WriteLine($"UNSUCCESSFUL recognition. Recognized text: '{recognizedText.Replace("\n", "")}', corrected text: '{correctedText.Replace("\n", "")}'");

            return -1;
        }
    }

    public static Bitmap TakeScreenshot(Rectangle rect)
    {
        Bitmap screenshot = new Bitmap(rect.Width, rect.Height);

        using (Graphics graphics = Graphics.FromImage(screenshot))
        {
            graphics.CopyFromScreen(rect.Location, System.Drawing.Point.Empty, rect.Size);
        }

        return screenshot;
    }

    public static Bitmap AddMargin(Bitmap canvas, bool checkAveragePrice)
    {
        Bitmap canvasBig = new Bitmap(Convert.ToInt32(canvas.Width * 1.1), canvas.Height);

        using (Graphics graphics = Graphics.FromImage(canvasBig))
        {
            Color color;

            if (checkAveragePrice)
            {
                color = Color.FromArgb(149, 126, 111);
            }
            else
            {
                color = Color.FromArgb(235, 199, 160);
            }

            Brush brush = new SolidBrush(color);
            graphics.FillRectangle(brush, 0, 0, canvasBig.Width, canvasBig.Height);
        }

        using (Graphics graphics = Graphics.FromImage(canvasBig))
        {
            graphics.DrawImage(canvas, new System.Drawing.Point(canvasBig.Width - canvas.Width, 0));
        }

        return canvasBig;
    }

    public static Bitmap MakeBlackWhite(Bitmap canvas)
    {
        Bitmap canvasBlackWhite = new Bitmap(canvas.Width, canvas.Height);

        ColorMatrix colorMatrix = new ColorMatrix(
        new float[][]
           {
        new float[] { 0.299f, 0.299f, 0.299f, 0, 0 },
        new float[] { 0.587f, 0.587f, 0.587f, 0, 0 },
        new float[] { 0.114f, 0.114f, 0.114f, 0, 0 },
        new float[] { 0, 0, 0, 1, 0 },
        new float[] { 0, 0, 0, 0, 1 }
        });

        ImageAttributes imageAttributes = new ImageAttributes();
        imageAttributes.SetColorMatrix(colorMatrix);

        using (Graphics graphics = Graphics.FromImage(canvasBlackWhite))
        {
            Rectangle rectangle = new Rectangle(0, 0, canvas.Width, canvas.Height);
            graphics.DrawImage(canvas, rectangle, 0, 0, canvas.Width, canvas.Height, GraphicsUnit.Pixel, imageAttributes);
        }

        return canvasBlackWhite;
    }

    public static Bitmap IncreaseContrast(Bitmap canvas)
    {
        Bitmap canvasContrast = (Bitmap)canvas.Clone();

        float[][] matrix =
        {
            new float[] { 2, 0, 0, 0, 0 },
            new float[] { 0, 2, 0, 0, 0 },
            new float[] { 0, 0, 2, 0, 0 },
            new float[] { 0, 0, 0, 1, 0 },
            new float[] { 0, 0, 0, 0, 1 }
        };

        ColorMatrix colorMatrix = new ColorMatrix(matrix);
        ImageAttributes attributes = new ImageAttributes();
        attributes.SetColorMatrix(colorMatrix);

        // Применение настройки контрастности к изображению
        using (Graphics graphics = Graphics.FromImage(canvasContrast))
        {
            graphics.DrawImage(canvasContrast, new Rectangle(0, 0, canvasContrast.Width, canvasContrast.Height),
                               0, 0, canvasContrast.Width, canvasContrast.Height, GraphicsUnit.Pixel, attributes);
        }

        return canvasContrast;
    }

    public static string StringCorrection(string text) =>
        Regex.Replace(Regex.Replace(Regex.Replace(text,
            @"[ ,.]", ""),
            @"[KkTt]", "000"),
            @"[Mm]", "000000");
}
