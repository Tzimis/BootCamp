namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Nullable_Message_ReadDate : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Messages", "ReadDate", c => c.DateTimeOffset(precision: 7));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Messages", "ReadDate", c => c.DateTimeOffset(nullable: false, precision: 7));
        }
    }
}
