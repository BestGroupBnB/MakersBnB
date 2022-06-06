$:.unshift File.join(File.dirname(__FILE__), 'lib')
require "database_connection"

# This file sets up the database tables. If you change any of the contents
# of this file, you should rerun `ruby reset_tables.rb` to ensure that your
# database tables are re-created.

# # Create the databases and set up the tables
# ; createdb bestgroupbnb_dev
# ; createdb bestgroupbnb_test
# ; ruby reset_tables.rb
# ; change in app.rb, reset_tables.rb

def reset_tables(db)

  db.run("DROP TABLE IF EXISTS users CASCADE;")
  db.run("CREATE TABLE users (id SERIAL PRIMARY KEY, email TEXT NOT NULL, password TEXT NOT NULL);")

  db.run("DROP TABLE IF EXISTS spaces CASCADE;")
  db.run("CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    price INT NOT NULL,
    date_from TEXT NOT NULL,
    date_to TEXT NOT NULL,
    user_id INT REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
    );")

  db.run("DROP TABLE IF EXISTS requests CASCADE;")
  db.run("CREATE TABLE requests(
    id SERIAL PRIMARY KEY,
    space_id INT REFERENCES spaces(id) ON UPDATE CASCADE ON DELETE CASCADE,
    requester_id INT REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    owner_id INT REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
    );")

  db.run("DROP TABLE IF EXISTS dates;")
  db.run("CREATE TABLE dates(
    id SERIAL PRIMARY KEY,
    space_id INT REFERENCES spaces(id) ON UPDATE CASCADE ON DELETE CASCADE,
    available_date TEXT NOT NULL
    );")

  # Add your table creation SQL here
  # Each one should be a pair of lines:
  #   db.run("DROP TABLE IF EXISTS ...;")
  #   db.run("CREATE TABLE ... (id SERIAL PRIMARY KEY, ...);")
end

dev_db = DatabaseConnection.new("localhost", "bestgroupbnb_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "bestgroupbnb_test")
reset_tables(test_db)
