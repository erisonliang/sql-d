using System;

namespace SqlD.Start.Options
{
    public class CommandAttribute : Attribute
    {
        public string Command { get; set; }
    }
}