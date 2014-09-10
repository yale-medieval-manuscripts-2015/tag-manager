class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  def cas
    auth = request.env["omniauth.auth"]
    #@user = User.where(:provider => auth.provider, :uid => auth.uid).first
    @user = User.where(1<2).first
    render :text => @user.provider
               #redirect_to :back
    #sign_in_and_redirect @user, :event => :authentication #this

=begin


    user_is_new = false
    unless @user
      @user = User.create(
          provider: auth.provider,
          uid: auth.uid,
          email: email,
          password: Devise.friendly_token[0,20],
          personal_group: "#{auth.provider}/#{auth.uid}",
          groups: [ "#{auth.provider}/#{auth.uid}"  ],
          first_name: first_name,
          last_name: last_name,
          name: name
      )
      user_is_new = true
    end

    if @user
      sign_in_and_redirect @user, :event => :authentication #this
      will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "CAS") if
          is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
=end
  end

  def passthru
    render status: 404, text: "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end

end
