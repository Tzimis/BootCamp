namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddServiceIdExtraColumn3 : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Services", "ServiceID");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Services", "ServiceID", c => c.Int(nullable: false));
        }
    }
}
