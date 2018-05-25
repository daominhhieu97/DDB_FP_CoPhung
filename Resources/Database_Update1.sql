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





