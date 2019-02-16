using System.Linq;
using NUnit.Framework;
using SqlD.Network.Diagnostics;
using SqlD.Tests.Framework.Network;

namespace SqlD.Tests.Network.Diagnostics
{
	[TestFixture]
	public class EndPointRegistryTests
	{
		[Test]
		public void ShouldBeAbleToRegisterEndPoint()
		{
			EndPointRegistry.GetOrAdd(WellKnown.EndPoints.Free1);
			Assert.That(EndPointRegistry.Get().Any(), Is.True);
		}
	}
}