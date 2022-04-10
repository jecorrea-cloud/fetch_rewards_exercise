class TransactionSerializer < ActiveModel::Serializer
  attributes :payer, :points, :timestamp
end
