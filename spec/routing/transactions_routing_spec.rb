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

    it "routes to #search_p" do
      expect(get: "/search_payer").to route_to("transactions#search_p")
    end

    it "routes to #search_t" do
      expect(get: "search_timestamp".to route_to("transactions#search_t"))
    end
  end
end
