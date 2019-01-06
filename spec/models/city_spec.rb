require 'rails_helper'

describe City, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
  end

  describe 'Relationships' do
    it { should have_many :user_cities }
    it { should have_many(:users).through(:user_cities) }
  end
end
