using System;
using System.IO;
using System.Windows.Media.Imaging;

namespace ShoeStore.Helpers
{
    public static class ImageLoader
    {
        public static BitmapImage Load(string fileName)
        {
            string folder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images");
            string imageName = string.IsNullOrWhiteSpace(fileName) ? "picture.png" : fileName;
            string path = Path.Combine(folder, imageName);

            if (!File.Exists(path))
            {
                path = Path.Combine(folder, "picture.png");
            }

            if (!File.Exists(path))
            {
                return null;
            }

            BitmapImage image = new BitmapImage();
            image.BeginInit();
            image.CacheOption = BitmapCacheOption.OnLoad;
            image.UriSource = new Uri(path, UriKind.Absolute);
            image.EndInit();
            image.Freeze();

            return image;
        }

        public static BitmapImage LoadFromFile(string path)
        {
            BitmapImage image = new BitmapImage();
            image.BeginInit();
            image.CacheOption = BitmapCacheOption.OnLoad;
            image.UriSource = new Uri(path, UriKind.Absolute);
            image.EndInit();
            image.Freeze();

            return image;
        }
    }
}
