# frozen_string_literal: true

require 'aws-sdk-dynamodb'

class Lock
  class << self
    def acquire_lock(key, ttl: 60)
      table_name = 'job_locks'
      dynamodb = Aws::DynamoDB::Client.new

      current_time = Time.now.to_i
      expires_at = current_time + ttl

      begin
        dynamodb.put_item({
                            table_name: table_name,
                            item: {
                              'Key' => key,
                              'ExpiresAt' => expires_at
                            },
                            condition_expression: 'attribute_not_exists(#key) OR #expiresAt <= :now',
                            expression_attribute_names: {
                              '#key' => 'Key',
                              '#expiresAt' => 'ExpiresAt'
                            },
                            expression_attribute_values: {
                              ':now' => current_time
                            }
                          })

        if block_given?
          yield
        end
      rescue Aws::DynamoDB::Errors::ConditionalCheckFailedException
        nil
      end
    end
  end
end
