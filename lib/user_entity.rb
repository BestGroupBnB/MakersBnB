class UserEntity
  def initialize(email,password,password_confirm,id = nil)
    @id = id
    @email = email
    @password = password
    @password_confirm = password_confirm
  end

  attr_reader :email, :password,:password_confirm,:id
end
