namespace Time4Time3.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class merge1 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Transactions",
                c => new
                    {
                        Sender_Id = c.String(nullable: false, maxLength: 128),
                        Service_Id = c.Int(nullable: false),
                        Id = c.Int(nullable: false, identity: true),
                        Rating = c.Int(),
                        CreditValue = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Status = c.Int(nullable: false),
                        StartDate = c.DateTimeOffset(nullable: false, precision: 7),
                        AcceptDate = c.DateTimeOffset(precision: 7),
                        CancelDate = c.DateTimeOffset(precision: 7),
                        CompleteDate = c.DateTimeOffset(precision: 7),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Services", t => t.Service_Id)
                .ForeignKey("dbo.AspNetUsers", t => t.Sender_Id)
                .Index(t => t.Sender_Id)
                .Index(t => t.Service_Id);
            
            AddColumn("dbo.Messages", "TransactionId", c => c.Int());
            CreateIndex("dbo.Messages", "TransactionId");
            AddForeignKey("dbo.Messages", "TransactionId", "dbo.Transactions", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Transactions", "Sender_Id", "dbo.AspNetUsers");
            DropForeignKey("dbo.Transactions", "Service_Id", "dbo.Services");
            DropForeignKey("dbo.Messages", "TransactionId", "dbo.Transactions");
            DropIndex("dbo.Transactions", new[] { "Service_Id" });
            DropIndex("dbo.Transactions", new[] { "Sender_Id" });
            DropIndex("dbo.Messages", new[] { "TransactionId" });
            DropColumn("dbo.Messages", "TransactionId");
            DropTable("dbo.Transactions");
        }
    }
}
