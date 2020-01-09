using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Shared.Components.ServiceConnect
{
    public class ServiceConnectBase : ComponentBase
    {
        private string connectedService = string.Empty;

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
        
        protected void ServiceOnChangeInvoke(ChangeEventArgs e)
        {
            var service = Registry.Entries.First(x => x.Uri == e.Value.ToString());
            ConnectedService = service.Uri;
        }
    }
}