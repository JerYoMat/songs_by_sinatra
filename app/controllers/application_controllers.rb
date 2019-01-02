require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'tbdsomethinglongandhardwhenitmatters'
  end
#This should be before other route handlers.
  get('/styles.css'){ scss :styles }


  get '/' do
    erb :index
  end

  get '/about' do
    @title = "All About This Website"
    erb :about
  end

  get '/contact' do
    erb :contact
  end

  not_found do
    erb :not_found
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def authorized_user?
        @loan && @loan.user == current_user
    end
end

end
