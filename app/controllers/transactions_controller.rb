class TransactionsController < ApplicationController
    def index
        @transaction = Transaction.all
        @categories = Category.all
        @transaction = @transaction.where(title: params[:title]) if params[:title].present?
    end

    def new
        @transaction = Transaction.new
        @categories = Category.all
    end

    def create
        @transaction = Transaction.new(transaction_params)

        if(@transaction.save)        
            redirect_to transactions_index_path
        else
            render 'new'
        end
    end

    def edit
        @transaction = Transaction.find(params[:id])
    end

    def update
        @transaction = Transaction.find(params[:id])

        if(@transaction.update(transaction_params))        
            redirect_to transactions_index_path
        else
            render 'edit'
        end
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        
    end

    def report_generator
        @transaction = Transaction.all
    end

    def report
        # @transaction = Transaction.all
        # @all_sum = @transaction.sum(&:sum)

        @start_date = params[:start_date]
        @end_date = params[:end_date]
        @transaction_type = params[:transaction_type]
        @category_title = params[:category_title]
      
        @transaction = Transaction.all
        @transaction = @transaction.where(date: @start_date..@end_date) if @start_date.present? && @end_date.present?
        @transaction = @transaction.where(transaction_type: @transaction_type) if @transaction_type.present?
        @transaction = @transaction.where(title: @category_title) if @category_title.present?
      
        @all_sum = @transaction.sum(:sum)

        @transaction_grouped = @transaction.group_by(&:title)

        if @transaction_type == "Витрати"
            @title_giagram = 'Розподіл витрат за період'
        elsif @transaction_type == "Дохід"
            @title_giagram = 'Розподіл доходів за період'
        else
            @title_giagram = 'Розподіл витрат/доходів за період'
        end


    end 

    def graph_report
        @start_date = params[:start_date]
        @end_date = params[:end_date]
        @transaction_type = params[:transaction_type]
        @category_title = params[:category_title]
        @sum_arr = []
        @date_arr = []

        @transaction = Transaction.all
        @transaction = @transaction.where(date: @start_date..@end_date) if @start_date.present? && @end_date.present?
        @transaction = @transaction.where(transaction_type: @transaction_type) if @transaction_type.present?
        @transaction = @transaction.where(title: @category_title) if @category_title.present?
        
        @all_sum = @transaction.sum(:sum)

        @transaction_grouped = @transaction.group_by(&:title)
        
        @transaction.each do |t|
            @sum_arr << t.sum
            @date_arr << t.date
        end

    end

    private def transaction_params
        #params.fetch(:transaction{})
        params.require(:transaction).permit(:title, :transaction_type, :sum, :date, :description)
    end
end
