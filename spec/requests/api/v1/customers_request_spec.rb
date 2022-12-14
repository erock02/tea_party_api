require 'rails_helper'

describe "Customer API endpoint" do
  describe "happy paths" do
    it "subscribes customer to tea subscription" do
      customer1 = create(:customer)
      tea1 = create(:tea)
      subscription_params = ({
              title: "a cool title",
              price: "12.34",
              status: "active",
              frequency: 5,
              customer_id: customer1.id,
              tea_id: tea1.id
            })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      expect(response).to be_successful

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to have_key(:id)
      expect(parsed_json[:id]).to eq(customer1.id)
      expect(parsed_json).to have_key(:first_name)
      expect(parsed_json[:first_name]).to eq(customer1.first_name)
      expect(parsed_json).to have_key(:last_name)
      expect(parsed_json[:last_name]).to eq(customer1.last_name)
      expect(parsed_json).to have_key(:email)
      expect(parsed_json[:email]).to eq(customer1.email)
      expect(parsed_json).to have_key(:address)
      expect(parsed_json[:address]).to eq(customer1.address)
      expect(parsed_json).to have_key(:subscriptions)
      expect(parsed_json[:subscriptions][0]).to have_key(:title)
      expect(parsed_json[:subscriptions][0][:title]).to eq("a cool title")
      expect(parsed_json[:subscriptions][0]).to have_key(:price)
      expect(parsed_json[:subscriptions][0][:price]).to eq("12.34")
      expect(parsed_json[:subscriptions][0]).to have_key(:status)
      expect(parsed_json[:subscriptions][0][:status]).to eq("active")
      expect(parsed_json[:subscriptions][0]).to have_key(:frequency)
      expect(parsed_json[:subscriptions][0][:frequency]).to eq(5)
      expect(parsed_json[:subscriptions][0]).to have_key(:tea_id)
      expect(parsed_json[:subscriptions][0][:tea_id]).to eq(tea1.id)
    end

    it "cancels a customers tea subscription" do
      customer1 = create(:customer)
      subscription1 = create(:subscription, customer_id: customer1.id, status: "active")
      subscription_params = ({
              status: "cancelled"
            })
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}", headers: headers, params: JSON.generate(subscription_params)

      expect(response).to be_successful

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to have_key(:id)
      expect(parsed_json[:id]).to eq(subscription1.id)
      expect(parsed_json).to have_key(:price)
      expect(parsed_json[:price]).to eq(subscription1.price.to_s)
      expect(parsed_json).to have_key(:title)
      expect(parsed_json[:title]).to eq(subscription1.title)
      expect(parsed_json).to have_key(:status)
      expect(parsed_json[:status]).to eq("cancelled")
      expect(parsed_json).to have_key(:frequency)
      expect(parsed_json[:frequency]).to eq(subscription1.frequency)
    end

    it "shows all a customers subscriptions" do
      customer1 = create(:customer)
      customer2 = create(:customer)
      subscriptions1 = create(:subscription, customer_id: customer1.id, status: "active")
      subscriptions2 = create(:subscription, customer_id: customer1.id, status: "cancelled")
      subscriptions3 = create(:subscription, customer_id: customer2.id)
      get "/api/v1/customers/#{customer1.id}/subscriptions"

      expect(response).to be_successful

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to have_key(:id)
      expect(parsed_json[:id]).to eq(customer1.id)
      expect(parsed_json).to have_key(:first_name)
      expect(parsed_json[:first_name]).to eq(customer1.first_name)
      expect(parsed_json).to have_key(:last_name)
      expect(parsed_json[:last_name]).to eq(customer1.last_name)
      expect(parsed_json).to have_key(:email)
      expect(parsed_json[:email]).to eq(customer1.email)
      expect(parsed_json).to have_key(:address)
      expect(parsed_json[:address]).to eq(customer1.address)
      expect(parsed_json).to have_key(:subscriptions)
      expect(parsed_json[:subscriptions].length).to eq(2)
      expect(parsed_json[:subscriptions][0][:id]).to eq(subscriptions1.id)
      expect(parsed_json[:subscriptions][0][:title]).to eq(subscriptions1.title)
      expect(parsed_json[:subscriptions][1][:id]).to eq(subscriptions2.id)
      expect(parsed_json[:subscriptions][1][:title]).to eq(subscriptions2.title)
    end
  end

  describe 'sad paths' do
    it "cannot subscribe customer with customer ID that does not exist" do
      tea1 = create(:tea)
      subscription_params = ({
              title: "a cool title",
              price: "12.34",
              status: "active",
              frequency: 5,
              customer_id: 50,
              tea_id: tea1.id
            })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/50/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to eq("Couldn't find Customer with 'id'=50")
    end

    it "cannot subscribe customer with missing subscription parameters" do
      customer1 = create(:customer)
      tea1 = create(:tea)
      subscription_params = ({
              title: "a cool title",
              status: "active",
              frequency: 5,
              customer_id: customer1.id,
              tea_id: tea1.id
            })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer1.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      parsed_json = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_json).to eq(["Price can't be blank"])
    end

    it "cannot cancel subscription for subscription that does not exist" do
      customer1 = create(:customer)
      subscription_params = ({
              status: "active"
            })
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer1.id}/subscriptions/5", headers: headers, params: JSON.generate(subscription_params)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to include("Couldn't find Subscription with 'id'=5")
    end

    it "cannot cancel subscription for customer that does not exist" do
      subscription1 = create(:subscription)
      subscription_params = ({
              status: "active"
            })
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/100/subscriptions/#{subscription1.id}", headers: headers, params: JSON.generate(subscription_params)

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to eq("Couldn't find Customer with 'id'=100")
    end

    it "cannot show subscriptions for customer that does not exist" do

      get "/api/v1/customers/1/subscriptions"

      parsed_json = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_json).to eq("Couldn't find Customer with 'id'=1")
    end
  end
end
