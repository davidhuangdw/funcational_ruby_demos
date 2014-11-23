require_relative '../maybe_monad'
require 'ostruct'

describe MaybeMonad do
  let(:value) {(1..3).map{|i| OpenStruct.new(name:"#{i}")}}
  context "without monad" do
    it "should raise error, if reading an empty array" do
      3.times {value.pop}
      expect{value.first.name}.to raise_error
    end
  end

  context "with maybe monad" do
    let(:subject) {Maybe(value)}
    let(:pop) { ->(arr){arr.pop; arr} }
    let(:after_two_pop) {subject.try(&pop).try(&pop)}
    let(:after_five_pop) {after_two_pop.try(&pop).try(&pop).try(&pop)}

    it "should compute sequentially" do
      first_name = after_two_pop.try(&:first).try(&:name)
      expect(first_name).to eq Just.new("3")
    end

    it "shouldn't raise error, if reading an empty pop" do
      first_name = nil
      expect do
        first_name = after_five_pop.try(&:first).try(&:name)
      end.not_to raise_error
      expect(first_name).to eq Nothing.new
    end
  end
end