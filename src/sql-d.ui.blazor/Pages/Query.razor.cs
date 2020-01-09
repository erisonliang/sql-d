using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using SqlD.UI.Blazor.Shared.Components.RegistryList;
using SqlD.UI.Services;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Pages
{
    public class QueryBase : ComponentBase
    {
        [Inject]
        private RegistryService RegistryService { get; set; }
        
        [Inject]
        private EventService EventService { get; set; }

        [Parameter]
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel();
        
        [CascadingParameter]
        public string ConnectedService { get; set; }
    
        protected override async Task OnInitializedAsync()
        {
            Registry = await RegistryService.GetServices();
        }

        protected void RegistryList_NewServiceClick(RegistryListEventArgs args)
        {
            Console.WriteLine("New Service Clicked!");
        }
        
        protected void RegistryList_ServiceIdentityClick(RegistryListEventArgs args)
        {
            Console.WriteLine($"Service Identity Clicked! {args.Service}");
        }

        protected void RegistryList_ServiceSwaggerClick(RegistryListEventArgs args)
        {
            Console.WriteLine($"Service Swagger Clicked! {args.Service}");
        }

        protected void RegistryList_ServiceConnectClick(RegistryListEventArgs args)
        {
            EventService.Dispatch("ConnectedService", args.Service.Uri);
        }
    }
}