require "rails_helper"

RSpec.describe TransactionsController, type: :routing do
    describe "routing" do
      it "routes to #current_balances" do
      expect(get: "/balances").to route_to("transactions#current_balances")
    end

    it "routes to #create_transaction" do
      expect(post: "/add_transaction").to route_to("transactions#create_transaction")
    end

    it "routes to #spend_pts" do
      expect(post: "/spend_points").to route_to("transactions#spend_pts")
    end
  end
end
