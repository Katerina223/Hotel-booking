-- 1. Агрегатные функции (Подсчёт количества бронирований, общей и средней стоимости)

SELECT
    COUNT(booking_id) AS bookings_count,
    SUM(total_price) AS total_amount,
    AVG(total_price) AS average_amount
FROM booking;

-- 2. JOIN между тремя таблицами (Получение информации о бронированиях, тарифах и номерах)

SELECT
    booking.booking_id,
    booking.check_in,
    booking.check_out,
    booking.status,
    booking.total_price,
    rate_plan.name AS rate_name,
    rate_plan.price AS rate_price,
    room.room_number,
    room.room_type
FROM booking
JOIN rate_plan
    ON booking.rate_id = rate_plan.rate_id
JOIN room
    ON rate_plan.room_id = room.room_id;

-- 3. GROUP BY (Подсчёт количества бронирований для каждого отеля)

SELECT
    hotel.hotel_id,
    hotel.name AS hotel_name,
    hotel.city,
    COUNT(booking.booking_id) AS bookings_count
FROM hotel
JOIN room
    ON hotel.hotel_id = room.hotel_id
JOIN rate_plan
    ON room.room_id = rate_plan.room_id
JOIN booking
    ON rate_plan.rate_id = booking.rate_id
GROUP BY
    hotel.hotel_id,
    hotel.name,
    hotel.city
ORDER BY bookings_count DESC;

-- 4. Вложенный запрос (Поиск тарифных планов, стоимость которых выше средней)

SELECT
    rate_id,
    room_id,
    name,
    price,
    is_refundable
FROM rate_plan
WHERE price > (
    SELECT AVG(price)
    FROM rate_plan
);

-- 5. Условный оператор CASE WHEN (Определение состояния бронирования)

SELECT
    booking_id,
    client_id,
    rate_id,
    total_price,
    status,
    CASE
        WHEN status = 'confirmed'
            THEN 'Бронирование подтверждено'
        WHEN status = 'pending'
            THEN 'Ожидает подтверждения'
        WHEN status = 'cancelled'
            THEN 'Бронирование отменено'
        ELSE 'Неизвестный статус'
    END AS status_description
FROM booking;

