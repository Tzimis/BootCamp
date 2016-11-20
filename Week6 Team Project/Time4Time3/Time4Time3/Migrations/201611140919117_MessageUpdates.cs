namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class MessageUpdates : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Messages", "RelatedServiceID", "dbo.Services");
            DropIndex("dbo.Messages", new[] { "RelatedServiceID" });
            DropColumn("dbo.Messages", "RelatedServiceID");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Messages", "RelatedServiceID", c => c.Int());
            CreateIndex("dbo.Messages", "RelatedServiceID");
            AddForeignKey("dbo.Messages", "RelatedServiceID", "dbo.Services", "ServiceID");
        }
    }
}
