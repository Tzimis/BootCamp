using System;

namespace Mobile
{
    public class  Screen
    {
        public int HeightPixels { get; private set; }
        public int WidthPixels { get; private set; }
        public double PixelDensity { get; private set; }

        public double WidthInches {
            get
            {
                return (double) WidthPixels / PixelDensity;
            }
        }

        public double HeightInches
        {
            get
            {
                return (double)HeightPixels / PixelDensity;
            }
        }

        public double DiagonalInches
        {
            get
            {
                return Math.Sqrt(HeightInches * HeightInches + WidthInches * WidthInches);
            }
        }

        public Screen(int WidthPixels, int HeightPixels, double PixelDensity)
        {
            this.WidthPixels = WidthPixels;
            this.HeightPixels = HeightPixels;
            this.PixelDensity = PixelDensity;
        }

        public static Screen getIPhoneScreen()
        {
            return new Screen(750, 1334, 326);
        }

        public static Screen getNokiaScreen()
        {
            return new Screen(649, 960, 260);
        }

    }
}