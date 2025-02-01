class ChargesController < ApplicationController
  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new(params.require(:charge).permit(:amount))
    @charge.user = current_user

    if @charge.save
      @charge.user.update_balance
      redirect_to root_url, notice: "Charge was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
