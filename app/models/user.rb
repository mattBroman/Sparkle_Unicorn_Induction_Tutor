class User < ApplicationRecord
    has_many :questions, dependent: :destroy
    has_many :tags, dependent: :delete_all
    has_many :attempts, dependent: :delete_all
    has_and_belongs_to_many :sections
    
    def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
