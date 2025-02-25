require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@example.com',
      date_of_birth: '1990-01-01',
      country: 'USA'
    }
  end

  let(:invalid_attributes) do
    {
      first_name: nil,
      last_name: nil,
      email: nil,
      date_of_birth: nil
    }
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

      context 'first_name validations' do
        it "first_name is valid with valid data" do
        end

        it 'first_name can not be empty' do
          user = User.new(valid_attributes.merge(first_name: nil))
          expect(user).not_to be_valid
          expect(user.errors[:first_name]).to include("can't be blank")
        end

        it 'first_name should contain only alphabets' do
        end
      end

      context 'last_name validations' do
        it 'is not valid without a last_name' do
          user = User.new(valid_attributes.merge(last_name: nil))
          expect(user).not_to be_valid
          expect(user.errors[:last_name]).to include("can't be blank")
        end

        it 'last_name should contain only alphabets' do
        end

        it "first_name is valid with valid data" do
        end
      end

      context 'email validations' do
        it 'is not valid without an email' do
          user = User.new(valid_attributes.merge(email: nil))
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include("can't be blank")
        end

        it 'is not valid with a duplicate email' do
          User.create!(valid_attributes)
          user = User.new(valid_attributes)
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('has already been taken')
        end

        it 'is not valid with an invalid email format' do
          user = User.new(valid_attributes.merge(email: 'invalid-email'))
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end
      end

      context 'date_of_birth validations' do
        it 'is not valid without a date_of_birth' do
          user = User.new(valid_attributes.merge(date_of_birth: nil))
          expect(user).not_to be_valid
          expect(user.errors[:date_of_birth]).to include("can't be blank")
        end
      end
  end

  context 'associations' do
    # Add association tests here if you have any associations in the future
  end

  context 'scopes' do
    # Add scope tests here if you have any scopes in the future
  end

  context 'methods' do
    # Add method tests here if you have any custom methods in the future
  end
end