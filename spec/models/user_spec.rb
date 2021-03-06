require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(
      name: 'Ruby',
      email: 'r@r.com',
      password: 'rrrrrr',
      password_confirmation: 'rrrrrr'
    )
  end

  describe 'Validation' do
    it 'is valid if password and password_confirmation are the same' do
      expect(@user).to be_valid
    end

    it 'is not valid if password and password_confirmation are not the same' do
      @user.password_confirmation = 'k'
      expect(@user).to_not be_valid
    end
    
    it 'is not valid if password and password_confirmation are not provided' do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end
    
    it 'is not valid if name is not provided' do
      @user.name = nil
      expect(@user).to_not be_valid
    end
    
    it 'is not valid if email is not provided' do
      @user.email = nil
      expect(@user).to_not be_valid
    end
    
    it 'is not valid if email already exists in database, not case sensitive' do
      @user.save
      another_user = User.create(name: 'Sam', email: 'R@r.cOM', password: 's', password_confirmation: 's')
      expect(another_user).to_not be_valid
    end

    it 'is not valid if the length of password is less than 6' do
      @user.password = 'hhh'
      expect(@user).to_not be_valid
    end
    
    it 'is not valid if the length of password is greater than 20' do
      @user.password = 'hhhjfdklsajfdklsafjkdlsafjkdsljafkdlsakldsajfsffs'
      expect(@user).to_not be_valid
    end
    
  end

  describe '.authenticate_with_credentials' do
    it 'should return the user if email matches the password' do
      user = User.authenticate_with_credentials('a@a.com', 'a')
      expect(user).to eql(User.find_by_email('a@a.com'))
    end

    it 'should return nil if email doesn not match the password' do
      user = User.authenticate_with_credentials('a@a.com', 'r')
      expect(user).to eql(nil)
    end

    it 'should return the user if email matches the password, does not matter with spaces around the email' do
      user = User.authenticate_with_credentials('   a@a.cOm ', 'a')
      expect(user).to eql(User.find_by_email('a@a.com'))
    end

    it 'should return the user if email matches the password, not case sensitive for the email' do
      user = User.authenticate_with_credentials('A@A.cOm', 'a')
      expect(user).to eql(User.find_by_email('a@a.com'))
    end
  end
end
