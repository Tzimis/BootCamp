using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mobile
{
    class Device
    {
        public delegate int PerformCalculation();
        public string Model { get; private set; }
        public string Manufacturer { get; private set; }
        public decimal BasePrice { get; private set; }
        public Screen Screen { get; private set; }
        public Battery Battery { get; private set; }

        public Device(string Model, string Manufacturer, decimal BasePrice, Screen Screen, Battery Battery)
        {
            this.Model = Model;
            this.Manufacturer = Manufacturer;
            this.BasePrice = BasePrice;
            this.Screen = Screen;
            this.Battery = Battery;
        }

        public override string ToString()
        {
            PerformCalculation c = BatteryMins;
            return $"{c()}: {Manufacturer} {Model}, Screen: {Screen.DiagonalInches:0.0}\", Battery: {Battery.Type}, {Battery.Capacity}mAh, Price: {BasePrice}.";
        }

        public static Device getIPhone7()
        {
            return new Device("iPhone 7", "Apple", 899.90m, Screen.getIPhoneScreen(), Battery.getIPhoneBattery());
        }

        public static Device getNokia()
        {
            return new Device("7665", "Nokia", 399.90m, Screen.getNokiaScreen(), Battery.getNokiaBattery());
        }

        public int ScreenArea()
        {
            return Screen.HeightPixels * Screen.WidthPixels;
        }

        public int BatteryMins()
        {
            return (int) Battery.Capacity / 12;
        }
    }
}
