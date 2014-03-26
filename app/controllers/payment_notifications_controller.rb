class PaymentNotificationsController < ApplicationController
  before_action :set_payment_notification, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create]
  before_filter :authenticate, :only => [:index, :show, :edit, :destroy]
  # GET /payment_notifications
  # GET /payment_notifications.json
  def index
    @payment_notifications = PaymentNotification.all
  end


  # POST /payment_notifications
  # POST /payment_notifications.json
  def create
    PaymentNotification.create!(:params => params, :organization_id => params[:invoice], 
      :status => params[:payment_status], :transaction_id => params[:txn_id], :amount => params[:auth_amount])
    render :nothing => true
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_notification
      @payment_notification = PaymentNotification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_notification_params
      params.require(:payment_notification).permit(:params, :organization_id, :status, :transaction_id, :amount)
    end
end
