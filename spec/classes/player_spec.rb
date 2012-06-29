require '../spec_helper'
require '../../classes/player'
require '../../classes/hand'
describe Player do
  context 'When initialized' do
    let(:player) { Player.new }
    it 'should have 100 dollars' do
      player.cash.should be(100)
    end
  end
end
