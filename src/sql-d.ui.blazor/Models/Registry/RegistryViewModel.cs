using System.Collections.Generic;
using System.Linq;

namespace SqlD.UI.Models.Registry
{
	public class RegistryViewModel
	{
		public RegistryViewModel(List<RegistryEntryViewModel> items = null)
		{
			items ??= new List<RegistryEntryViewModel>();
			Entries = items.OrderBy(x => x.Tags).ToList();
		}

		public List<RegistryEntryViewModel> Entries { get; set; }
	}
}