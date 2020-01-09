using System;
using System.Threading.Tasks;
using Microsoft.JSInterop;

namespace SqlD.UI.Services
{
    public class StorageService
    {
        private readonly IJSRuntime jsRuntime;

        public StorageService(IJSRuntime jsRuntime)
        {
            this.jsRuntime = jsRuntime;
        }

        public async Task SetItem(string key, string value)
        {
            await jsRuntime.InvokeVoidAsync($"localStorage.setItem", key, value);
        }

        public async Task<string> GetItem(string key)
        {
            return await jsRuntime.InvokeAsync<string>($"localStorage.getItem", key);
        }
    }
}