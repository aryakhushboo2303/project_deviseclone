class PasswordController < ApplicationController
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_pass = create_pass
        PostmanMailer.alert_forpass(@user,new_pass).deliver
        @user.update(:password=>new_pass)
        redirect_to account_login_path
      else
        flash[:notice]=" Invalid email"
        render :action=>forgot_password
      end
     end
  end
  def create_pass
    (0...8).map { ('a'..'z').to_a[rand(26)] }.join
  end

  def reset_password
    @user = User.find(session[:user])
    if request.post?
      if @user
        PostmanMailer.alert_resetpass(@user).deliver
        if @user.update(user_params)
          flash[:notice]= "Password reseted"
          redirect_to account_dashboard_url
        else
          render :action=> :reset_password
        end
      end
    end
  end
  def user_params
    params.permit(:password,:password_confirmation)
  end
end
