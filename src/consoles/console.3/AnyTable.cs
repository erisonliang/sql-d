using SqlD.Attributes;

namespace SqlD.Console_3
{
	[SqlLiteTable("Any_Table")]
	public class AnyTable
	{
		public long Id { get; set; }

		[SqlLiteColumn("Any_Decimal", SqlLiteType.Real, true)]
		public decimal AnyDecimal { get; set; }

		[SqlLiteColumn("Any_Double", SqlLiteType.Real, true)]
		public double AnyDouble { get; set; }

		[SqlLiteColumn("Any_Integer", SqlLiteType.Integer, true)]
		public int AnyInteger { get; set; }

		[SqlLiteColumn("Any_String", SqlLiteType.Text, true)]
		public string AnyString { get; set; }
	}
}