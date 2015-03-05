
require 'rails_helper'


describe Task do

  it "requires a description and date" do

    Task.destroy_all
    task=Task.create!(description: "Run", due_date: "1/10/10")

    expect(task).to be_valid

  end

  it "gives an error message if description not present" do

    task=Task.new
    task.description=""
    task.due_date="1/1/01"
    expect(task.valid?).to eq false

  end

end
