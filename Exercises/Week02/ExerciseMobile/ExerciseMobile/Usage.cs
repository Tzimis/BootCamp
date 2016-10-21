using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mobile
{
    class Usage
    {
        public double BatteryPercentage { get; private set; }
        public Device Device { get; private set; }

        public string OSInfo { get; private set; }
        public List<Call> CallList { get; private set; }

        public Usage(Device Device, string OSInfo)
        {
            BatteryPercentage = 100;
            this.OSInfo = OSInfo;
            this.Device = Device;
            CallList = new List<Call>();
        }
        public void AddCall(Call call)
        {
            CallList.Add(call);
            useBattery(call);
        }

        public void RemoveCall(Call call)
        {
            CallList.Remove(call);
        }

        public void ClearHistory()
        {
            CallList.Clear();
        }

        public string GetCallHistory()
        {
            StringBuilder result = new StringBuilder();
            foreach (Call call in CallList) result.Append(call);
            if (result.Length == 0) result.Append("No Calls in History.");
            return result.ToString();
        }

        private void useBattery(Call call)
        {
            BatteryPercentage -= call.Duration.TotalMinutes * 0.1;
        }

        public void NewCall(Call.CallType callType)
        {
            CallList.Add(new Call(callType));
        }

        public void EndCall()
        {
            CallList[CallList.Count - 1].EndCall();
        }

    }
}
