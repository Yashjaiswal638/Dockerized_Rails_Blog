class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end


    def show
        @articles = @user.articles
    end

    
    def index
        @users = User.paginate(page: params[:page], per_page: 2)
    end


    def edit
    end


    def create
        # render plain: params[:article]
        @user = User.new(user_params)
        # render plain: @article.inspect
        if @user.save
        # redirect_to article_path(@article)
            session[:user_id] = @user.id
            flash[:notice] = "User Sign up successfull, Welcome #{@user.username}."
            redirect_to articles_path
        else
            render 'new', status: :unprocessable_entity
        end
    end


    def update
        if @user.update(user_params)
          flash[:notice] = "User was updated successfully."
          redirect_to @user
        else
          render 'edit', status: :unprocessable_entity
        end
    end


    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:alert] = "Account & associated articles deleted."
        redirect_to articles_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end


    def user_params
        params.require(:user).permit(:username, :email, :password, :f_name, :l_name, :avatar)
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You cannot edit/delete other user\'s profile"
            redirect_to @user
        end
    end


end