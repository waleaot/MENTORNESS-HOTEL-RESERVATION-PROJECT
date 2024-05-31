# MENTORNESS-HOTEL-RESERVATION-PROJECT
# Hotel Reservations Data Analysis - README

## Project Overview
This project involves analyzing a hotel reservations dataset using PostgreSQL. The dataset contains information about hotel bookings, including guest details, booking details, and reservation statuses. The analysis aims to derive insights into various aspects of hotel reservations, such as popular meal plans, average prices, common room types, and more.

## Dataset Description
The dataset includes the following columns:

1. **Booking_ID**: A unique identifier for each hotel reservation.
2. **no_of_adults**: The number of adults in the reservation.
3. **no_of_children**: The number of children in the reservation.
4. **no_of_weekend_nights**: The number of nights in the reservation that fall on weekends.
5. **no_of_week_nights**: The number of nights in the reservation that fall on weekdays.
6. **type_of_meal_plan**: The meal plan chosen by the guests.
7. **room_type_reserved**: The type of room reserved by the guests.
8. **lead_time**: The number of days between booking and arrival.
9. **arrival_date**: The date of arrival.
10. **market_segment_type**: The market segment to which the reservation belongs.
11. **avg_price_per_room**: The average price per room in the reservation.
12. **booking_status**: The status of the booking.

## Analysis Insights
The analysis covers the following key questions:

1. **Total Number of Reservations**:
   - Query: `SELECT COUNT(*) FROM reservations;`

2. **Most Popular Meal Plan**:
   - Query: `SELECT type_of_meal_plan, COUNT(*) AS count FROM reservations GROUP BY type_of_meal_plan ORDER BY count DESC LIMIT 1;`

3. **Average Price per Room for Reservations Involving Children**:
   - Query: `SELECT AVG(avg_price_per_room) FROM reservations WHERE no_of_children > 0;`

4. **Number of Reservations for the Year 20XX**:
   - Replace `20XX` with the desired year.
   - Query: `SELECT COUNT(*) FROM reservations WHERE EXTRACT(YEAR FROM arrival_date) = 20XX;`

5. **Most Commonly Booked Room Type**:
   - Query: `SELECT room_type_reserved, COUNT(*) AS count FROM reservations GROUP BY room_type_reserved ORDER BY count DESC LIMIT 1;`

6. **Reservations Falling on a Weekend**:
   - Query: `SELECT COUNT(*) FROM reservations WHERE no_of_weekend_nights > 0;`

7. **Highest and Lowest Lead Time for Reservations**:
   - Query (Highest): `SELECT MAX(lead_time) FROM reservations;`
   - Query (Lowest): `SELECT MIN(lead_time) FROM reservations;`

8. **Most Common Market Segment Type**:
   - Query: `SELECT market_segment_type, COUNT(*) AS count FROM reservations GROUP BY market_segment_type ORDER BY count DESC LIMIT 1;`

9. **Reservations with Booking Status "Confirmed"**:
   - Query: `SELECT COUNT(*) FROM reservations WHERE booking_status = 'Confirmed';`

10. **Total Number of Adults and Children Across All Reservations**:
    - Query: `SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children FROM reservations;`

11. **Average Number of Weekend Nights for Reservations Involving Children**:
    - Query: `SELECT AVG(no_of_weekend_nights) FROM reservations WHERE no_of_children > 0;`

12. **Number of Reservations Made in Each Month**:
    - Query: `SELECT EXTRACT(MONTH FROM arrival_date) AS month, COUNT(*) AS count FROM reservations GROUP BY month ORDER BY month;`

13. **Average Number of Nights (Weekend and Weekday) Spent by Guests for Each Room Type**:
    - Query: `SELECT room_type_reserved, AVG(no_of_weekend_nights + no_of_week_nights) AS avg_nights FROM reservations GROUP BY room_type_reserved;`

14. **Most Common Room Type for Reservations Involving Children and Average Price for That Room Type**:
    - Query: 
      ```sql
      WITH child_reservations AS (
        SELECT room_type_reserved, AVG(avg_price_per_room) AS avg_price, COUNT(*) AS count
        FROM reservations
        WHERE no_of_children > 0
        GROUP BY room_type_reserved
      )
      SELECT room_type_reserved, avg_price
      FROM child_reservations
      ORDER BY count DESC
      LIMIT 1;
      ```

15. **Market Segment Type That Generates the Highest Average Price per Room**:
    - Query: `SELECT market_segment_type, AVG(avg_price_per_room) AS avg_price FROM reservations GROUP BY market_segment_type ORDER BY avg_price DESC LIMIT 1;`

## Getting Started
To run the analysis on your local machine, follow these steps:

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/your-username/hotel-reservations-analysis.git
   cd hotel-reservations-analysis
   ```

2. **Set Up PostgreSQL Database**:
   - Install PostgreSQL.
   - Create a new database.
   - Import the dataset into the database.

3. **Execute SQL Queries**:
   - Use your preferred SQL client to connect to the PostgreSQL database.
   - Run the provided SQL queries to derive insights.

## Dependencies
- PostgreSQL
- SQL Client (e.g., pgAdmin, DBeaver, or any other SQL IDE)

## Contributions
Contributions to this project are welcome. If you have any suggestions or improvements, please create a pull request or open an issue.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For any inquiries or further information, please contact [herdeymie@gmail.com](mailto:herdeymie@gmail.com).
