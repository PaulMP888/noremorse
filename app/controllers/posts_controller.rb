class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]

	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to @post, success:'Success'
		else
		flash.now[:danger] = 'Failure'
		render :new
		end 
	end

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			redirect_to @post
		else
			flash.now[:danger] = 'Failure'
			render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :summary, :body, :image, :all_tags)
	end
end