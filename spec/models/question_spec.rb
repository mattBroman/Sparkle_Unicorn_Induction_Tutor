require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { described_class.new }
  
  it 'is valid with valid attributes' do
    subject.title = 'anything'
    subject.val = 'anything'
    subject.p_k = 'anything'
    subject.implies = 'anything'
    subject.difficulty = 'anything'
    expect(subject).to be_valid
  end
  it 'is not valid without Title' do
    expect(subject).to_not be_valid 
  end
  it 'is not valid without a Value' do
    subject.title = 'anything'
    expect(subject).to_not be_valid
  end
  it 'is not valid without a p(k)' do
    subject.title = 'anything'
    subject.val = 'anything'
    expect(subject).to_not be_valid
  end
  it 'is not valid without a implies' do
    subject.title = 'anything'
    subject.val = 'anything'
    subject.p_k = 'anything'
    expect(subject).to_not be_valid
  end
  it 'is not valid without a difficulty' do
    subject.title = 'anything'
    subject.val = 'anything'
    subject.p_k = 'anything'
    subject.implies = 'anything'
    expect(subject).to_not be_valid
  end
end
