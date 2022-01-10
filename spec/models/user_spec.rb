require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should save user when all fields are filled in' do 
      user = User.new(
        name: 'test',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it "should not validate when email is missing" do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
  
      user.email = 'test@test.com' 
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it "should not validate when name is missing" do
      user = User.new(name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
  
      user.name = 'test' 
      user.valid? 
      expect(user.errors[:name]).not_to include("can't be blank")
    end

    it "should not validate when password doesn't match" do
      user = User.new(
        name: 'test',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'pass'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it 'should not validate, email must be unique' do
      user = User.new
      user.name = 'name'
      user.email = 'test@test.com'
      user.password = 'password'
      user.password_confirmation = 'password'

      user.save
    
      newUser = User.new
      newUser.name = 'name'
      newUser.email = 'test@test.com'
      newUser.password = 'password'
      newUser.password_confirmation = 'password'
      newUser.save
    
      expect(newUser.errors[:email].first).to eq('has already been taken')
    end

    it 'should not validate when password length is less than 5 characters' do
      user = User.new
      user.name = 'name'
      user.email = 'test@test.com'
      user.password = '1234'
      user.password_confirmation = '1234'
      expect(user).to be_invalid
    end
    end

    describe '.authenticate_with_credentials' do 
      it 'should pass with valid credentials' do
        user = User.new(
          name: 'name',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
        user.save

        user = User.authenticate_with_credentials('test@test.com', 'password')
        expect(user).not_to be(nil)
      end

      it 'should not pass with invalid credentials' do
        user = User.new(
          name: 'name',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
        user.save
  
        user = User.authenticate_with_credentials('test@test.com', 'pass')
        expect(user).to be(nil)
      end

      it 'should pass with spaces present in email' do
        user = User.new(
          name: 'name',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
        user.save
  
        user = User.authenticate_with_credentials('  test@test.com  ', 'password')
        expect(user).not_to be(nil)
      end

      it 'should pass even with caps present in email' do
        user = User.new(
          name: 'name',
          email: 'test@test.com',
          password: 'password',
          password_confirmation: 'password'
        )
        user.save
  
        user = User.authenticate_with_credentials('TesT@tEst.cOm', 'password')
        expect(user).not_to be(nil)
      end
    end
end
