class Subscription < ApplicationRecord
  has_many :customer_subsriptions
  has_many :customers, through: :customer_subsriptions
end
