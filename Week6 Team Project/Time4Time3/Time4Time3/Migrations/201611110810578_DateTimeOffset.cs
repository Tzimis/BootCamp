namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class DateTimeOffset : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Messages", "SentDate", c => c.DateTimeOffset(nullable: false, precision: 7));
            AlterColumn("dbo.Messages", "ReadDate", c => c.DateTimeOffset(nullable: false, precision: 7));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Messages", "ReadDate", c => c.DateTime(nullable: false));
            AlterColumn("dbo.Messages", "SentDate", c => c.DateTime(nullable: false));
        }
    }
}
