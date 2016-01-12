RSpec.describe BlockStore::Wrapper do

  describe '#initialize' do

    let(:target) { Object.new }

    subject { described_class.new(target) }

    it 'should save the target' do
      saved_target = subject.instance_variable_get(:@target)
      expect(saved_target).to be(target)
    end

    it 'should create an empty store' do
      store = subject.instance_variable_get(:@store)
      expect(store).to eq({})
    end

  end

  describe '#block' do

    subject { described_class.new([1, 2, 3]) }

    let(:expected_block) do
      Proc.new {}
    end

    before(:each) do
      subject.instance_variable_set(:@store, {
        :some_method => expected_block
      })
    end

    it 'should retrieve the stored block' do
      expect(subject.block(:some_method)).to be(expected_block)
    end

    it 'should return nil when no block is stored' do
      expect(subject.block(:another_method)).to be(nil)
    end

  end

  describe 'sending messages to the target' do

    subject { described_class.new([1, 2, 3]) }

    let(:map_block) do
      Proc.new { |number| number * 2 }
    end

    context 'providing a block' do

      before(:each) do
        subject.map(&map_block)
      end

      it 'should store the provided block' do
        expect(subject.block(:map)).to be(map_block)
      end

      it 'should be able to play back the stored block' do
        result = subject.block(:map).call(5)
        expect(result).to eq(10)
      end

    end

    context 'not providing a block' do

      it 'should store nil when no block is given' do
        subject.length
        expect(subject.block(:length)).to be(nil)
      end

    end

  end

end
