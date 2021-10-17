require 'rails_helper'

RSpec.describe Comment, 'validations' do
  it { is_expected.to validate_presence_of(:body) }
end
