namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ServiceUpdates : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Services", "Title", c => c.String(nullable: false, maxLength: 140));
            AddColumn("dbo.Services", "Description", c => c.String(nullable: false, maxLength: 2000));
            AddColumn("dbo.Services", "CreditWorth", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            DropColumn("dbo.Services", "ServiceTitle");
            DropColumn("dbo.Services", "ServiceDescription");
            DropColumn("dbo.Services", "Credits");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Services", "Credits", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AddColumn("dbo.Services", "ServiceDescription", c => c.String(nullable: false, maxLength: 2000));
            AddColumn("dbo.Services", "ServiceTitle", c => c.String(nullable: false, maxLength: 140));
            DropColumn("dbo.Services", "CreditWorth");
            DropColumn("dbo.Services", "Description");
            DropColumn("dbo.Services", "Title");
        }
    }
}
