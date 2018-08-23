class AuthService
  include UsersHelper
  attr_reader :auth, :signed_in_resource
  attr_reader :user
  TEMP_EMAIL_PREFIX = 'change@me'.freeze

  def initialize(auth, signed_in_resource = nil, user = nil)
    @auth = auth
    @signed_in_resource = signed_in_resource
    @user = user
  end

  def find_for_oauth
    identity = Identity.find_for_oauth(@auth)
    @user = user_select(identity)
    @user = user_create unless @user.present?
    identity.add_identity(@user)
    @user
  end

  private

  def user_select(identity)
    @signed_in_resource || identity.user
  end

  def user_create
    user = User.new(fill_user_fields)
    user_save(user)
  end

  def fill_user_fields
    email = email_from_auth
    {
      first_name: @auth.extra.raw_info.name,
      email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{@auth.uid}-#{@auth.provider}.com",
      password: Devise.friendly_token[0, 20]
    }
  end

  def email_from_auth
    @auth.info.email || @auth.extra.raw_info.email
  end
end
