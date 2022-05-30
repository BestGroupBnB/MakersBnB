require "helpers/database_helpers"

RSpec.describe "Users Feature", type: :feature do
    before(:each) do
        DatabaseHelpers.clear_table("users")
      end

  it "starts with our Sign Up homepage" do
    visit "/"
    expect(page).to have_content "Sign up to MakersBnB"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    expect(page).to have_content "Password Confirm"
    expect(page).to have_button "Sign Up"
    expect(page).to have_link "Login"
  end 
end 