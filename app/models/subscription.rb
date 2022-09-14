class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions

  validates_presence_of :title, :price, :status, :frequency

  enum status: { active: 0, cancelled: 1 }
end
