require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup
    @qf = QuestionFactory.create(name:"so-mi-1")
    @question = Question.create(prompt: "I am a prompt", question_factory:@qf)
    @wrong = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:false, order:0)
    @correct = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:true, order:1)
    @user = User.create(name: "Name")
    @score = Score.create(question_factory: @qf, user: @user)
  end

  test "Score has appropriate options" do
    assert_includes Score.attribute_names, "current_streak" 
    assert_includes Score.attribute_names, "highest_streak" 
    assert_includes Score.attribute_names, "complete" 
    assert_equal :belongs_to,  Score.reflect_on_association(:user).macro
    assert_equal :belongs_to,  Score.reflect_on_association(:question_factory).macro
  end

  #test "complete returns appropriate result" do
  #  refute @score.complete, "first refute"
  #  (1..9).each do
  #    refute @score.complete, "in the loop"
  #  end
  #  AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
  #  assert @score.complete, "saved value" 

  #  AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
  #  assert @score.complete, "should still be true"
  #  

  #end
end
