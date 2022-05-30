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

  def row_to_object(row)
    return UserEntity.new(
        row["email"],
        row["password"],
        row["password"],
        row["id"]
    )
  end
end
