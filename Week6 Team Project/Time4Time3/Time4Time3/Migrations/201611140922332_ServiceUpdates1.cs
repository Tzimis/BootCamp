namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ServiceUpdates1 : DbMigration
    {
        public override void Up()
        {
            DropIndex("dbo.Services", new[] { "SupplierID" });
            CreateIndex("dbo.Services", "SupplierId");
        }
        
        public override void Down()
        {
            DropIndex("dbo.Services", new[] { "SupplierId" });
            CreateIndex("dbo.Services", "SupplierID");
        }
    }
}
