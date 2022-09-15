class Api::V1::SubscriptionsController < ApplicationController

  def index
    @customer = Customer.find(params[:customer_id])
    render json: @customer.to_json(include: :subscriptions)
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @customer.subscriptions.create(subscription_params)
    render json: @customer.to_json(include: :subscriptions), status: :created
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: subscription, status: :ok
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end
