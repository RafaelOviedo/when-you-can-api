# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password_confirmation) }

  it { is_expected.to validate_length_of(:first_name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_length_of(:last_name).is_at_least(3).is_at_most(50) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }
  it { is_expected.to validate_length_of(:password_confirmation).is_at_least(8) }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to have_secure_password }

  subject { FactoryBot.build(:user) }

  describe ':password_digest' do
    before { subject.save }

    context 'when the user is created' do
      it 'adds a password digest' do
        expect(subject.password_digest).not_to be_nil
      end
    end
  end

  describe 'password validations' do
    context 'when password has blank values' do
      it 'is not valid' do
        subject.password = ''
        subject.password_confirmation = ''
        expect(subject).to_not be_valid
      end
    end

    context 'when password and password_confirmation don`t match' do
      it 'does not update the password' do
        subject.password = 'some_new_password'
        subject.password_confirmation = 'some_new_different_password'
        expect(subject).to_not be_valid
        expect(subject.errors[:password_confirmation][0]).to eq("doesn't match Password")
      end
    end

    context 'when password and password_confirmation match' do
      it 'does update the password' do
        subject.password = 'some_new_password'
        subject.password_confirmation = 'some_new_password'
        expect(subject).to be_valid
        expect(subject.errors).to be_empty
      end
    end
  end

  describe '#with_first_name' do
    let(:first_name_filter) { nil }
    let(:first_name) { 'some name' }
    let(:user) { create(:user, first_name: first_name) }
    subject { User.with_first_name(first_name_filter) }

    context 'when there is an exact match' do
      let(:first_name_filter) { first_name }
      it { is_expected.to include(user) }
    end

    context 'when there is a partial match' do
      let(:first_name_filter) { 'some' }
      it { is_expected.to include(user) }
    end

    context 'when there is a match with different cases' do
      let(:first_name_filter) { first_name.upcase }
      it { is_expected.to include(user) }
    end

    context 'when there is no match' do
      let(:first_name_filter) { 'bad name' }
      it { is_expected.not_to include(user) }
    end
  end

  describe '#with_last_name' do
    let(:last_name_filter) { nil }
    let(:last_name) { 'some name' }
    let(:user) { create(:user, last_name: last_name) }
    subject { User.with_last_name(last_name_filter) }

    context 'when there is an exact match' do
      let(:last_name_filter) { last_name }
      it { is_expected.to include(user) }
    end

    context 'when there is a partial match' do
      let(:last_name_filter) { 'some' }
      it { is_expected.to include(user) }
    end

    context 'when there is a match with different cases' do
      let(:last_name_filter) { last_name.upcase }
      it { is_expected.to include(user) }
    end

    context 'when there is no match' do
      let(:last_name_filter) { 'bad name' }
      it { is_expected.not_to include(user) }
    end
  end

  describe '#with_email' do
    let(:email_filter) { nil }
    let(:email) { 'cool email' }
    let(:user) { create(:user, email: email) }
    subject { User.with_email(email_filter) }

    context 'when there is an exact match' do
      let(:email_filter) { email }
      it { is_expected.to include(user) }
    end

    context 'when there is a partial match' do
      let(:email_filter) { 'cool' }
      it { is_expected.to include(user) }
    end

    context 'when there is a match with different cases' do
      let(:email_filter) { email.upcase }
      it { is_expected.to include(user) }
    end

    context 'when there is no match' do
      let(:email_filter) { 'bad email' }
      it { is_expected.not_to include(user) }
    end
  end

  describe '#with_admin' do
    let(:admin_filter) { nil }
    let(:admin) { true }
    let(:user) { create(:user, admin: admin) }
    subject { User.with_admin(admin_filter) }

    context 'when there is an exact match' do
      let(:admin_filter) { admin }
      it { is_expected.to include(user) }
    end

    context 'when there is no match' do
      let(:admin_filter) { false }
      it { is_expected.not_to include(user) }
    end
  end
end
