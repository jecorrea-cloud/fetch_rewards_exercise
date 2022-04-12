class Transaction < ApplicationRecord
    #Validations before entering the database
    validates :payer, :points, :timestamp, presence: true
    validates :points, numericality: { only_integer: true}
    validates :points, numericality: { greater_than_or_equal_to: 0}

    #class methods for the spend_pts controller method

    # Gets the total points in the database
    def self.total
        total_points = 0
        current_points = []
        self.all.map do |t|
            current_points << t.points
        end
        total_points = current_points.sum

        return total_points > 0 ? total_points : 0
    end
   
    # Substracts the points while making sure the transactions' points don't drop to zero
    def self.substract_points(pts)
        # Sort all transactions by recent date
        sorted_trans = self.all.sort_by(&:timestamp)
        # Hash to return balances
        receipt = {}
        # Conditional. If the total points are not enough to be spent, return a message
        if self.total < pts
            receipt = {}
        else
            # Otherwise, iterate through if there are enough points in the database
            for i in 0...sorted_trans.length do
                # If the input points happen to be zero, exit
                if pts <= 0
                    break
                end
                # Check first if the current transaction's points are positive
                if sorted_trans[i].points > 0
                    # Case when the substraction is positive (input points are greater than transaction's points)
                    if pts - sorted_trans[i].points > 0
                        receipt.key?(sorted_trans[i].payer) ? receipt[sorted_trans[i].payer] += (-1) * (sorted_trans[i].points) : receipt[sorted_trans[i].payer] = (-1) * (sorted_trans[i].points)
                        pts = pts - sorted_trans[i].points
                        Transaction.update(sorted_trans[i].id, :points => 0)
                    # Case when the substraction is zero (input points are equal to transaction's points)
                    elsif pts - sorted_trans[i].points == 0
                        receipt.key?(sorted_trans[i].payer) ? receipt[sorted_trans[i].payer] += (-1) * (sorted_trans[i].points) : receipt[sorted_trans[i].payer] = (-1) * (sorted_trans[i].points)
                        pts = 0
                        Transaction.update(sorted_trans[i].id, :points => 0)
                    # Case when the substraction is negative (input points are less than transaction's points)
                    elsif pts - sorted_trans[i].points < 0
                        remaining = sorted_trans[i].points - pts
                        receipt.key?(sorted_trans[i].payer) ? receipt[sorted_trans[i].payer] += (-1)*(pts) : receipt[sorted_trans[i].payer] = (-1)*(pts)
                        pts = 0
                        Transaction.update(sorted_trans[i].id, :points => remaining)
                    end
                elsif sorted_trans[i].points < 0
                    pts = pts - sorted_trans[i].points
                    receipt.key?(sorted_trans[i].payer) ? receipt[sorted_trans[i].payer] += (-1)*(sorted_trans[i].points) : receipt[sorted_trans[i].payer] = (-1)*(sorted_trans[i].points)
                    Transaction.update(sorted_trans[i].id, :points => 0)
                end
            end
        end
        receipt
    end
end
