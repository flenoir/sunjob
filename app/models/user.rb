class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
   :omniauthable, :omniauth_providers => [:twitter]

  def self.find_for_oauth(auth)
  where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
  end
end

end
