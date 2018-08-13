class User < ActiveRecord::Base
  has_many :items, dependent: :destroy

  TEMP_EMAIL_PREFIX = 'change@me'.freeze
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get identity of user, if this user is found
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.to_s.empty?
      # Get email for user, if provider give this
      # If email is not found - set dummy email and send to user reconfirm query over UsersController.finish_signup
      email = auth.info.email
      email = auth.extra.raw_info.email if email.to_s.empty?

      user = User.where(email: email).first if email

      # Create user, if this is new record
      if user.to_s.empty?
        user = User.new(
          first_name: auth.extra.raw_info.name,
          # username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0, 20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Attach identity to user, if must this
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize

  def email_verified?
    email && email !~ TEMP_EMAIL_REGEX
  end
end
