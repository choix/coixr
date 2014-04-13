require 'spec_helper'

describe SWQL::Transformer do
  subject { SWQL::Transformer.new.apply(tree) }

  describe 'string' do
    let(:tree) { {:string => "a string"} }
    it { expect(subject).to eq("a string")  }
  end

  describe 'integer' do
    let(:tree) { {:integer => "1"} }
    it { expect(subject).to eq(1) }
  end

  describe 'float' do
    let(:tree) { {:float => "3.14"} }
    it { expect(subject).to eq(3.14) }
  end

  describe 'boolean' do
    let(:tree) { {:boolean => "true"} }
    it { expect(subject).to eq(true) }
  end

  describe 'predicate and object' do
    let(:tree) { {:predicate => 'title', :object => "John"} }
    it { expect(subject).to eq({:title => "John"}) }
  end

  describe 'subject and messages' do
    let(:tree) { {:subject => 'articles', messages: [{:one => 'one'}, {:two => 'two'}]} }
    it { expect(subject).to eq({subject: 'articles', one: 'one', two: 'two'})}
  end

  describe 'sub triplet' do
    let(:objects) { [double('object1', id: '1'), double('object2', id: '2')] }
    before do
      allow(Node).to receive(:where)
        .with(_type: 'Category', one: 'one', two: 'two')
        .and_return(objects)
    end

    let(:tree) { {sub: { subject: 'category', :one => 'one', :two => 'two' }} }
    it { expect(subject).to eq(['1', '2']) }
  end

  describe 'root triplet' do
    let(:tree) { {root: { subject: 'article', title: 'good', category: ['two'] }} }
    it { expect(subject).to eq({_type: 'Article', title: 'good', category: ['two']}) }
  end
end