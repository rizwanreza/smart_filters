require 'smart_filters/smart_filter.rb'
require 'smart_filters/view_helpers'
require 'smart_filters/before_filter'

ActionController::Base.send :before_filter, :sort_smart_filter
ActionView::Base.send :include, ViewHelpers
ActiveRecord::Base.send :extend, SmartFilter