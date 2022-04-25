class TransactionsController < ApplicationController

  def current_balances 
    #Bring down all present transactions in the database
    @transactions = Transaction.all
    recent_transactions = {}
    #Iterate through all existing hashes in the database and take out the proper attributes from them
    @transactions.map do |transaction|
        recent_transactions.key?(transaction.payer) ? recent_transactions[transaction.payer] += transaction.points : recent_transactions[transaction.payer] = transaction.points
    end    
    render json: recent_transactions
  end

  def create_transaction
    #Variable with the input params from the request
    @transaction = Transaction.create(transaction_params)
    #Check whether they are valid or not. If they are, return the object just created and the status or error messages
    if @transaction.valid?
        render json: @transaction, status: 201
    else
        render json: {"errors": @transaction.errors.full_messages}, status: 422
    end
  end

  
  def spend_pts
    #Call on the class method to substract points and return balances
    @spent_balance = Transaction.substract_points(transaction_params[:points])

    if @spent_balance.empty?
      render json: {"errors": "Invalid input. Input Points cannot be negative, zero or greater than the current balances."}, status: 400
    else
      render json: @spent_balance, status: 201
    end

  end

  def search_p
    # Iterate the database and with the `.where()` built-in rails method 
    @payer_info = Transaction.where(payer: transaction_params[:payer].upcase).or(Transaction.where("payer LIKE ?", "%"+transaction_params[:payer].upcase+"%")).sort_by(&:timestamp)

    # Return either an error response or an array with the requested payer's transactions
    if @payer_info.empty?
      render json: {"errors": "Invalid input. Payer not found."}, status: 404
    else
      render json: @payer_info, status: 200
    end
  end

  def search_t
    # Iterate the database and with the `.where()` built-in rails method 
    @payer_info = Transaction.where(timestamp: transaction_params[:timestamp])

    # Return either an error response or an array with the transactions with the requested timestamp
    if @payer_info.empty?
      render json: {"errors": "Invalid input. No Transactions were found for this date."}, status: 404
    else
      render json: @payer_info, status: 200
    end
  end


  private
    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:payer, :points, :timestamp)
    end
end
