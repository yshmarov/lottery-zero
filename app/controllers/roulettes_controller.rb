class RoulettesController < ApplicationController
  def index
    @roulettes = Roulette.active.order(shares_total: :asc)
  end

  def finished
    @roulettes = Roulette.finished.order(shares_total: :asc)
    render "index"
  end

  def show
    @roulette = Roulette.find(params[:id])
    @bets = @roulette.bets
  end

  def gamble
    @roulette = Roulette.find(params[:id])
    add_weight = params[:weight].to_i

    @current_bet = current_user.my_bet(@roulette)

    def new_weight
      if @current_bet.present?
        params[:weight].to_i + @current_bet.weight
      else
        params[:weight].to_i
      end
    end

    if add_weight > @roulette.shares_available
      redirect_to root_path, alert: "There aren't so many shares left! Maximum #{@roulette.shares_available}"
    elsif add_weight > current_user.balance
      redirect_to root_path, alert: "You don't have enough funds to make such this bet!"
    elsif new_weight > @roulette.shares_total/2
      redirect_to root_path, alert: "You can't monopolize a bet!"
    else
      if @current_bet.present?
        @bet = @current_bet
        @bet.increment!(:weight, by = add_weight)
      else
        @bet = Bet.create(weight: add_weight, roulette: @roulette, user: current_user)
      end
      @bet.roulette.update_available_shares
      @bet.user.update_balance

      if @bet.roulette.shares_available.zero?
        # Roulette.first.random_weighted(Roulette.first.bets.pluck(:user_id, :weight))
        weighted_random_winner = User.find_by(id: @roulette.random_weighted(@roulette.bets.pluck(:user_id, :weight)))
        # weighted_random_winner = User.first
        @roulette.update(user: weighted_random_winner)
        weighted_random_winner.update_balance
        Roulette.create(shares_total: @roulette.shares_total)
        redirect_to @roulette, notice: "There's a winner!"
      else
        redirect_to root_path, notice: "You've made a bet!"
      end
    end
  end
end
