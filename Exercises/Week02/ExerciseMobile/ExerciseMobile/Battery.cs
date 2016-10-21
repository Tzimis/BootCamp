namespace Mobile
{
    public class Battery
    {
        public enum BatteryType { NiCd, NiMH, LiIon}

        public BatteryType Type { get; private set; }
        public double Capacity { get; private set; }

        public Battery (BatteryType Type, double Capacity)
        {
            this.Type = Type;
            this.Capacity = Capacity;
        }

        public static Battery getIPhoneBattery()
        {
            return new Battery(Battery.BatteryType.LiIon, 1715); 
        }

        public static Battery getNokiaBattery()
        {
            return new Battery(Battery.BatteryType.NiMH, 1905);
        }
    }
}