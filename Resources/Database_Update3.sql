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
	room_status numeric,
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
	booking_type numeric,
	total_payment float,
	constraint PK_BookingID Primary key (booking_id),
	constraint FK_Booking_RoomID Foreign key (room_id) references Room (room_id),
	constraint FK_Booking_HotelID Foreign key (hotel_id) references Hotel (hotel_id),
	constraint FK_Booking_CustomerID Foreign key (customer_id) references Customer (customer_id)
);

--add cus 
--create procedure addCus
--	@id int,
--	@name varchar(100),
--	@mobile int,
--	@email varchar(100)
--as
--begin 
--	insert into Customer values (@id, @name, @mobile, @email)
--end

----add room
--create procedure addRoom
--	@hotel_id varchar(50),
--	@room_id int,
--	@number varchar(50),
--	@type varchar(50),
--	@status numeric,
--	@price float

--as
--begin
--	if (@room_id <600 and @price=100) 
--		insert into [Bao].[Hotel_chain].[dbo].[Room] values (@hotel_id
--															,@room_id	 
--															,@number
--															,@type
--															,@status
--															,@price)
--begin 
--	if (@room_id >= 600 and @room_id<900 and @price =200)
--		insert into [Viet].[Hotel_chain].[dbo].[Room] values (@hotel_id
--															,@room_id	 
--															,@number
--															,@type
--															,@status
--															,@price)
--begin 
--	if (@room_id >900 and @price=300)
--		insert into [Hieu].[Hotel_chain].[dbo].[Room] values (@hotel_id
--															,@room_id	 
--															,@number
--															,@type
--															,@status
--															,@price)
--end
--end 
--end


----add booking 

--create procedure addBooking
--	@hotelid varchar(50),
--	@bookingid int,
--	@roomid int,
--	@customerid int,
--	@checkindate date,
--	@checkoutdate date,
--	@bookingtype numeric,
--	@totalpayment float
--as 
--begin
--	if (@bookingid <50000 and @roomid <600)
--		insert into [Bao].[Hotel_chain].[dbo].[Booking] values (@hotelid
--																, @bookingid
--																, @roomid
--																, @customerid
--																, @checkindate
--																, @checkoutdate
--																, @bookingtype
--																, @totalpayment)

--begin
--	if (50000<=@bookingid and @bookingid <90000 and @roomid >=600 and @roomid <900)
--		insert into [Viet].[Hotel_chain].[dbo].[Booking] values (@hotelid
--																, @bookingid
--																, @roomid
--																, @customerid
--																, @checkindate
--																, @checkoutdate
--																, @bookingtype
--																, @totalpayment)
--begin 
--	if (@bookingid >90000 and @roomid >=900)
--		insert into [Hieu].[Hotel_chain].[dbo].[Booking] values (@hotelid
--																, @bookingid
--																, @roomid
--																, @customerid
--																, @checkindate
--																, @checkoutdate
--																, @bookingtype
--																, @totalpayment)

--end 
--end 
--end 
----check booking

--create procedure action_booking
--	@roomStatus binary,
--	@hotelid varchar(50),
--	@bookingid int,
--	@roomid int,
--	@customerid int,
--	@checkindate date,
--	@checkoutdate date,
--	@bookingtype numeric,
--	@totalpayment float
--as 
--declare @check int 
--select @check = count (room_status) from Room where room_status =@roomStatus
--if (@check=1)
--		insert into Booking values (@hotelid
--									, @bookingid
--									, @roomid
--									, @customerid
--									, @checkindate
--									, @checkoutdate
--									, @bookingtype
--									, @totalpayment)															
--else 
--	begin 
--	print 'This room is not available'
--	end 

		
----payment 

--create procedure Pay 
--	@hotelid varchar(50),
--	@bookingid int,
--	@roomid int,
--	@customerid int,
--	@checkindate date,
--	@checkoutdate date,
--	@bookingtype numeric,
--	@totalpayment float

--as
--begin
--	update Booking
--	set total_payment  = (@checkoutdate-@checkindate)* (select R.room_price from Room R join 
--															  Booking B on R.room_id = B.room_id) 
--	update Room
--	set room_status =1
--end
	

-- insert values into table Hotel.

insert into Hotel (hotel_id, hotel_name, hotel_type, hotel_description)
	values ('025', 'New World', '5', 'VN');  
insert into Hotel (hotel_id, hotel_name, hotel_type, hotel_description)
	values ('050', 'Continental','4', 'USA');  
insert into Hotel (hotel_id, hotel_name, hotel_type, hotel_description)
	values ('075', 'Paradise', '3', 'ENG');  



-- insert into table Customer

insert into Customer (customer_id, customer_name, customer_mobile, customer_email)
	values ('0000001', 'Hoang Trong Viet', '15521009', 'HTViet@gmail.com');
insert into Customer (customer_id, customer_name, customer_mobile, customer_email)
	values ('0000002', 'Tran Gia Bao', '15520044', 'TGBao@gmail.com');
insert into Customer (customer_id, customer_name, customer_mobile, customer_email)
	values ('0000003', 'Dao Minh Hieu', '15520279', 'DMHieu@gmail.com');



-- insert values into table Room.
--- New World

insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0001', '025', 'A0001', 'Normal', '0', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0002', '025', 'A0002', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0003', '025', 'A0003', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0004', '025', 'A0004', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0005', '025', 'A0005', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0006', '025', 'A0006', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0600', '025', 'A0007', 'Business', '1', '200');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0601', '025', 'A0008', 'Business', '1', '200');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0900', '025', 'A0009', 'VIP', '1', '300');

--- Continental

insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0007', '050', 'A0001', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0008', '050', 'A0002', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0009', '050', 'A0003', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0602', '050', 'A0004', 'Business', '0', '200');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0603', '050', 'A0005', 'Business', '1', '200');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0901', '050', 'A0006', 'VIP', '1', '300');

--- Paradise

insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0010', '075', 'A0001', 'Normal', '1', '100');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0604', '075', 'A0002', 'Business', '1', '200');
insert into Room (room_id, hotel_id, room_number, room_type, room_status, room_price)
	values ('0902', '075', 'A0003', 'VIP', '0', '300');



		 
-- insert into table Booking.

insert into Booking (booking_id, room_id, hotel_id, customer_id, checkin_date, checkout_date, booking_type, total_payment)
	values ('000001', '0001', '025', '0000001', '05-26-2018', '05-30-2018', '0', '');
insert into Booking (booking_id, room_id, hotel_id, customer_id, checkin_date, checkout_date, booking_type, total_payment)
	values ('050000', '0602', '050', '0000002', '05-26-2018', '06-01-2018', '1', '');
insert into Booking (booking_id, room_id, hotel_id, customer_id, checkin_date, checkout_date, booking_type, total_payment)
	values ('090000', '0902', '075', '0000003', '05-26-2018', '05-28-2018', '1', '');