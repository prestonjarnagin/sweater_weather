require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
  end

  describe 'Relationships' do
    it { should have_many :user_cities }
    it { should have_many(:cities).through(:user_cities) }
  end
end
