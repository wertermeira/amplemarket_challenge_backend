require 'rails_helper'

RSpec.describe Template, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[name content].each do |column|
      context "when there's #{column} column" do
        it { expect(model).to include(column) }
      end
    end
  end

  describe '.validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:name).is_at_most(200) }
    it { is_expected.to validate_length_of(:content).is_at_most(1_000_000) }
  end
end
