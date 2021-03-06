class UserTrait < ActiveRecord::Base
  attr_accessible :option_id, :trait_id, :user_id, :value, :trait, :option

  belongs_to :user
  belongs_to :trait
  belongs_to :option

  validates :trait_id, presence: true
  validates :user_id, presence: true

  validate :has_option_or_value

  delegate :name, :options, to: :trait

  def get_value
    option.nil? ? value : option.value
  end

  def self.ordered_name
    UserTrait.find(:all, :joins => :trait, :order => 'traits.name')
  end

  private

    def has_option_or_value
      unless !option_id.nil? or !value.blank? or new_record?
        errors[:value] << 'Need a value'
      end
    end
end
