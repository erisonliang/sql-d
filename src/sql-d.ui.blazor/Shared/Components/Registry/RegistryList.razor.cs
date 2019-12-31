using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Shared.Components.Registry
{
    public class RegistryListBase : ComponentBase
    {
        [Parameter]
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel(new List<RegistryEntryViewModel>());
        
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