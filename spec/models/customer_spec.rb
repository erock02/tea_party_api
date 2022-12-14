require 'rails_helper'

describe Customer, type: :model do
  describe "validations" do
    it {should have_many :subscriptions}
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
  end
end
