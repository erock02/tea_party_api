class Api::V1::SubscriptionsController < ApplicationController

  def index
    begin
      @customer = Customer.find(params[:customer_id])
      render json: @customer.to_json(include: :subscriptions)
    rescue ActiveRecord::RecordNotFound => e
      render json: e, status: 404
    end
  end

  def create
    begin
      @customer = Customer.find(params[:customer_id])
      @sub = @customer.subscriptions.new(subscription_params)
      if @sub.save
        render json: @customer.to_json(include: :subscriptions), status: :created
      else
        render json: @sub.errors.full_messages, status: 400
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: e, status: 404
    end
  end

  def update
    begin
      @customer = Customer.find(params[:customer_id])
      subscription = @customer.subscriptions.find(params[:id])
      subscription.update(subscription_params)
      render json: subscription, status: :ok
    rescue ArgumentError => e
      render json: e, status: 400
    rescue ActiveRecord::RecordNotFound => e
      render json: e, status: 404
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end
