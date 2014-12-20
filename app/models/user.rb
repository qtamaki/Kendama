# -*- encoding: utf-8 -*-
class User < ActiveRecord::Base
  email_regexp = /\A[^@]+@[^@]+\z/
  validates_presence_of     :email, :login, :encrypted_password, :nickname
  validates_uniqueness_of   :email, allow_blank: false, scope: [:deleted, :deleted_at]
  validates_uniqueness_of   :nickname, allow_blank: false, scope: [:deleted, :deleted_at]
  validates_format_of       :email, with: email_regexp, allow_blank: true, if: :email_changed?

end

