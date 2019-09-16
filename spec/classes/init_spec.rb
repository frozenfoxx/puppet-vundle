require 'spec_helper'
describe 'vundle' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('vundle') }
  end
end
