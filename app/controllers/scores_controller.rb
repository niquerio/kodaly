class ScoresController < ApplicationController
  def show
    @score = Score.find(params[:qf_id],params[:user_id]) 
  end
end
