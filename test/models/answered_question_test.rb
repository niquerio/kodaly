require 'test_helper'

class AnsweredQuestionTest < ActiveSupport::TestCase
  def setup
    @qf = QuestionFactory.create(name:"so-mi-1")
    @question = Question.create(prompt: "I am a prompt", question_factory:@qf)
    @wrong = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:false, order:0)
    @correct = Choice.create(midi_blob: "awlfkja;wlfekja;welfajw;eoij", question:@question, correct:true, order:1)
    @user = User.create(name: "Name")

    
  end

  test "answered question should return correct result" do
      @wrong_answer = AnsweredQuestion.new(choice: @wrong, user: @user)
      @correct_answer = AnsweredQuestion.new(choice: @correct, user: @user)
      assert @correct_answer.is_choice_correct
      refute @wrong_answer.is_choice_correct
  end 

  test "after_save creates new score if score doesn't exist" do
    refute Score.find_by(question_factory: @qf, user: @user), "before AQ"

    AnsweredQuestion.create(choice: @correct, user: @user, question_factory: @qf)
    assert Score.find_by(question_factory: @qf, user: @user), "after AQ"
     
  end

  
  test "complete returns appropriate result" do
    AnsweredQuestion.create(choice: @correct, user: @user, question_factory: @qf)
    def complete
      score = Score.find_by(question_factory: @qf, user: @user)
      return score.complete
    end

    refute complete, "first refute"
    (1..8).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory: @qf)
      refute complete, "in the loop"
    end
    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert complete, "saved value" 

    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert complete, "should still be true"
  end

  test "highest_streak returns appropriate result" do
    
    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert_equal 1, Score.find_by(question_factory: @qf, user: @user).highest_streak

    AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    assert_equal 2, Score.find_by(question_factory: @qf, user: @user).highest_streak

    AnsweredQuestion.create(choice: @wrong, user: @user, question_factory:@qf)
    assert_equal 2, Score.find_by(question_factory: @qf, user: @user).highest_streak

    (1..4).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 4, Score.find_by(question_factory: @qf, user: @user).highest_streak
  end

  test "current_streak works" do
    (1..4).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 4, Score.find_by(question_factory: @qf, user: @user).current_streak
    AnsweredQuestion.create(choice: @wrong, user: @user, question_factory:@qf)
    assert_equal 0, Score.find_by(question_factory: @qf, user: @user).current_streak
    (1..3).each do
      AnsweredQuestion.create(choice: @correct, user: @user, question_factory:@qf)
    end
    assert_equal 3, Score.find_by(question_factory: @qf, user: @user).current_streak
  end
end
