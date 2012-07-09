require '../spec_helper'
require '../../classes/player'
require '../../classes/hand'

describe Player do
  context 'When initialized' do
    its(:cash) { should be(100) }
    its(:status) { should be(:playing) }
    its(:bet) { should be(0) }
    its(:hand) { should be_a(Hand) }
  end
end

describe ActivePlayer do
  context '#place_bet' do
    it 'should increase bet by 25' do
      subject.place_bet
      subject.bet.should be(25)
    end
    it 'should decrease cash by 25' do
      subject.place_bet
      subject.cash.should be(75)
    end
  end
end

describe Human do
  context 'When initialized' do
    its(:name) { should == 'Brett' }
    its(:pos) { should be(1) }
  end
end

describe Bot do
  context 'When initialized' do
    its(:pos) { should be_a(Integer) }
    its(:name) { should be_a(String) }
  end
end
