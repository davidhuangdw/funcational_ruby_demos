require_relative '../maybe_monad'

describe MaybeMonad do
  let(:value) {[1,2,3]}
  context "without monad" do
    it "should raise error, if keeping pop an array" do
      expect{value.pop.pop.pop.pop}.to raise_error
    end
  end
  context "with maybe monad" do
    let(:subject) {MaybeMonad.create(value)}
    let(:pop) { ->(arr){arr[1..-1]} }
    let(:after_two_pop) {subject.fmap(&pop).fmap(&pop)}
    let(:after_five_pop) {after_two_pop.fmap(&pop).fmap(&pop).fmap(&pop)}
    it "should compute sequentially" do
      expect(after_two_pop.open).to eq [3]
    end
    it "shouldn't raise error, if keeping pop" do
      expect{after_five_pop}.not_to raise_error
      expect(after_five_pop.open).to eq nil
    end
  end
end