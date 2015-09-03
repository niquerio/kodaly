require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @qf = QuestionFactory.create(name:"so-mi-1")
    @question = Question.create(prompt: "I am a prompt", question_factory: @qf)
  end

  test "Question has associated Factory" do
    assert_equal @qf, @question.question_factory
  end 
end
