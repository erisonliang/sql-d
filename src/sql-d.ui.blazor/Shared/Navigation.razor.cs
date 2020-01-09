using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using SqlD.UI.Blazor.Shared.Components.ServiceConnect;
using SqlD.UI.Models.Registry;
using SqlD.UI.Services;

namespace SqlD.UI.Blazor.Shared
{
    public class NavigationBase : ComponentBase
    {
        [Inject]
        private RegistryService RegistryService { get; set; }
        
        [Inject]
        private StorageService StorageService { get; set; }

        [Parameter] 
        public string ConnectedServiceValue { get; set; } = string.Empty;

        [Parameter] 
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel();

        protected override async Task OnInitializedAsync()
        {
            Registry = await RegistryService.GetServices();
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            ConnectedServiceValue = await StorageService.GetItem("SqlD_ServiceConnect_Value");
            StateHasChanged();
        }

        protected void ServiceConnect_ServiceOnChange(ServiceConnectEventArgs args)
        {
            StorageService.SetItem("SqlD_ServiceConnect_Value", $"{args.Service.Uri}").GetAwaiter().GetResult();
        }
    }
}