require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @qf = QuestionFactory.create(name:"so-mi-1")
    @question = Question.create(prompt: "I am a prompt", question_factory:@qf)
    @wrong = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:false, order:0)
    @correct = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:true, order:1)
    @user = User.create(name: "Name")

  end

  test "is_quiz_complete returns appropriate result" do
    refute @user.is_quiz_complete(@qf) 
    (1..9).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
      refute @user.is_quiz_complete(@qf) 
    end
    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert @user.is_quiz_complete(@qf) 

    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert @user.is_quiz_complete(@qf) 
  end

  test "get_highest_streak returns appropriate result" do
    assert_equal 0, @user.get_highest_streak(@qf)
    
    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert_equal 1, @user.get_highest_streak(@qf)

    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert_equal 2, @user.get_highest_streak(@qf)

    AnsweredQuestion.create(choice: @wrong, user: @user, question_factory:@qf)
    assert_equal 2, @user.get_highest_streak(@qf)

    (1..4).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 4, @user.get_highest_streak(@qf)
  end

  test "get_current_streak works" do
    (1..4).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 4, @user.get_current_streak(@qf)
    AnsweredQuestion.create(choice: @wrong, user: @user, question_factory:@qf)
    assert_equal 0, @user.get_current_streak(@qf)
    (1..3).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 3, @user.get_current_streak(@qf)
  end
end
