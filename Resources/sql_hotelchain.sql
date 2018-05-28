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
	--constraint FK_Room_HotelID Foreign key (hotel_id) references Hotel (hotel_id)
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
	--constraint FK_Booking_HotelID Foreign key (hotel_id) references Hotel (hotel_id),
	constraint FK_Booking_CustomerID Foreign key (customer_id) references Customer (customer_id)
);

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
	customer_name =@name,
	customer_mobile= @mobile,
	customer_email =@email
	where customer_id = @id
end
select * from [dbo].[Room]
--add room
drop procedure addRoom

create procedure addRoom
	@hotel_id varchar(50),
	@room_id int,
	@number varchar(50),
	@type varchar(50),
	@status numeric,
	@price float
as
begin
	if @room_id <600
		begin  
		insert into [dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
		end
 
	else if @room_id >= 600 and @room_id<900
	begin
		insert into [VIET].[bhv_hotelchain].[dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
	end
 
	else if @room_id >=900
		begin 
		insert into [HIEU].[bhv_hotelchain].[dbo].[Room] values (@hotel_id
															,@room_id	 
															,@number
															,@type
															,@status
															,@price)
		end
end 



--add booking 
drop procedure addBooking
create procedure addBooking
	@hotelid varchar(50),
	@bookingid int,
	@roomid int,
	@customerid int,
	@checkindate date,
	@checkoutdate date,
	@bookingtype numeric,
	@totalpayment float
as 
begin
	if @bookingid <50000 and @roomid <600
		insert into [dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)


	if 50000<=@bookingid and @bookingid <90000 and @roomid >=600 and @roomid <900
		insert into [VIET].[bhv_hotelchain].[dbo].[Booking] values (@hotelid
																, @bookingid
																, @roomid
																, @customerid
																, @checkindate
																, @checkoutdate
																, @bookingtype
																, @totalpayment)
 
	if (@bookingid >90000 and @roomid >=900)
		insert into [HIEU].[bhv_hotelchain].[dbo].[Booking] values (@hotelid
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
	@roomid int,
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




--update room 
create procedure Update_room 
	@hotel_id varchar(50),
	@room_id int,
	@number varchar(50),
	@type varchar(50),
	@status numeric,
	@price float
as
begin 
	update [dbo].Room set
	hotel_id = @hotel_id,
	room_id = @room_id,
	room_number = @number, 
	room_type = @type, 
	room_status = @status, 
	room_price = @price
	where room_id = @room_id
end
		
--payment 
drop procedure Pay
create procedure Pay 
	@hotelid varchar(50),
	@bookingid int,
	@roomid int,
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


select * from hotel

select *from Room

select * from Customer

select * from Booking

exec addRoom '0009', '050', 'A0003', 'Normal', '1', '100'
select * from [VIET].[bhv_hotelchain].[dbo].[Room]


exec addRoom '025', '405', 'A0003', 'Normal', '1', '100'

exec addCus '0000001', 'Hoang Trong Viet', '15521009', 'HTViet@gmail.com'
exec addBooking '000001', '0001', '025', '0000001', '05-26-2018', '05-30-2018', '0', ''
exec addBooking '025','000001','405','0000001','05-26-2018', '05-30-2018', '1', ''
exec Pay '025','000001','405','0000001','05-26-2018', '05-30-2018', '0', ''
