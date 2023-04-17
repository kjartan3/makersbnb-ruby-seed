CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  reservation_date date,
  status text,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade,
  space_id int,
  constraint fk_space foreign key(space_id)
    references spaces(id)
    on delete cascade
);