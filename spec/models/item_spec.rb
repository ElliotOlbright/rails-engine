require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Associations' do
    xit { should belong_to(:merchant) }
  end
end