﻿using SqlD.Network;

namespace SqlD.Configuration.Model
{
	public class SqlDEndPointModel : EndPoint
	{
		public EndPoint ToEndPoint()
		{
			return new EndPoint(Host, Port);
		}

		public override string ToString()
		{
			return $"{nameof(Port)}: {Port}, {nameof(Host)}: {Host}";
		}
	}
}