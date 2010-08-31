require 'smart_filter/generate_sql'
require 'smart_filter/filter.rb'

module SmartFilter
  include GenerateSQL
  include Filter
end

ActionView::Base.send :include, ViewHelpers
ActiveRecord::Base.send :extend, SmartFilter

require 'smart_filter/before_filter'

ActionController::Base.send :before_filter, :sort_smart_filter
