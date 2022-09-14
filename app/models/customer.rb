class Customer < ApplicationRecord
  has_many :customer_subsriptions
  has_many :subscriptions, through: :customer_subsriptions
end
