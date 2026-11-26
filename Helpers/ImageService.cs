using System;
using System.IO;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace ShoeStore.Helpers
{
    public static class ImageService
    {
        private const int MaxWidth = 300;
        private const int MaxHeight = 200;

        public static string SaveResizedCopy(string sourcePath)
        {
            BitmapImage source = ImageLoader.LoadFromFile(sourcePath);
            double scaleWidth = (double)MaxWidth / source.PixelWidth;
            double scaleHeight = (double)MaxHeight / source.PixelHeight;
            double scale = Math.Min(1.0, Math.Min(scaleWidth, scaleHeight));

            BitmapSource result = source;

            if (scale < 1.0)
            {
                result = new TransformedBitmap(source, new ScaleTransform(scale, scale));
            }

            string extension = Path.GetExtension(sourcePath).ToLowerInvariant();
            BitmapEncoder encoder;
            string newExtension;

            if (extension == ".png")
            {
                encoder = new PngBitmapEncoder();
                newExtension = ".png";
            }
            else
            {
                encoder = new JpegBitmapEncoder { QualityLevel = 90 };
                newExtension = ".jpg";
            }

            encoder.Frames.Add(BitmapFrame.Create(result));

            string folder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images");
            Directory.CreateDirectory(folder);

            string fileName = "product_" + Guid.NewGuid().ToString("N") + newExtension;
            string destination = Path.Combine(folder, fileName);

            using (FileStream stream = new FileStream(destination, FileMode.Create))
            {
                encoder.Save(stream);
            }

            return fileName;
        }

        public static void DeleteImage(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName) || fileName == "picture.png")
            {
                return;
            }

            string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images", fileName);

            if (File.Exists(path))
            {
                try
                {
                    File.Delete(path);
                }
                catch (IOException)
                {
                }
            }
        }
    }
}
