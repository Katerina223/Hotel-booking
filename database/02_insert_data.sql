-- 1. HOTEL — Отели

INSERT INTO hotel (name, city, address, stars, rating)
VALUES
('Grand Hotel', 'Москва', 'ул. Тверская, 10', 5, 9.2),
('Sea View Resort', 'Сочи', 'ул. Морская, 15', 4, 8.8),
('Central Plaza', 'Санкт-Петербург', 'Невский проспект, 25', 4, 9.0);

-- 2. ROOM — Номера

INSERT INTO room (hotel_id, room_number, room_type, capacity)
VALUES
(1, '101', 'Standard', 2),
(1, '102', 'Deluxe', 2),
(2, '201', 'Standard', 2),
(2, '202', 'Family', 4),
(3, '301', 'Standard', 2),
(3, '302', 'Suite', 3);

-- 3. CLIENT — Клиенты

INSERT INTO client (full_name, email, phone)
VALUES
('Иванов Иван Иванович', 'ivanov@mail.ru', '+79991111111'),
('Петрова Анна Сергеевна', 'petrova@mail.ru', '+79992222222'),
('Сидоров Алексей Олегович', 'sidorov@mail.ru', '+79993333333');

-- 4. RATE_PLAN — Тарифные планы

INSERT INTO rate_plan
    (room_id, name, price, is_refundable, cancellation_policy)
VALUES
(1, 'Standard Basic', 10000, FALSE, 'Без возврата'),
(1, 'Standard Flexible', 12000, TRUE, 'Возврат за 3 дня'),
(2, 'Deluxe Standard', 20000, TRUE, 'Возврат за 5 дней'),
(3, 'Sea View Basic', 15000, FALSE, 'Без возврата'),
(4, 'Family Flexible', 25000, TRUE, 'Возврат за 7 дней'),
(6, 'Suite Premium', 30000, TRUE, 'Возврат за 5 дней');

-- 5. BOOKING — Бронирования

INSERT INTO booking
    (client_id, rate_id, check_in, check_out,
     status, total_price)
VALUES
(1, 1, '2026-12-01', '2026-12-05', 'confirmed', 20000),
(2, 3, '2026-12-02', '2026-12-07', 'confirmed', 40000),
(3, 4, '2026-12-10', '2026-12-13', 'pending', 15000),
(1, 6, '2026-12-15', '2026-12-20', 'confirmed', 35000),
(2, 2, '2026-12-20', '2026-12-23', 'cancelled', 18000),
(1, 5, '2027-01-05', '2027-01-10', 'confirmed', 25000),
(2, 6, '2027-01-10', '2027-01-14', 'pending', 32000),
(3, 1, '2027-02-01', '2027-02-04', 'confirmed', 15000);

