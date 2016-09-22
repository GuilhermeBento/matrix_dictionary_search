# spec/matrix_spec.rb
require_relative '../matrix'
RSpec.describe('Matrix', type: :request) do
  context 'to_roman' do
    let(:matrix) { Matrix.new(2) }

    context 'After creating Matrix' do
      it 'is 2x2 matrix' do
        expect(matrix.instance_variable_get(:@width)).to eq(2)
        expect(matrix.instance_variable_get(:@height)).to eq(2)
      end
    end
  end
end
