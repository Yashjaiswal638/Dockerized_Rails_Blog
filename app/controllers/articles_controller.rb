class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 2)
    end


    def show
    end


    def new
        @article = Article.new
    end


    def edit
    end


    def create
        # render plain: params[:article]
        @article = Article.new(article_params)
        @article.user = current_user
        # render plain: @article.inspect
        if @article.save
        # redirect_to article_path(@article)
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else
            render 'new', status: :unprocessable_entity
        end
    end


    def update
        if @article.update(article_params)
          flash[:notice] = "Article was updated successfully."
          redirect_to @article
        else
          render 'edit', status: :unprocessable_entity
        end
    end


    def destroy
        @article.destroy
        redirect_to articles_path
    end


    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You cannot edit/delete other user\'s article"
            redirect_to @article
        end
    end

end
