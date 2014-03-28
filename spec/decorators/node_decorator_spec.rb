require 'spec_helper'

describe NodeDecorator do
  let(:node) { double('node') }
  subject { NodeDecorator.new(node).send(method_name) }

  describe '.id' do
    pending
  end

  describe '.link' do
    let(:method_name) { :link }
    before do
      allow(node).to receive(:title).and_return('Title')
      allow(node).to receive(:url).and_return('http://example.com')
    end

    it { expect(subject).to eq("<a href=\"http://example.com\">Title</a>") }
  end

  describe '.host' do
    let(:method_name) { :host }
    before do
      allow(node).to receive(:url).and_return('http://example.com/article/1')
    end

    it { expect(subject).to eq('http://example.com') }
  end
end
