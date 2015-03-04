
require 'rails_helper'


describe User do

  it "requires a first name, last name, and email" do

    User.destroy_all
    user=User.create!(first_name: "Al", last_name: "Steiner", email: "as@gmail.com",
      password:"as", password_confirmation: "as")

    expect(user).to be_valid

  end

  it "first name must be present" do

    user=User.new
    user.first_name=""
    user.last_name="Z"
    user.email="al@ex.com"
    user.password="al"
    user.password_confirmation="al"
    expect(user.valid?).to eq false

  end

  it "last name must be present" do

    user=User.new
    user.first_name="Al"
    user.last_name=""
    user.email="al@ex.com"
    user.password="al"
    user.password_confirmation="al"
    expect(user.valid?).to eq false

  end

  it "email must be present" do

    user=User.new
    user.first_name="Al"
    user.last_name="Z"
    user.email=""
    user.password="al"
    user.password_confirmation="al"
    expect(user.valid?).to eq false

  end

  it "password must be present" do

    user=User.new
    user.first_name="Al"
    user.last_name="Z"
    user.email="al@ex.com"
    user.password=""
    user.password_confirmation="al"
    expect(user.valid?).to eq false

  end

  it "password confirmation must be present" do

    user=User.new
    user.first_name="Al"
    user.last_name="Z"
    user.email="al@ex.com"
    user.password="al"
    user.password_confirmation=""
    expect(user.valid?).to eq false

  end

end
