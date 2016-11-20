namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UserUpdates : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "CreditsOwned", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            AddColumn("dbo.AspNetUsers", "PostalCode", c => c.String(maxLength: 50));
            AddColumn("dbo.AspNetUsers", "ProfileStatus", c => c.Int(nullable: false));
            DropColumn("dbo.AspNetUsers", "Credits");
            DropColumn("dbo.AspNetUsers", "PostCode");
            DropColumn("dbo.AspNetUsers", "IsActive");
        }
        
        public override void Down()
        {
            AddColumn("dbo.AspNetUsers", "IsActive", c => c.Boolean(nullable: false));
            AddColumn("dbo.AspNetUsers", "PostCode", c => c.String(maxLength: 50));
            AddColumn("dbo.AspNetUsers", "Credits", c => c.Decimal(nullable: false, precision: 18, scale: 2));
            DropColumn("dbo.AspNetUsers", "ProfileStatus");
            DropColumn("dbo.AspNetUsers", "PostalCode");
            DropColumn("dbo.AspNetUsers", "CreditsOwned");
        }
    }
}
