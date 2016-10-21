using System;

namespace Mobile
{
    internal class Call
    {
        public enum CallType { Incoming, Outgoing }

        public DateTime StartTime { get; private set; }
        public DateTime EndTime { get; private set; }

        public TimeSpan Duration { get { return EndTime - StartTime; } }

        public CallType Type { get; private set; }

        public Call(DateTime StartTime, DateTime EndTime, CallType Type)
        {
            this.StartTime = StartTime;
            this.EndTime = EndTime;
            this.Type = Type;
        }

        public Call(CallType Type)
        {
            StartTime = DateTime.Now;
            this.Type = Type;
        }

        public void EndCall()
        {
            EndTime = DateTime.Now;
        }

        public override string ToString()
        {
            return $"{Type}\t{StartTime}\tDuration: {Duration}\n";
        }
    }
}