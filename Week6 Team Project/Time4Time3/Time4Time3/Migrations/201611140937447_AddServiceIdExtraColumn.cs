namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddServiceIdExtraColumn : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Services", "Id", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Services", "Id");
        }
    }
}
