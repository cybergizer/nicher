class User < ApplicationRecord
  has_many :items

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise %s[database_authenticatable], %s[registerable],
         %s[recoverable], %s[rememberable], %s[trackable], %s[validatable], %s[omniauthable],
         omniauth_providers: %i[facebook github google_oauth2]

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid:      auth.uid,
      provider: auth.provider,
      email:    User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data']) && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
