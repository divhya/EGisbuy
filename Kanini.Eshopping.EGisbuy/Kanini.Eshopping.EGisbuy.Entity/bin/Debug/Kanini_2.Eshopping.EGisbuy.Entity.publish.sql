﻿/*
Deployment script for Kanini.Eshopping.EGisbuy.Entity

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Kanini.Eshopping.EGisbuy.Entity"
:setvar DefaultFilePrefix "Kanini.Eshopping.EGisbuy.Entity"
:setvar DefaultDataPath "C:\Users\Divhya.bharathy\AppData\Local\Microsoft\VisualStudio\SSDT"
:setvar DefaultLogPath "C:\Users\Divhya.bharathy\AppData\Local\Microsoft\VisualStudio\SSDT"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key baaae907-6071-4fa6-8bab-984ffd88d203 is skipped, element [dbo].[UserRoles].[Id] (SqlSimpleColumn) will not be renamed to RoleId';


GO
PRINT N'Rename refactoring operation with key 889ceffe-e5ed-45a2-849a-1af11c3c575d is skipped, element [dbo].[Users].[Id] (SqlSimpleColumn) will not be renamed to UserId';


GO
PRINT N'Rename refactoring operation with key 976971ba-3e46-4a8d-8c1d-134184264dfd, a1512acb-2051-4c05-a52b-cdb1f0e12411 is skipped, element [dbo].[Product].[Id] (SqlSimpleColumn) will not be renamed to ProductId';


GO
PRINT N'Rename refactoring operation with key be4e50cb-49fb-44a1-92d4-c4b740c8941f is skipped, element [dbo].[UserAddress].[Id] (SqlSimpleColumn) will not be renamed to BillId';


GO
PRINT N'Rename refactoring operation with key f4b67a82-9673-466b-82f9-a80cb25284b1 is skipped, element [dbo].[Product].[Rating ] (SqlSimpleColumn) will not be renamed to Rating';


GO
PRINT N'Rename refactoring operation with key 3a36ba95-94ef-4bb4-b366-5e31085a3151 is skipped, element [dbo].[WishList].[Id] (SqlSimpleColumn) will not be renamed to CartId';


GO
PRINT N'Rename refactoring operation with key 1767e09f-043a-4f92-882f-b76daa2e4679 is skipped, element [dbo].[Payment].[Id] (SqlSimpleColumn) will not be renamed to PaymentId';


GO
PRINT N'Rename refactoring operation with key 0615ed0f-63c5-4905-a856-4f3eaaeaf71f is skipped, element [dbo].[OrderDetails].[Id] (SqlSimpleColumn) will not be renamed to OrderId';


GO
PRINT N'Rename refactoring operation with key 121d7c4e-360f-4d0e-b3fd-9ca7586e8e2f is skipped, element [dbo].[DeliveryDetails].[Id] (SqlSimpleColumn) will not be renamed to DeliveryId';


GO
PRINT N'Rename refactoring operation with key fff0b906-81cb-4f09-8da8-4ecd9eb583e5 is skipped, element [dbo].[Feedback].[Id] (SqlSimpleColumn) will not be renamed to FeedbackId';


GO
PRINT N'Altering [dbo].[Payment]...';


GO
ALTER TABLE [dbo].[Payment] ALTER COLUMN [CardNumber] DROP MASKED;

ALTER TABLE [dbo].[Payment] ALTER COLUMN [CardNumber] ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX",4)');


GO
PRINT N'Creating [dbo].[InsertPayment]...';


GO
CREATE PROCEDURE [dbo].[InsertPayment]
	@CardNumber varchar(20),
	@ExpiryDate date,
	@CVV int,
	@PaymentType varchar(20),
	@PaymentStatus varchar(20),
	@Amount decimal(15,2)
AS

BEGIN
if @PaymentType ='CashOnDelivery'
		Begin
		insert into [dbo].[Payment](CardNumber,ExpiryDate,CVV,PaymentType,Amount) values ('','','',@PaymentType,'',@Amount)
		end

	if	@PaymentType='CreditCard'
	Begin
	insert into [dbo].[Payment](CardNumber,ExpiryDate,CVV,PaymentType,Amount) values(@CardNumber,@ExpiryDate,@CVV,@PaymentType,'',@Amount)
	End
		
	IF @PaymentType='DebitCard'
	Begin
	insert into [dbo].[Payment](CardNumber,ExpiryDate,CVV,PaymentType,Amount) values(@CardNumber,@ExpiryDate,@CVV,@PaymentType,'',@Amount)
	End
	
		
END
	
RETURN
GO
PRINT N'Creating [dbo].[InsertProductsByAdmin]...';


GO
CREATE PROCEDURE [dbo].[InsertProductsByAdmin]
	@Name varchar(30),
	@Rating decimal(2,1),
	@ManufactureDate date,
	@CartDescription varchar(100),
	@ShortDescription varchar(MAX),
	@Image varchar(100),
	@MRP decimal(10,2),
	@DealPrice decimal(10,2),
	@SavePrice decimal(10,2),
	@NoOfStock int
AS
	insert into [dbo].[Product] values(
	@Name,
	@Rating,
	@ManufactureDate,
	@CartDescription,
	@ShortDescription,
	@Image,
	@MRP,
	@DealPrice,
	@SavePrice,
	@NoOfStock)
RETURN
GO
PRINT N'Creating [dbo].[InsertUserAddress]...';


GO
CREATE PROCEDURE [dbo].[InsertUserAddress]
	@UserId int,
	@Address1 varchar=100,
	@Address2 varchar=100,
	@City varchar=20,
	@State varchar=30,
	@Pincode varchar=20
AS
	insert into [dbo].[UserAddress] values(
	@UserId,
	@Address1,
	@Address2,
	@City,
	@State,
	@Pincode)

	RETURN
GO
PRINT N'Creating [dbo].[InsertUserRoles]...';


GO
CREATE PROCEDURE [dbo].[InsertUserRoles]
	@RoleDescription varchar = 20,
	@RoleNumber int,
	@CreatedDate date,
	@ModifiedDate date,
	@RoleIsActive bit
AS
	INSERT INTO [dbo].[UserRoles] values (
	@RoleDescription,
	@RoleNumber,
	GETDATE(),
	GETDATE(),
	@RoleIsActive)
RETURN
GO
PRINT N'Creating [dbo].[RegisterUserDetails]...';


GO
CREATE PROCEDURE [dbo].[RegisterUserDetails]
	@Name varchar = 30,
	@MobileNumber varchar=15,
	@DateOfBirth date,
	@Gender varchar=10,
	@EMailId varchar= 30,
	@Password varchar =20,
	@RoleId int,
	@CreatedDate date,
	@ModifiedDate date,
	@UserIsActive bit
AS
	
	insert into [dbo].[Users] values(
	@Name,
	@MobileNumber,
	@DateOfBirth,
	@Gender,
	@EMailId,
	@Password,
	@RoleId,
	@CreatedDate,
	@ModifiedDate,
	@UserIsActive)
RETURN
GO
PRINT N'Creating [dbo].[SearchProduct]...';


GO
CREATE PROCEDURE [dbo].[SearchProduct]
	@ProductName varchar(30)
AS
	select * from  Product where Name like '%'+@ProductName+'%' 

RETURN
GO
PRINT N'Creating [dbo].[UpdateDeliveryDetailsByAdmin]...';


GO
CREATE PROCEDURE [dbo].[UpdateDeliveryDetailsByAdmin]
	@ProductId int,
	@OrderId int,
	@DeliveryStatus varchar=20,
	@DeliveryDate date
AS
insert into [dbo].[DeliveryDetails] values (@ProductId,@OrderId,@DeliveryStatus,@DeliveryDate)

RETURN
GO
PRINT N'Creating [dbo].[UpdateProductRatingAndFeedbackByCustomer]...';


GO
CREATE PROCEDURE [dbo].[UpdateProductRatingAndFeedbackByCustomer]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'Creating [dbo].[UpdateProductsByAdmin]...';


GO
CREATE PROCEDURE [dbo].[UpdateProductsByAdmin]
	@Name varchar(30),
	@Rating decimal(2,1),
	@ManufactureDate date,
	@CartDescription varchar(100),
	@ShortDescription varchar(MAX),
	@Image varchar(100),
	@MRP decimal(10,2),
	@DealPrice decimal(10,2),
	@SavePrice decimal(10,2),
	@NoOfStock int
AS
	update [dbo].[Product] set 
	Name=@Name,
	Rating=@Rating,
	ManufactureDate=@ManufactureDate,
	CartDescription=@CartDescription,
	ShortDescription=@ShortDescription,
	Image=@Image,MRP=@MRP,
	DealPrice=@DealPrice,
	SavePrice=@SavePrice,
	NoOfStock=@NoOfStock
RETURN
GO
PRINT N'Creating [dbo].[UpdateUserAddress]...';


GO
CREATE PROCEDURE [dbo].[UpdateUserAddress]
	@UserId int,
	@Address1 varchar=100,
	@Address2 varchar=100,
	@City varchar=20,
	@State varchar=30,
	@Pincode varchar=20
AS
	update [dbo].[UserAddress] set 
	UserId=@UserId,
	Address1=@Address1,
	Address2=@Address2,
	City=@City,
	State=@State,
	Pincode=@Pincode
RETURN
GO
PRINT N'Creating [dbo].[ViewAdminDetails]...';


GO
CREATE PROCEDURE [dbo].[ViewAdminDetails]
	@RoleNumber int
AS
	SELECT * from Users where RoleId in(select RoleId from UserRoles where @RoleNumber=RoleNumber)
RETURN
GO
PRINT N'Creating [dbo].[ViewCustomerDetailsByAdmin]...';


GO
CREATE PROCEDURE [dbo].[ViewCustomerDetailsByAdmin]
	@RoleNumber int
AS
	SELECT * from Users where RoleId in(select RoleId from UserRoles where @RoleNumber=RoleNumber)
RETURN
GO
PRINT N'Creating [dbo].[ViewDeliveryDetails]...';


GO
CREATE PROCEDURE [dbo].[ViewDeliveryDetails]
	@UserId int 
	
AS
	SELECT 
	product.Name,
	product.DealPrice,
	product.Image,
	useraddress.Address1,
	useraddress.Address2,
	useraddress.City,
	useraddress.State,
	useraddress.Pincode,
	payment.Amount,
	payment.PaymentType,
	orderdetails.Quantity,
	DeliveryStatus,
	DeliveryDate from [dbo].[DeliveryDetails] deliverydetails 
	inner join [dbo].[OrderDetails] orderdetails
	on 
	deliverydetails.OrderId=orderdetails.OrderId 
	inner join [dbo].[Product] product 
	on
	deliverydetails.ProductId=product.ProductId
	inner join [dbo].[UserAddress] useraddress 
	on 
	useraddress.UserId=orderdetails.UserId 
	inner join 
	Payment payment on payment.PaymentId=orderdetails.PaymentId where orderdetails.UserId=@UserId 
RETURN
GO
PRINT N'Creating [dbo].[ViewFeedbackDetailsByAdmin]...';


GO
CREATE PROCEDURE [dbo].[ViewFeedbackDetailsByAdmin]
	
AS
	SELECT Rating,Feedback from [dbo].[Feedback]
RETURN
GO
PRINT N'Creating [dbo].[ViewOrderDetails]...';


GO
CREATE PROCEDURE [dbo].[ViewOrderDetails]
	@UserId int,
	@ProductId int
AS
	select OrderDate,Quantity,Amount from [dbo].[OrderDetails] o inner join [dbo].[Payment] p
on o.PaymentId=p.PaymentId where UserId=@UserId and ProductId=@ProductId
RETURN
GO
PRINT N'Creating [dbo].[ViewPaymentDetails]...';


GO
CREATE PROCEDURE [dbo].[ViewPaymentDetails]
	@PaymentType varchar = 20,
	@ProductId int,
	@UserId int
AS
	if(@PaymentType='DebitCard')
		select CardNumber,@PaymentType as PaymentType,Amount,Quantity from [dbo].[OrderDetails] o inner join 
		[dbo].[Payment] p on o.PaymentId=p.PaymentId where ProductId=@ProductId and UserId=@UserId
	else if(@PaymentType='CreditCard')
		select CardNumber,@PaymentType,Amount,Quantity from [dbo].[OrderDetails] o inner join 
		[dbo].[Payment] p on o.PaymentId=p.PaymentId where ProductId=@ProductId and UserId=@UserId
	else if(@PaymentType='CashOnDelivery')
		select Amount,Quantity from [dbo].[OrderDetails] o inner join [dbo].[Payment] p on o.PaymentId=p.PaymentId where ProductId=@ProductId
		and UserId=@UserId
RETUrN
GO
PRINT N'Creating [dbo].[ViewProducts]...';


GO
CREATE PROCEDURE [dbo].[ViewProducts]
	
AS
	SELECT * from [dbo].[Product]
RETURN
GO
PRINT N'Creating [dbo].[ViewProductsOnWishList]...';


GO
CREATE PROCEDURE [dbo].[ViewProductsOnWishList]
	@userId int
AS
	select * from [dbo].[Product] inner join WishList wishlist on product.ProductId=wishlist.ProductId and wishlist.UserId= @userId

RETURN
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'baaae907-6071-4fa6-8bab-984ffd88d203')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('baaae907-6071-4fa6-8bab-984ffd88d203')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '889ceffe-e5ed-45a2-849a-1af11c3c575d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('889ceffe-e5ed-45a2-849a-1af11c3c575d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '976971ba-3e46-4a8d-8c1d-134184264dfd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('976971ba-3e46-4a8d-8c1d-134184264dfd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a1512acb-2051-4c05-a52b-cdb1f0e12411')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a1512acb-2051-4c05-a52b-cdb1f0e12411')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'be4e50cb-49fb-44a1-92d4-c4b740c8941f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('be4e50cb-49fb-44a1-92d4-c4b740c8941f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f4b67a82-9673-466b-82f9-a80cb25284b1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f4b67a82-9673-466b-82f9-a80cb25284b1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3a36ba95-94ef-4bb4-b366-5e31085a3151')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3a36ba95-94ef-4bb4-b366-5e31085a3151')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1767e09f-043a-4f92-882f-b76daa2e4679')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1767e09f-043a-4f92-882f-b76daa2e4679')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0615ed0f-63c5-4905-a856-4f3eaaeaf71f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0615ed0f-63c5-4905-a856-4f3eaaeaf71f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '121d7c4e-360f-4d0e-b3fd-9ca7586e8e2f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('121d7c4e-360f-4d0e-b3fd-9ca7586e8e2f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fff0b906-81cb-4f09-8da8-4ecd9eb583e5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fff0b906-81cb-4f09-8da8-4ecd9eb583e5')

GO

GO
PRINT N'Update complete.';


GO