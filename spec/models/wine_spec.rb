require 'rails_helper'

RSpec.describe Wine, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price_retail) }
end
