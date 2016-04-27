#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"
require "./lib/init_create_q.rb"

class CheckQueueContent

  def self.run
    check_queue_content()
  end

  private
  def self.check_queue_content()
    message_queue, channel, _ = InitCreateQ.init_create_Q(0, 42)

    puts " [*] Waiting for messages in #{message_queue.name}. To exit press CTRL+C"
    message_queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
      puts "Received #{body}\n\n"
      channel.ack(delivery_info.delivery_tag, false)
    end
  end
end

CheckQueueContent.run
