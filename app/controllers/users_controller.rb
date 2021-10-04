class UsersController < ApplicationController
    enable :sessions

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to "/tweets"
        end
      end

    get '/login' do
        if logged_in?
            redirect to "/tweets"
        else
            erb :'users/index'
        end
    end

    get '/logout' do 
        session.clear
        redirect to "/login"
    end

    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        @tweets = Tweet.all.find_all {|tweet| tweet.user_id = @user.id}
        erb :'users/show'
    end

    post '/login' do 
        @user = User.find_by(:username => params[:username])
        session[:user_id] = @user.id
        redirect to "/tweets"
    end
    
    post '/signup' do
        if params[:username] != "" && params[:password] != "" && params[:email] != ""
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect to "/tweets"
        else
            redirect to "/signup"
        end
    end


end
