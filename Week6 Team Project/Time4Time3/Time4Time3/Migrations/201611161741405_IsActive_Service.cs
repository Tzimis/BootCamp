namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class IsActive_Service : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Services", "IsActive", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Services", "IsActive", c => c.Boolean(nullable: false));
        }
    }
}
