
/* Drop tables */

if exists (select 1
            from  sysobjects
           where  id = object_id('Join_RewardEarnPoints')
            and   type = 'U')
   drop table Join_RewardEarnPoints
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Join_ItemIngredientUsage')
            and   type = 'U')
   drop table Join_ItemIngredientUsage
go

if exists (select 1
            from  sysobjects
           where  id = object_id('OrderDetail')
            and   type = 'U')
   drop table OrderDetail
go

if exists (select 1
            from  sysobjects
           where  id = object_id('InventoryBatch')
            and   type = 'U')
   drop table InventoryBatch
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ShiftManagement')
            and   type = 'U')
   drop table ShiftManagement
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EmployeeWorkSchedule')
            and   type = 'U')
   drop table EmployeeWorkSchedule
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RewardAccount')
            and   type = 'U')
   drop table RewardAccount
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Orders')
            and   type = 'U')
   drop table Orders
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MenuItems')
            and   type = 'U')
   drop table MenuItems
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Customer')
            and   type = 'U')
   drop table Customer
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Employee')
            and   type = 'U')
   drop table Employee
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Supplier')
            and   type = 'U')
   drop table Supplier
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Ingredients')
            and   type = 'U')
   drop table Ingredients
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MenuItemTypes')
            and   type = 'U')
   drop table MenuItemTypes
go

/* CREATE tables*/
create table Customer
(
    CustomerID      uniqueidentifier    not null,
    FirstName       varchar(50)         not null,
    LastName        varchar(50)         not null,
    PhoneNumber     varchar(20)         not null,
    EmailAddress    varchar(100)        not null,
    constraint PK_CUSTOMER primary key (CustomerID)
)
go

create table Employee
(
    EmployeeID      uniqueidentifier    not null,
    FirstName       varchar(50)         not null,
    LastName        varchar(50)         not null,
    PhoneNumber     varchar(20)         not null,
    Position        varchar(50)         not null,
    HireDate        Datetime            not null,
    constraint PK_EMPLOYEE primary key (EmployeeID)
)
go

create table Supplier
(
    SupplierID      uniqueidentifier    not null,
    SupplierName    varchar(100)        not null,
    PhoneNumber     varchar(20)         not null,
    EmailAddress    varchar(100)        not null,
    Address         varchar(150)        not null,
    City            varchar(20)         not null,
    State           varchar(2)          not null,
    ZipCode         varchar(10)         not null,
    constraint PK_SUPPLIER primary key (SupplierID)
)
go

create table Ingredients
(
      IngredientID    uniqueidentifier    not null,
      IngredientName  varchar(50)         not null,
      constraint PK_INGREDIENTS primary key (IngredientID)
)
go

create table MenuItemTypes
(
      MenuItemTypeID  uniqueidentifier    not null,
      TypeName        varchar(50)         not null,
      constraint PK_MENUITEMTYPES primary key (MenuItemTypeID)
)
go

create table RewardAccount
(
      RewardID         uniqueidentifier    not null,
      CustomerID       uniqueidentifier    not null,
      CurrentPoints    int                 not null,
      MemberSince      Date                not null,
      constraint PK_REWARDACCOUNT primary key (RewardID),
)
go

create table Orders
(
      OrderID         uniqueidentifier    not null,
      CustomerID      uniqueidentifier    not null,
      EmployeeID      uniqueidentifier    not null,
      OrderDate       Datetime            not null,
      TotalAmount     decimal(10, 2)      not null,
      constraint PK_ORDERS primary key (OrderID)
)
go

create table ShiftManagement
(
      ShiftID         uniqueidentifier    not null,
      EmployeeID      uniqueidentifier    not null,
      ShiftDate       Date                not null,
      ClockIn         Datetime            not null,
      ClockOut        Datetime            null,
      constraint PK_SHIFTMANAGEMENT primary key (ShiftID)
)
go

create table EmployeeWorkSchedule
(
      ScheduleID      uniqueidentifier    not null,
      EmployeeID      uniqueidentifier    not null,
      WorkDate        Date                not null,
      StartShift1     Time                not null,
      EndShift1       Time                not null,
      StartShift2     Time                null,
      EndShift2       Time                null,
      constraint PK_EMPLOYEEWORKSCHEDULE primary key (ScheduleID)
)
go

