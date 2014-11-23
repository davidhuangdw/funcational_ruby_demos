require_relative '../reader_monad'

def drive(len=100)
  ->(state){
    speed = state[:speed]||1
    miles = state[:miles]||0
    count = state[:count]||0
    state.merge(
        miles: miles + len*speed,
        count: count + 1
    )
  }
end

def speedup(up=1)
  ->(state){
    speed = state[:speed]||1
    state.merge(speed:speed+up)
  }
end

shared_examples_for "reader monad" do
  it "should return a proc, which sequantially compute(change state) with each map " do
    final_state = result.call(state)
    expect(final_state[:count]).to eq count
    expect(final_state[:miles]).to eq miles
  end
end

describe SimpleReaderMonad do
  let(:subject) { SimpleReaderMonad.new }
  let(:result){
    subject.fmap(&drive(300))
          .fmap(&drive(200))
          .fmap(&speedup)
          .fmap(&drive(100))
          .open
  }
  let(:count) {3}

  context "For a clean state" do
    let(:state){ {} }
    let(:miles) {700}
    it_behaves_like "reader monad"
  end

  context "For a state of twice speed" do
    let(:state){ {speed:2} }
    let(:miles){ 1300 }
    it_behaves_like "reader monad"
  end

end