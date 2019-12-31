using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using SqlD.UI.Blazor.Shared.Components.Registry;
using SqlD.UI.Services;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Pages
{
    public class QueryBase : ComponentBase
    {
        [Inject]
        private RegistryService RegistryService { get; set; }

        public RegistryViewModel Registry { get; set; } = new RegistryViewModel(new List<RegistryEntryViewModel>());
    
        protected override async Task OnInitializedAsync()
        {
            Registry = await RegistryService.GetServices();
        }

        protected void NewServiceClick(RegistryListEventArgs args)
        {
            Console.WriteLine("New Service Clicked!");
        }
        
        protected void ServiceIdentityClick(RegistryListEventArgs args)
        {
            Console.WriteLine($"Service Identity Clicked! {args.Service}");
        }

        protected void ServiceSwaggerClick(RegistryListEventArgs args)
        {
            Console.WriteLine($"Service Swagger Clicked! {args.Service}");
        }

        protected void ServiceConnectClick(RegistryListEventArgs args)
        {
            Console.WriteLine($"Service Connect Clicked! {args.Service}");
        }
    }
}