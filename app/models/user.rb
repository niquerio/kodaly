class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  has_many :answered_questions
  #has_many :question_factories #is this right? I don't think so

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
     # user.image = auth.info.image # assuming the user model has an image
    end
  end
  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |user|
  #    user.provider = auth.provider
  #    user.uid = auth.uid
  #    user.name = auth.info.name
  #    user.email = autho.info.email
  #    #user.oauth_token = auth.credentials.token
  #    #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #    user.save!
  #  end
  #end


end
