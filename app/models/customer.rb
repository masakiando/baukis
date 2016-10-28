class Customer < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },
    class_name: 'Phone', autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after_or_equal_to: Date.new(1900, 1, 1),
    before: ->(obj) { Date.today },
    allow_blank: true
  }
  before_save do
    if birthday
      self.birth_year = birth.year
      self.birth_month = birth.month
      self.birth_mday = birth.mday
    end
  end
end
