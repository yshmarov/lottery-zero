class UsersController < ApplicationController
  def index
    @users = User.order(leader_score: :desc)
  end

  def show
    @user = User.find(params[:id])
    @charges = @user.charges.includes(:related_models)
    @bets = @user.bets.includes(:related_models)
  end
end
