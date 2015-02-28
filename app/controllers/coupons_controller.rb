class CouponsController < ApplicationController
  before_filter :authenticate
  def index
    @coupons = Coupon.all
  end
  
  def new
  	@coupon = Coupon.new()
  end

  def create
  	@coupon = Coupon.new(coupon_params)
  	if @coupon.save
  		redirect_to @coupon, notice: 'Coupon was successfully created.'
  	else
  		render action: 'new'
  	end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      redirect_to @coupon, notice: 'Coupon was updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy
    redirect_to coupon_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def coupon_params
  	params.require(:coupon).permit(:title, :description, :active, :active_until)
  end
end