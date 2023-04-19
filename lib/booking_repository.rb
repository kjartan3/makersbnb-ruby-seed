require_relative 'booking'

class BookingRepository
  def all
    bookings = []
  
    sql = 'SELECT id, reservation_date, status, user_id, space_id FROM bookings;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      booking = Booking.new
      booking.id = record['id']
      booking.reservation_date = record['reservation_date']
      booking.status = record['status']
      booking.user_id = record['user_id']
      booking.space_id = record['space_id']

      bookings << booking
    end
    return bookings
  end

  def find(id)
    sql = 'SELECT id, reservation_date, status, user_id, space_id FROM bookings WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])

    booking = Booking.new

    booking.id = result_set[0]['id']
    booking.reservation_date = result_set[0]['reservation_date']
    booking.status = result_set[0]['status']
    booking.user_id = result_set[0]['user_id']
    booking.space_id = result_set[0]['space_id']

    return booking
  end

  def create(booking)
    sql = 'INSERT INTO bookings (reservation_date, status, user_id, space_id) VALUES ($1, $2, $3, $4);'
    result_set = DatabaseConnection.exec_params(sql, [booking.reservation_date, booking.status, booking.user_id, booking.space_id])

    return booking
  end
end


  