using NUnit.Framework;
using SqlD.Network;
using SqlD.Network.Diagnostics;
using SqlD.Tests.Framework.Network;

namespace SqlD.Tests.Network.Diagnostics
{
	[TestFixture]
	public class EndPointMonitorTests : NetworkTestCase
	{
		[Test]
		public void ShouldBeAbleToDetectListenerUpDownEvents()
		{
			EndPointMonitor freeEndPointMonitor2 = null;

			try
			{
				var free2IsUp = false;

				freeEndPointMonitor2 = new EndPointMonitor(WellKnown.EndPoints.Free2);

				freeEndPointMonitor2.OnUp += args => free2IsUp = true;
				freeEndPointMonitor2.OnDown += args => free2IsUp = false;

				freeEndPointMonitor2.WaitUntil(Constants.END_POINT_UP_WAIT_FOR_TIMEOUT, EndPointIs.Up);
				freeEndPointMonitor2.DoEvents();

				Assert.That(free2IsUp, Is.True);
			}
			finally
			{
				freeEndPointMonitor2?.Dispose();
			}
		}
	}
}