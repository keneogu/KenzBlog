class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	# before_action :check_subscription_status, except: [:index, :search]

	def index
		params[:category] ? @category = params[:category] : @category = "latest"
		if @category == 'latest'	
		@articles = Article.all.desc
		else
			@articles = Article.where(:category=>@category).desc
		end
	end

	def show
		@article = Article.find(params[:id])

		# return unless current_user
	  # return if current_user.payment_processor.nil?
		
		# @portal_session = current_user.payment_processor.billing_portal
	end

	def search
		if params[:q].blank?
			redirect_to root_path and return
		else
			@parameter = params[:q].downcase
			@articles = Article.all.where("lower(title) LIKE ?", "%" + "#{@parameter}" + "%")
		end
	end

	def new
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_params)

		if @article.save
      redirect_to root_path
    else
      render :new
    end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	def destroy
		@article = Article.find(params[:id])

		@article.destroy

		redirect_to root_path
	end

	private

	def article_params
		params.require(:article).permit(:title, :category, :image, :bodypdf)
	end
end
