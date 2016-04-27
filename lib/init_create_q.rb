#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"

# DRY !
class InitCreateQ
  def self.init_create_Q(argv_index, default_value)
    queue_id = ARGV[argv_index] || default_value

    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    message_queue = channel.queue("Q#{queue_id}")

    return message_queue, channel, connection
  end
end