-- 1. HOTEL — Отели

CREATE TABLE hotel (
    hotel_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    stars INTEGER CHECK (stars BETWEEN 1 AND 5),
    rating NUMERIC(3,1)
);

-- 2. ROOM — Номера

CREATE TABLE room (
    room_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    hotel_id INTEGER NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INTEGER NOT NULL CHECK (capacity > 0),

    CONSTRAINT fk_room_hotel
        FOREIGN KEY (hotel_id)
        REFERENCES hotel(hotel_id),

    CONSTRAINT uq_room_hotel_number
        UNIQUE (hotel_id, room_number)
);

-- 3. CLIENT — Клиенты

CREATE TABLE client (
    client_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 4. RATE_PLAN — Тарифные планы

CREATE TABLE rate_plan (
    rate_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price > 0),
    is_refundable BOOLEAN NOT NULL,
    cancellation_policy TEXT,

    CONSTRAINT fk_rate_plan_room
        FOREIGN KEY (room_id)
        REFERENCES room(room_id)
);

-- 5. BOOKING — Бронирования

CREATE TABLE booking (
    booking_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id INTEGER NOT NULL,
    rate_id INTEGER NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    total_price NUMERIC(10,2) NOT NULL CHECK (total_price > 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_booking_client
        FOREIGN KEY (client_id)
        REFERENCES client(client_id),

    CONSTRAINT fk_booking_rate
        FOREIGN KEY (rate_id)
        REFERENCES rate_plan(rate_id),

    CONSTRAINT chk_booking_dates
        CHECK (check_out > check_in)
);

-- 6. PAYMENT — Платежи

CREATE TABLE payment (
    payment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    status VARCHAR(30) NOT NULL,
    payment_method VARCHAR(50),
    paid_at TIMESTAMP,

    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);

-- 7. GUEST — Гости

CREATE TABLE guest (
    guest_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    passport VARCHAR(30) NOT NULL,

    CONSTRAINT fk_guest_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking(booking_id)
);

