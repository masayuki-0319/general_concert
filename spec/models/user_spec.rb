require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      name: 'Test',
      email: 'test@example.com'
    )
  end
  let(:valid_addressess) do
    %w(
      user@example.com
      USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn
    )
  end
  let(:invalid_addresses) do
    %w(
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com foo@bar+baz.com
    )
  end

  context '#Validation' do
    subject do
      user.valid?
      expect(user).not_to be_valid
    end

    it '全属性の有効性' do
      user.valid?
      expect(user).to be_valid
    end

    it '無効（nameの存在性)' do
      user.name = nil
      subject
    end

    it '無効（nameの長さ)' do
      user.name = 'a' * 51
      subject
    end

    it '無効（emailの存在性)' do
      user.email = nil
      subject
    end

    it '無効（emailの長さ)' do
      user.email = 'a' * 256
      subject
    end

    it 'emailのフォーマットの有効性' do
      valid_addressess.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it '無効（emailのフォーマット）' do
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        subject
      end
    end

    it '無効（emailの一意性）' do
      dup_user = user.dup
      dup_user.email.upcase!
      dup_user.save
      subject
    end
  end
end
