class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      @user = User.new
      auth = request.env["omniauth.auth"]
      @user.provider = auth.provider
      @user.uid = auth.uid
      @user.email = auth.info.email

      # session["devise.facebook_data"] = request.env["omniauth.auth"]
      # redirect_to new_user_registration_url
      render "devise/registrations/new", resource: @user
    end
  end

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      # session["devise.google_data"] = request.env["omniauth.auth"]
      # redirect_to new_user_registration_url
      @user = User.new
      auth = request.env["omniauth.auth"]
      if auth.info
        auth = auth.info
      end


      puts "AAuth#{auth}"
      @user.provider = auth.provider
      @user.uid = auth.uid
      @user.email = @user.provider == 'google_oauth2' ? auth[:email] : auth.info.email

      # session["devise.facebook_data"] = request.env["omniauth.auth"]
      # redirect_to new_user_registration_url
      render "devise/registrations/new", resource: @user
    end
  end


  def failure
    redirect_to root_path
  end

end