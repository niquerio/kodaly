require 'test_helper'

class QuestionFactoryTest < ActiveSupport::TestCase
  def setup
    @question_factory = QuestionFactory.new(name: "so_mi_1")
    @question_factory.save
    @question =  @question_factory.make_question
    
  end
  test "Question should have correct prompt" do
      assert_equal @question.prompt, 'Which is So Mi?'
  end

  test "Question should have more than one associated choices" do
        choices = Choice.where question_id: @question.id 
        assert choices.size > 1
  end

  test "Question should have correct choice, which is one of the associated choices" do
      assert @question.correct_choice
      assert Choice.find_by id: @question.correct_choice
      
  end
  #Expected number of notes
  #Correct one is correct
  #Percentages are correct 
end
