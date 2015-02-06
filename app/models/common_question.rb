
class CommonQuestion

  # Below -the common Ruby way of approaching model-controller-data code
  # It copies the idea of ActiveRecord using column attributes to define methods.
  #
  # Here, a new instance of this
  # class requires arguments question, answer, and slug that are then assigned
  # to instance varables. attr_reader defines methods question, answer, slug associated
  # with these instance variabiles. So, calling a method from a CommonQuestion
  # object returns the argument value.
  # arguments and assigning instance variables to them leads to methods returning
  attr_reader :question, :answer, :slug

  def initialize(question, answer, slug)
    @question = question
    @answer = answer
    @slug = slug
  end

  # Below - Another approach that can work but not common approach.
  # An instance of the class will return the entire array.
  #
  #   [
  #   { q: "**What is gCamp?**",
  #     a: "gCamp is an awesome tool that is going to change your life.
  #     gCamp is your one stop shop to organize all your tasks.
  #     You'll also be able to track comments that you and others make.
  #     gCamp may eventually replace all need for paper and pens in the entire world.
  #     Well, maybe not, but it's going to be pretty cool.
  #     ",
  #     s: "What-is-gCamp?"},
  #   { q: "**How do I join gCamp?**",
  #     a: "As soon as it's ready for the public, you'll see a signup link
  #     in the upper right.  Once that's there, just click it and fill in the form!
  #     ",
  #     s: "How-do-I-join-gCamp?"},
  #   { q: "**When will gCamp be finished?**",
  #     a: "gCamp is a work in progress.
  #     That being said, it should be fully functional in the next few weeks.
  #     Functional.  Check in daily for new features and awesome functionality.
  #     It's going to blow your mind.  Organization is just a click away.  Amazing!
  #     ",
  #     s: "When-will-gCamp-be-finished?"}
  #   ]
  #
  # end

end
