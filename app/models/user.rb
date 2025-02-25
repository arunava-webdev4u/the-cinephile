class User < ApplicationRecord
    validates :first_name, :last_name, :email, :date_of_birth, presence: true
    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
