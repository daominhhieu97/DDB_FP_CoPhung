-- drop table Hotel_Attributes
-- drop table Room_Attributes
-- drop table Customers_Attributes
-- drop table Booking_Attributes


create table Hotel_Attributes(
	hotel_id varchar(50) not null,
	hotel_name varchar(100) not null,
	hotel_type float,
	hotel_description varchar(max),
	hotel_location varchar(max),
	hotel_budget float,
	constraint PK_Hotel_Attributes Primary key (hotel_id)
);

create table Room_Attributes(
	room_id varchar(50) not null,
	hotel_id varchar(50) not null,
	room_number varchar(50) not null,
	room_type varchar(50),
	room_description varchar(max),
	hotel_location varchar(max),
	constraint PK_Room_Attributes Primary key (room_id),
	constraint FK_Room_Attributes_hotelID Foreign key (hotel_id) references Hotel_Attributes (hotel_id)
);

create table Customers_Attributes(
	customer_id varchar(50) not null,
	customer_name varchar(100) not null,
	customer_mobile varchar(20),
	customer_email varchar(100),
	constraint PK_Customer_Attributes Primary key (customer_id)
);

create table Booking_Attributes(
	booking_id varchar(50) not null,
	room_id varchar(50) not null,
	hotel_id varchar(50) not null,
	customer_id varchar(50) not null,
	checkin_date datetime,
	checkout_date datetime,
	booking_type varchar(50),
	booking_description varchar(max),
	total_price float,
	constraint PK_Booking_Attributes Primary key (booking_id),
	constraint FK_Booking_Attributes_roomID Foreign key (room_id) references Room_Attributes (room_id),
	constraint FK_Booking_Attributes_hotelID Foreign key (hotel_id) references Hotel_Attributes (hotel_id),
	constraint FK_Booking_Attributes_customerID Foreign key (customer_id) references Customers_Attributes (customer_id)
);


--insert hotel:

CREATE PROCEDURE isHotel
	@hotelid varchar(50),
	@hotelname varchar(100),
	@hoteltype float,
	@hoteldescription varchar(max),
	@hotellocation varchar(max),
	@hotelbudget float
as
begin
	insert into [DBL_M01].[DISTRICT01].[dbo].[Hotel_Attributes]
	values (@hotelid, @hotelname,@hoteltype, @hoteldescription, @hotellocation, @hotelbudget)
begin
	if @hotelbudget >=100000
		insert into [DBL_M02].[DISTRICT02].[dbo].[Hotel_Attributes]
		values (@hotelid, @hotelname,@hoteltype, @hoteldescription, @hotellocation, @hotelbudget)
begin
	if @hotellocation ='District 1'
		insert into [DBL_M03].[DISTRICT03].[dbo].[Hotel_Attributes]
		values (@hotelid, @hotelname,@hoteltype, @hoteldescription, @hotellocation, @hotelbudget)
end
end
end

--insert booking
create procedure isBooking
	@bookingid varchar(50),
	@roomid varchar(50),
	@hotelid varchar(50),
	@customerid varchar(50),
	@checkindate datetime,
	@checkoutdate datetime,
	@bookingtype varchar(50),
	@bookingdescription varchar(max),
	@totalprice float
as 
declare @dem varchar
begin 
	insert into 
	




