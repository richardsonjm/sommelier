require 'rails_helper'

RSpec.describe Varietal, type: :model do
  it { is_expected.to validate_presence_of(:api_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:type) }

  it { is_expected.to validate_numericality_of(:api_id) }
end
