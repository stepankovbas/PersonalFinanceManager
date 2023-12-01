class CategoriesController < ApplicationController
    def index
        @category = Category.all
        @category = Category.where("LOWER(title) LIKE ?", "%#{params[:search].downcase}%") if params[:search].present?
    end
    
    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)

        if(@category.save)        
            redirect_to categories_index_path
        else
            render 'new'
        end
    end

    def show
        
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])

        if(@category.update(category_params))        
            redirect_to categories_index_path
        else
            render 'edit'
        end
    end
    
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        
    end
    
    private def category_params
        #params.fetch(:category{})
        params.require(:category).permit(:title, :description)
    end
end
