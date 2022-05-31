class UsersTable
  def initialize(db)
    @db = db
  end

  def add(new_user)
    result = @db.run("INSERT INTO users(email,password) VALUES($1,$2) RETURNING id;",
[new_user.email,new_user.password])
    return result[0]["id"]
  end

  def get(id)
    user = @db.run("SELECT * FROM users WHERE id=$1;",[id])
    return row_to_object(user[0])
  end

  def get_password_from_email(email)
    user = @db.run("SELECT * FROM users WHERE email=$1;",[email])
    return row_to_object(user[0])
  end

  def user_exists?(email)
    user_id = @db.run("SELECT id FROM users WHERE email=$1;",[email])
    return false if user_id.to_a.empty? 
    return true
  end 

  def row_to_object(row)
    return UserEntity.new(
        row["email"],
        row["password"],
        row["password"],
        row["id"]
    )
  end
end
