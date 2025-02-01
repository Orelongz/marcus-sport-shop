class ApplicationRecord < ActiveRecord::Base
  include RansackConcern

  primary_abstract_class
end
