using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using SqlD.UI.Models.Registry;
using SqlD.UI.Services;

namespace SqlD.UI.Blazor.Shared
{
    public class NavigationBase : ComponentBase
    {
        private string connectedService = string.Empty;

        [Inject]
        private RegistryService RegistryService { get; set; }
        
        [Inject]
        private EventService EventService { get; set; }

        [Parameter]
        public string ConnectedService
        {
            get => connectedService;
            set
            {
                if (connectedService != value)
                {
                    connectedService = value;
                    ConnectedServiceChanged.InvokeAsync(connectedService);
                }
            }
        }

        [Parameter] 
        public EventCallback<string> ConnectedServiceChanged { get; set; }

        [Parameter] 
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel();

        protected override void OnInitialized()
        {
            EventService.Subscribe("ConnectedService", (eventName, eventValue) =>
            {
                InvokeAsync(() => ConnectedService = eventValue);
            });
        }

        protected override async Task OnInitializedAsync()
        {
            Registry = await RegistryService.GetServices();
        }
    }
}