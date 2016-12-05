class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :email, presence: true
  validates :my_token, presence: true

  # attr_accessible :uid, :provider, :my_token

  def self.from_omniauth(auth)
    if auth.info
      auth = auth.info
    end
    # puts "User#{auth.inspect}"

    # if user
    #   user.email = auth.info.email
    #   user.password = Devise.friendly_token[0,20]
    #   # user.name = auth.info.name   # assuming the user model has a name
    #   # user.image = auth.info.image # assuming the user model has an image
    # else
    #   params[:provider] = auth.provider
    #   params[:uid] = auth.uid
    # end
    where(provider: auth.provider, uid: auth.uid).first
  end

end
