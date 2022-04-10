class Transaction < ApplicationRecord
    #Validations before entering the database
    validates :payer, :points, :timestamp, presence: true
    validates :points, numericality: { only_integer: true}
    validates :points, numericality: { greater_than_or_equal_to: 0}

    
end
