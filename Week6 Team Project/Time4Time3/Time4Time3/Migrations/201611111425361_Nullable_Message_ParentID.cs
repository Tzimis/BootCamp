namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Nullable_Message_ParentID : DbMigration
    {
        public override void Up()
        {
            DropIndex("dbo.Messages", new[] { "ParentMessageID" });
            AlterColumn("dbo.Messages", "ParentMessageID", c => c.Int());
            CreateIndex("dbo.Messages", "ParentMessageID");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Messages", new[] { "ParentMessageID" });
            AlterColumn("dbo.Messages", "ParentMessageID", c => c.Int(nullable: false));
            CreateIndex("dbo.Messages", "ParentMessageID");
        }
    }
}
