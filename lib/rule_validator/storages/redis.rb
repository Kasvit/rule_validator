require 'redis'
require_relative 'base_storage'

module RuleValidator
  module Storages
    class Redis < BaseStorage
      def initialize
        @redis_rules = ::Redis.new

        @redis_rules.hmset('report_in_company_bp', :resource, 'report_in_company_bp',
                                                      :description, 'allow access to bp report',
                                                      :params, { id: 123, bp_id: 'abc123', report_id: 128 },
                                                      :participant, {id: 123},
                                                      :methods, 'GET, POST',
                                                      :action, 'allow')
        @redis_rules.hmset('second_resourse',  :resource, 'second_resourse',
                                                :description, 'allow access to second resourse',
                                                :params, { id: 123, bp_id: 'abc123', report_id: 128 },
                                                :participant, {id: 123},
                                                :methods, 'GET',
                                                :action, 'allow')
      end

      def find_rule(rule_name)
        @redis_rules.hgetall(rule_name)
      end

      def add_rule(rule_name, **rule)
        @redis_rules.hdel(rule_name, ['resource','description', 'params',
                                      'participant', 'methods', 'action'])
        @redis_rules.hmset(rule_name,  :resource, rule[:resource],
                                       :description, rule[:description],
                                       :params, rule[:params],
                                       :participant, rule[:participant],
                                       :methods, rule[:methods],
                                       :action, rule[:action])
      end
    end
  end
end
