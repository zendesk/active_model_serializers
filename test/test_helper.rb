require "rubygems"
require "bundler/setup"

require "pry"

require "active_model_serializers"
require "active_support/json"
require "test/unit"

require 'rails'

module TestHelper
  Routes = ActionDispatch::Routing::RouteSet.new
  Routes.draw do
    resource :hypermedia
    get ':controller(/:action(/:id))'
    get ':controller(/:action)'
  end

  ActionController::Base.send :include, Routes.url_helpers
  ActionController::Base.send :include, ActionController::Serialization
end

ActiveSupport::TestCase.class_eval do
  setup do
    @routes = ::TestHelper::Routes
  end
end

class Object
  undef_method :id if respond_to?(:id)
end
