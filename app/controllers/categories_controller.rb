class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

 def new
    @category = Category.new
    @categories = Category.all.order(:name)
  end


  def index
  	@categories = Category.all
  end

  def show
    
  end


  def create
  	@category = Category.new(category_params)
  	if @category.save
  		redirect_to categories_path, success: 'Success'
  	else
  		@categories = Category.all.order(:name)
  		flash[:danger] = 'Failure'
  		render :new
  	end
  end

  def edit
  	 @categories = Category.where("id != #{@category.id}").order(:name)
  end

  def update
  	if @category.update_attributes(category_params)
  	redirect_to categories_path, success: 'Success'
  else
  	@categories = Category.all.order(:name)
  	flash[:danger] = 'Failure'
  	render :new
  	end
  end

  def destroy
  	@category.destroy

  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
  	params.require(:category).permit(:name, :parent_id)
  end
end