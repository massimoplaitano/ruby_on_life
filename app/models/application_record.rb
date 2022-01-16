class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  acts_as_paranoid
  strip_attributes
end
