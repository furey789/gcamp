
require 'rails_helper'

describe Project do

  it "requires a name" do

    Task.destroy_all
    task=Project.create!(name: "Build everyting")

    expect(task).to be_valid

  end

  it "gives an error message if name not present" do

    project=Project.new
    project.name=""
    expect(project.valid?).to eq false

  end

end
