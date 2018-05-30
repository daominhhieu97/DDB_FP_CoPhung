create database bhv_hotelchain
use bhv_hotelchain

-- drop table Hotel
-- drop table Customer
-- drop table Room
-- drop table Booking


create table Hotel(
	hotel_id varchar(50) not null,
	hotel_name varchar(100) not null,
	hotel_type float,
	hotel_location varchar(max),
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
	room_id varchar(50) not null,
	room_type varchar(50),
	room_status numeric,
	room_price float,
	constraint PK_RoomID Primary key (room_id),
	constraint FK_Hotelid Foreign key (hotel_id) references Hotel (hotel_id)
);

create table Booking(
	hotel_id varchar(50) not null,
	booking_id int not null,
	room_id varchar(50) not null,
	customer_id int not null,
	checkin_date date,
	checkout_date date,
	booking_type numeric,
	total_payment float,
	constraint PK_BookingID Primary key (booking_id),
	constraint FK_Booking_RoomID Foreign key (room_id) references Room (room_id),
	constraint FK_Booking_CustomerID Foreign key (customer_id) references Customer (customer_id)
);

--procedure hotel 
--add hotel 
drop procedure 
create procedure addHotel 
	@hotel_id varchar(50),
	@hotel_name varchar(100),
	@hotel_type float,
	@hotel_location varchar(max)
as 
begin
if @hotel_location ='VN%'
		begin  
		insert into [dbo].[Hotel] values (@hotel_id
															,@hotel_name
															,@hotel_type
															,@hotel_location)
		end
 
	else if @hotel_location ='US'
	begin
		insert into [VIET].[bhv_hotelchain].[dbo].[Hotel] values (@hotel_id
															,@hotel_name
															,@hotel_type
															,@hotel_location)
	end
 
	else if @hotel_location = 'UK'
		begin 
		insert into [HIEU].[bhv_hotelchain].[dbo].[Hotel] values (@hotel_id
															,@hotel_name
															,@hotel_type
															,@hotel_location)
		end
end 


--update hotel 
create procedure edit_hotel
	@hotel_id varchar(50),
	@hotel_name varchar(100),
	@hotel_type float,
	@hotel_location varchar(max)
as
begin
	update [dbo].[Hotel] set 
		hotel_id = @hotel_id, 
		hotel_name= @hotel_name, 
		hotel_type = @hotel_type, 
		hotel_location = @hotel_location
	where hotel_id = @hotel_id
end
	
--procedure Customer
--add cus 
drop procedure addCus

create procedure addCus
	@id int,
	@name varchar(100),
	@mobile int,
	@email varchar(100)
as
begin 
	insert into [dbo].[Customer] values (@id, @name, @mobile, @email)
end

exec addCus 
--update cus:
drop procedure update_Cus

create procedure update_Cus
	@id int,
	@name varchar(100),
	@mobile int,
	@email varchar(100)
as
begin 
	update [dbo].[Customer]  set 
	customer_name = @name,
	customer_mobile= @mobile,
	customer_email = @email
	where customer_id = @id
end


--procedure Room
--add room
drop procedure addRoom

create procedure addRoom
	@hotel_id varchar(50),
	@room_id varchar(50),
	@type varchar(50),
	@status numeric,
	@price float
as
begin
	if @hotel_id ='VN%'
		begin  
		insert into [dbo].[Room] values (@hotel_id
															,@room_id
															,@type
															,@status
															,@price)
		end
 
	else if @hotel_id ='US'
	begin
		insert into [VIET].[bhv_hotelchain].[dbo].[Room] values (@hotel_id
															,@room_id
															,@type
															,@status
															,@price)
	end
 
	else if @hotel_id = 'UK'
		begin 
		insert into [HIEU].[bhv_hotelchain].[dbo].[Room] values (@hotel_id
															,@room_id
															,@type
															,@status
															,@price)
		end
end 

--update room 
drop procedure Update_room

create procedure Update_room 
	@hotel_id varchar(50),
	@room_id varchar(50),
	@type varchar(50),
	@status numeric,
	@price float
as
begin 
	update [dbo].Room set
	hotel_id = @hotel_id,
	room_id = @room_id,
	room_type = @type, 
	room_status = @status, 
	room_price = @price
	where room_id = @room_id
end



--procedure Booking
--add booking 
drop procedure addBooking

create procedure addBooking
	@hotelid varchar(50),
	@bookingid int,
	@roomid varchar(50),
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype numeric,
	@totalpayment float
as
begin
		insert into [dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)
	update Room
	set room_status = 0
end 


--check booking
drop procedure action_booking

create procedure action_booking
	@hotelid varchar(50),
	@bookingid int,
	@roomid varchar(50),
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype numeric,
	@totalpayment float
as 
begin
	declare @check int 
	select @check= Room_status from [bhv_hotelchain].Room where @roomid = Room.room_id
	if (@check=1)
			exec addBooking @hotelid, @bookingid, @roomid, @customerid,
		@checkindate ,
		@checkoutdate ,
		@bookingtype ,
		@totalpayment													
	else 
		begin 
		print 'This room is not available'
		end 

end

		
--payment 
drop procedure Pay

create procedure Pay 
	@hotelid varchar(50),
	@bookingid int,
	@roomid varchar(50),
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype numeric,
	@totalpayment float
as
begin
	update [dbo].[Booking]
	set total_payment  =  datediff(d, @checkindate, @checkoutdate) * (select R.room_price from [dbo].[Room] R join 
															  Booking B on R.room_id = B.room_id) 
	update Room
	set room_status = 1
end

