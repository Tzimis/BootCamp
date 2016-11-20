namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddServiceIdExtraColumn2 : DbMigration
    {
        public override void Up()
        {
            DropPrimaryKey("dbo.Services");
            AlterColumn("dbo.Services", "ServiceID", c => c.Int(nullable: false));
            AlterColumn("dbo.Services", "Id", c => c.Int(nullable: false, identity: true));
            AddPrimaryKey("dbo.Services", "Id");
        }
        
        public override void Down()
        {
            DropPrimaryKey("dbo.Services");
            AlterColumn("dbo.Services", "Id", c => c.Int(nullable: false));
            AlterColumn("dbo.Services", "ServiceID", c => c.Int(nullable: false, identity: true));
            AddPrimaryKey("dbo.Services", "ServiceID");
        }
    }
}