create table InventoryBatch
(
      BatchID         uniqueidentifier    not null,
      IngredientID    uniqueidentifier    not null,
      SupplierID      uniqueidentifier    not null,
      Quantity        int                 not null,
      ReceivedDate    Date                not null,
      ExpirationDate  Date                not null,
      UnitCost       decimal(10, 2)       not null,
      constraint PK_INVENTORYBATCH primary key (BatchID)
)
go 

create table MenuItems
(
      ItemID         uniqueidentifier    not null,
      MenuItemTypeID  uniqueidentifier   not null,
      ItemName        varchar(50)        not null,
      Price           decimal(10, 2)     not null,
      constraint PK_MENUITEMS primary key (ItemID)
)
go

create table OrderDetail
(
      OrderDetailID   uniqueidentifier    not null,
      OrderID         uniqueidentifier    not null,
      ItemID          uniqueidentifier    not null,
      Quantity        int                 not null,
      constraint PK_ORDERDETAIL primary key (OrderDetailID)
)
go 

create table Join_RewardEarnPoints
(
      OrderID          uniqueidentifier    not null,
      RewardID         uniqueidentifier    not null,
      PointEarned      int                 not null,
      TransactionDate  Datetime            not null,
      constraint PK_JOIN_REWARDEARNPOINTS primary key (OrderID)
)
go

create table Join_ItemIngredientUsage
(
      ItemID          uniqueidentifier    not null,
      IngredientID    uniqueidentifier    not null,
      QuantityInML    int                 null,
      QuantityInGram  int                 null,
      constraint PK_JOIN_ITEMINGREDIENTUSAGE primary key (ItemID, IngredientID)
)
go

/* TABLE ALTER RewardAccount */   

alter table RewardAccount
add constraint FK_RewardAccount_Customer foreign key (CustomerID) 
      references Customer(CustomerID)
go

/* TABLE ALTER Orders */   
alter table Orders 
add constraint FK_Orders_Customer foreign key (CustomerID) 
      references Customer(CustomerID)
go

alter table Orders
add constraint FK_Orders_Employee foreign key (EmployeeID) 
      references Employee(EmployeeID)
go

/* TABLE ALTER ShiftManagement */   
alter table ShiftManagement
add constraint FK_ShiftManagement_Employee foreign key (EmployeeID) 
      references Employee(EmployeeID)
go

/* TABLE ALTER EmployeeWorkSchedule */
alter table EmployeeWorkSchedule
add constraint FK_EmployeeWorkSchedule_Employee foreign key (EmployeeID) 
      references Employee(EmployeeID)
go

/* TABLE ALTER InventoryBatch */
alter table InventoryBatch
add constraint FK_InventoryBatch_Ingredients foreign key (IngredientID) 
      references Ingredients(IngredientID)
go

alter table InventoryBatch
add constraint FK_InventoryBatch_Supplier foreign key (SupplierID) 
      references Supplier(SupplierID)
go

/* TABLE ALTER MenuItems */
alter table MenuItems
add constraint FK_MenuItems_MenuItemTypes foreign key (MenuItemTypeID) 
      references MenuItemTypes(MenuItemTypeID)
go

/* TABLE ALTER OrderDetail */
alter table OrderDetail
add constraint FK_OrderDetail_Orders foreign key (OrderID) 
      references Orders(OrderID)
go

alter table OrderDetail
add constraint FK_OrderDetail_MenuItems foreign key (ItemID) 
      references MenuItems(ItemID)
go

/* TABLE ALTER Join_RewardEarnPoints */
alter table Join_RewardEarnPoints
add constraint FK_Join_RewardEarnPoints_Orders foreign key (OrderID) 
      references Orders(OrderID)
go

alter table Join_RewardEarnPoints
add constraint FK_Join_RewardEarnPoints_RewardAccount foreign key (RewardID) 
      references RewardAccount(RewardID)
go

/* TABLE ALTER Join_ItemIngredientUsage */
alter tabble Join_ItemIngredientUsage
add constraint FK_Join_ItemIngredientUsage_MenuItems foreign key (ItemID) 
      references MenuItems(ItemID)
go

alter table Join_ItemIngredientUsage
add constraint FK_Join_ItemIngredientUsage_Ingredients foreign key (IngredientID) 
      references Ingredients(IngredientID)
go

