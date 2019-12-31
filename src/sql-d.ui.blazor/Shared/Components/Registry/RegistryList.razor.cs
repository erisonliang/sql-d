using System.Collections.Generic;
using Microsoft.AspNetCore.Components;
using SqlD.UI.Models.Registry;

namespace SqlD.UI.Blazor.Shared.Components.Registry
{
    public class RegistryListBase : ComponentBase
    {
        [Parameter]
        public RegistryViewModel Registry { get; set; } = new RegistryViewModel(new List<RegistryEntryViewModel>());
   
    }
}