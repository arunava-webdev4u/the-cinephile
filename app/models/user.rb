class User < ApplicationRecord
    has_many :lists
    after_create :create_fixed_lists

    COUNTRIES = [ "United States", "Canada", "India", "United Kingdom", "Australia", "China" ]
    VALID_EMAIL_DOMAINS = [ "@gmail.com", "@yahoo.com", "@protonmail.com" ]
    before_validation :strip_whitespace, :normalize_email, :normalize_country

    validates :first_name, :last_name, :email, :date_of_birth, presence: true

    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/, message: "must contain only alphabets" }
    validates :country, format: { with: /\A[a-zA-Z\s]+\z/, message: "must contain only letters and spaces" }, inclusion: { in: COUNTRIES, message: "is not in our country list" }

    validate :validate_date_of_birth, :validate_email_domain

    private

    def validate_date_of_birth
        return if date_of_birth.blank?

        unless date_of_birth.is_a?(Date)
            errors.add(:date_of_birth, "must be a valid date")
        end

        if date_of_birth > Date.current
            errors.add(:date_of_birth, "can not be today or a future date")
        end
    end

    def validate_email_domain
        return if email.blank?

        VALID_EMAIL_DOMAINS.each do |domain|
            return if email.include?(domain)
        end

        errors.add(:email, "domain is not supported")
    end

    def normalize_email
        self.email = email.downcase if email.present?
    end

    def normalize_country
        self.country = country.titleize if country.present?
    end

    def strip_whitespace
        self.first_name = first_name.strip if first_name.present?
        self.last_name = last_name.strip if last_name.present?
        self.email = email.strip if email.present?
        self.country = country.strip if country.present?
    end

    def create_fixed_lists
        FixedList.create(user: self, name: "WatchList")
        FixedList.create(user: self, name: "Watched")
        FixedList.create(user: self, name: "Favourite Movies")
        FixedList.create(user: self, name: "Favourite TV Shows")
    end
end
