-- drop table Hotel
-- drop table Customer
-- drop table Room
-- drop table Booking


create table Hotel(
	hotel_id varchar(50) not null,
	hotel_name varchar(100) not null,
	hotel_type float,
	hotel_description varchar(max),
	constraint PK_HotelID Primary key (hotel_id)
);


create table Customer(
	customer_id int not null,
	customer_name varchar(100) not null,
	customer_mobile int,
	customer_email varchar(100),
	constraint PK_CustomerID Primary key (customer_id)
);


create table Room(
	hotel_id varchar(50) not null,
	room_id int not null,
	room_number varchar(50) not null,
	room_type varchar(50),
	room_status binary,
	room_price float,
	constraint PK_RoomID Primary key (room_id),
	constraint FK_Room_HotelID Foreign key (hotel_id) references Hotel (hotel_id)
);

create table Booking(
	hotel_id varchar(50) not null,
	booking_id int not null,
	room_id int not null,
	customer_id int not null,
	checkin_date date,
	checkout_date date,
	booking_type binary,
	total_payment float,
	constraint PK_BookingID Primary key (booking_id),
	constraint FK_Booking_RoomID Foreign key (room_id) references Room (room_id),
	constraint FK_Booking_HotelID Foreign key (hotel_id) references Hotel (hotel_id),
	constraint FK_Booking_CustomerID Foreign key (customer_id) references Customer (customer_id)
);

--add cus 
create procedure addCus
	@id int,
	@name varchar(100),
	@mobile int,
	@email varchar(100)
as
begin 
	insert into Customer values (@id, @name, @mobile, @email)
end

--add room
create procedure addRoom
	@hotel_id varchar(50),
	@room_id int,
	@number varchar(50),
	@type varchar(50),
	@status binary,
	@price float

as
begin
	if (@room_id <600 and @price=100) 
		insert into [Bao].[Hotel_chain].[dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
begin 
	if (@room_id >= 600 and @room_id<900 and @price =200)
		insert into [Viet].[Hotel_chain].[dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
begin 
	if (@room_id >900 and @price=300)
		insert into [Hieu].[Hotel_chain].[dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
end
end 
end


--add booking 

create procedure addBooking
	@hotelid varchar(50),
	@bookingid int,
	@roomid int,
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype binary,
	@totalpayment float
as 
begin
	if (@bookingid <50000 and @roomid <600)
		insert into [Bao].[Hotel_chain].[dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)

begin
	if (50000<=@bookingid and @bookingid <90000 and @roomid >=600 and @roomid <900)
		insert into [Viet].[Hotel_chain].[dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)
begin 
	if (@bookingid >90000 and @roomid >=900)
		insert into [Hieu].[Hotel_chain].[dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)

end 
end 
end 
--check booking

create procedure action_booking
	@roomStatus binary,
	@hotelid varchar(50),
	@bookingid int,
	@roomid int,
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype binary,
	@totalpayment float
as 
declare @check int 
select @check = count (room_status) from Room where room_status =@roomStatus
if (@check=1)
		insert into Booking values (@hotelid
									, @bookingid
									, @roomid
									, @customerid
									, @checkindate
									, @checkoutdate
									, @bookingtype
									, @totalpayment)															
else 
	begin 
	print 'This room is not available'
	end 

		
--payment 

create procedure Pay 
	@hotelid varchar(50),
	@bookingid int,
	@roomid int,
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype binary,
	@totalpayment float

as
begin
	update Booking
	set total_payment  = (@checkoutdate-@checkindate)* (select R.room_price from Room R join 
															  Booking B on R.room_id = B.room_id) 
	update Room
	set room_status =1
end
	