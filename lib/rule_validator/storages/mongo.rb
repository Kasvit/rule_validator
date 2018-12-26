require_relative 'base_storage'
require 'mongo'

module RuleValidator
  module Storages
    class Mongo < BaseStorage
        def initialize(settings_line = ENV["SETTINGS_LINE"],
                       database: ENV["DATABASE"],
                       collection: ENV["COLLECTION"])

        @collection = collection.to_sym

        Mongo::Logger.logger.level = ::Logger::FATAL
        @client = Mongo::Client.new([ settings_line ], database: database )
      end

      def find_rule(rule_name)
        @client[@collection].find(resource: rule_name).entries.first
      end

      def add_rule(rule)
        @client[@collection].insert(rule)
      end
    end
  end
end
