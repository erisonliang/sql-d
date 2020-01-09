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
        [Parameter]
        public string SelectedValue { get; set; } = string.Empty;
        
        [Parameter]
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel();
        
        [Parameter]
        public Action<ServiceConnectEventArgs> ServiceOnChange { get; set; }
        
        protected void ServiceOnChangeInvoke(ChangeEventArgs e)
        {
            var service = Registry.Entries.First(x => x.Uri == e.Value.ToString());
            ServiceOnChange?.Invoke(new ServiceConnectEventArgs(service));
        }
    }

    public class ServiceConnectEventArgs : EventArgs
    {
        public RegistryEntryViewModel Service { get; }

        public ServiceConnectEventArgs(RegistryEntryViewModel service)
        {
            Service = service;
        }
    }
}