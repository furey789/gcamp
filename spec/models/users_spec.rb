
require 'rails_helper'

describe User do

  it "requires a first name" do

    user=User.create(first_name: "Joe", last_name: "Steiner", email: "js@gmail.com")
    expect(user).to be_valid

  end

end
