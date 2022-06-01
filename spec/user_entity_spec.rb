require "user_entity"

RSpec.describe UserEntity do
  it "create user and return fields" do
    user_entity = UserEntity.new("spaceowner@gmail.com","password1","password_confirm1")
    expect(user_entity.email).to eql("spaceowner@gmail.com")
    expect(user_entity.password).to eql("password1")
    expect(user_entity.password_confirm).to eql("password_confirm1")
  end
end
