class TweetsController < ApplicationController
    enable :sessions

    get '/tweets' do 
        if logged_in?
            @tweets = Tweet.all
             erb :'tweets/index'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
             erb :'tweets/new'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id]) 
        if logged_in? && session[:user_id] == @tweet.user.id
            erb :'tweets/edit'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        if params[:content] == ""
            redirect to "/tweets/new"
        else
            @tweet = Tweet.create(params)
            @tweet.user = User.find_by_id(session[:user_id])
            @tweet.save
            redirect to "/tweets"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && session[:user_id] == @tweet.user.id
            if params[:content] == nil || params[:content] == ""
                redirect to "/tweets/#{@tweet.id}/edit"
            else
                @tweet.update(content: params[:content])
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to "/login"
        end
    end

    delete '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in? && session[:user_id] == @tweet.user_id
            @tweet.delete
            redirect to "/tweets"
        else
            redirect to "/login"
        end
    end
end
