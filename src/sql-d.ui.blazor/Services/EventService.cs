using System;
using System.Collections.Generic;

namespace SqlD.UI.Services
{
    public class EventService
    {
        private static readonly object Synchronise = new object();
        private static readonly Dictionary<string, List<Action<string, string>>> Subscribers = new Dictionary<string,List<Action<string,string>>>();
        
        public void Subscribe(string eventName, Action<string, string> handler)
        {
            lock (Synchronise)
            {
                if (!Subscribers.ContainsKey(eventName))
                {
                    Subscribers.Add(eventName, new List<Action<string, string>>());
                }
                
                var eventSubscribers = Subscribers[eventName];
                eventSubscribers.Add(handler);
                Subscribers[eventName] = eventSubscribers;
            }
        }
        
        public void Dispatch(string eventName, string eventValue)
        {
            lock (Synchronise)
            {
                foreach (var subscriber in Subscribers[eventName])
                {
                    subscriber(eventName, eventValue);
                }
            }
        }
    }
}