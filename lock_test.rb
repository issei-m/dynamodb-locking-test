#!/usr/bin/env ruby

# frozen_string_literal: true

require 'digest'
require './lock'

# Do something for the given user_id.
def do_something_with_lock(user_id)
  # Generates a key using SHA-1 hash by the given user_id (converted to a string).
  # ex) When user_id=123, key="5747890eb3aae2835312596ca497111b8c858507"
  key = Digest::SHA1.hexdigest "do-smething-for-#{user_id}"

  # TTL must be specified in seconds.
  # `ttl: 60` means the operation for the same user_id is expected to be done only-once within 60 seconds.
  Lock.acquire_lock(key, ttl: 60) do
    puts 'do something!'
  end
end

do_something_with_lock('some-nice-user')
