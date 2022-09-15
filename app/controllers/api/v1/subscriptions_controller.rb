class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.create(subscription_params)
    render json: subscription, status: :created
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
