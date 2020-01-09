using System;
using Microsoft.AspNetCore.Components;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Shared.Components.RegistryList
{
    public class RegistryListBase : ComponentBase
    {
        private string connectedService;

        [Parameter]
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel();

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
        public Action<RegistryListEventArgs> NewServiceClick { get; set; }
        
        [Parameter]
        public Action<RegistryListEventArgs> ServiceIdentityClick { get; set; }

        [Parameter]
        public Action<RegistryListEventArgs> ServiceSwaggerClick { get; set; }

        [Parameter]
        public Action<RegistryListEventArgs> ServiceConnectClick { get; set; }

        protected void NewServiceInvoke()
        {
            NewServiceClick?.Invoke(new RegistryListEventArgs());
        }
        
        protected void ServiceIdentityInvoke(RegistryEntryViewModel service)
        {
            ServiceIdentityClick?.Invoke(new RegistryListEventArgs(service));
        }
        
        protected void ServiceSwaggerInvoke(RegistryEntryViewModel service)
        {
            ServiceSwaggerClick?.Invoke(new RegistryListEventArgs(service));
        }

        protected void ServiceConnectInvoke(RegistryEntryViewModel service)
        {
            ConnectedService = service.Uri;
            ServiceConnectClick?.Invoke(new RegistryListEventArgs(service));
        }
    }

    public class RegistryListEventArgs : EventArgs
    {
        public RegistryEntryViewModel Service { get; }

        public RegistryListEventArgs()
        {
        }

        public RegistryListEventArgs(RegistryEntryViewModel service)
        {
            Service = service;
        }
    }
}