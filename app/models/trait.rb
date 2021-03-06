class Trait < ActiveRecord::Base
  attr_accessible :name, :options_attributes

  validates :name, presence: true, uniqueness: true

  has_many :options, dependent: :destroy

  has_many :user_traits, dependent: :destroy

  accepts_nested_attributes_for :options, :reject_if => lambda { |o| o[:value].blank? }, :allow_destroy => true

  def self.with_options
    Trait.all.reject{ |trait| trait.options.empty? }
  end

  def self.no_options
    Trait.all.reject{ |trait| trait.options.any? }
  end


  def one_line_name
    name + " " +
    (options.empty? ? "[no options]" : "[" + options.pluck(:value).join(", ") + "]")
  end

end
