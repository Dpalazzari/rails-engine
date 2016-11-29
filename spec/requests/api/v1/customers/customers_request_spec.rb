require 'rails_helper'

RSpec.describe "customers endpoints" do
  context "GET /api/v1/customers" do
    it "returns a list of all customers" do
      create_list(:customer, 3)

      get "/api/v1/customers"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  context "GET /api/v1/customers/id" do
    it "returns a specific customer" do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers["first_name"]).to eq(customer.first_name)
    end
  end

  context "GET /api/v1/customers/find?" do
    it "finds a customer by id" do
      create_list(:customer, 3)
      customer = Customer.first

      get "/api/v1/customers/find?id=#{customer.id}"

      data = JSON.parse(response.body)

      expect(response).to be_success
      expect(data["id"]).to eq(customer.id)
    end
  end

  context "GET /api/v1/customers/find_all?" do
    it "finds all customers" do
      customer_1 = Customer.create(first_name: "test_first", last_name: "test_last")
      customer_2 = Customer.create(first_name: "test_first", last_name: "test_last")

      get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

      data = JSON.parse(response.body)

      expect(response).to be_success

      data.each do |datum|
        expect(datum["first_name"]).to eq(customer_1.first_name)
        expect(datum["first_name"]).to eq(customer_2.first_name)
      end
    end
  end
end
