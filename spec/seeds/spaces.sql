CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  available_start date,
  available_end date,
  price int,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);