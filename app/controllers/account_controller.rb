class AccountController < ApplicationController
  def signup
    @user=User.new
    if request.post?
     @user=User.new(user_params)
     if @user.save
      PostmanMailer.alert_newuser(@user).deliver
     redirect_to :action=> "login"
    else
     render :action=> "signup"
 end 
end
end
def login
  if request.post?
    @user = User.authenticate(params[:email],params[:password])
    if @user
      session[:user]=@user.id
      puts "session:#{session[:user]}"+"  em: #{params[:email]}"
      redirect_to :action=> :dashboard
    else 
      flash[:notice] = "Invalid"
      redirect_to :action=> :login
    end 
  end
end

def logout
  session.delete(:user)
  flash[:notice] = "Logged out"
  redirect_to account_login_path
end
 def user_params
     
     params.permit(:first_name,:last_name,:email,:password,:password_confirmation,:encrypted_password)
  end
  def dashboard
    @user=User.find(session[:user])
  end
end
