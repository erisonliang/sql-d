using Microsoft.AspNetCore.Components;
using SqlD.UI.Services;

namespace SqlD.UI.Blazor.Shared
{
    public class MainLayoutBase : LayoutComponentBase
    {
        [Inject]
        private EventService EventService { get; set; }
        
        [CascadingParameter] 
        public string ConnectedService { get; set; }

        protected override void OnInitialized()
        {
            EventService.Subscribe("ConnectedService", (eventName, eventValue) =>
            {
                InvokeAsync(() => ConnectedService = eventValue);
            });
        }
    }
}