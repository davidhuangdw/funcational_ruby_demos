require_relative '../writer_monad'

describe LogWriterMonad do
  def half(x); x/2 end
  def sum(arr); arr.reduce(0,:+) end

  let(:value) {200}
  let(:subject) {LogWriterMonad.new(value)}
  let(:result) {
    subject.fmap(&method(:half))
          .fmap{|v| (1..v).to_a}
          .fmap(&method(:sum))
  }
  it "should compute sequentially" do
    res, logs = result.open
    expect(res).to eq 5050
  end
  it "should log for every map" do
    res, logs = result.open
    expect(logs.size).to eq 3

    expect(logs[0]).to match /Invoke.*with 200/
    expect(logs[1]).to match /Invoke.*with 100/
    expect(logs[2]).to match /Invoke.*with\s*#{(1..100).to_a}/
  end
end