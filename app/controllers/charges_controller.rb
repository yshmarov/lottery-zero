class ChargesController < ApplicationController
  def new
    @charge = current_user.charges.new
  end

  def create
    @charge = current_user.charges.new(charge_params)

    if @charge.save
      flash[:success] = t(".success")
      redirect_to root_url
    else
      flash.now[:error] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def charge_params
    params.require(:charge).permit(:amount)
  end
end
