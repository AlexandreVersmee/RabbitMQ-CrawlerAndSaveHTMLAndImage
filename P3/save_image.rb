#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"
require "./lib/init_create_q.rb"
require "./db/models/image.rb"

class CheckQueueContent

  def self.run
    check_queue_content()
  end

  private
  def self.check_queue_content()
    message_queue, channel, _ = InitCreateQ.init_create_Q(0, 1337)

    puts " [*] Waiting for messages in #{message_queue.name}. To exit press CTRL+C"
    message_queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
      puts "Received an image ! \n\n"
      save_image(body)
      channel.ack(delivery_info.delivery_tag, false)
    end
  end

  private
  def self.save_image(image)
    img = Image.new
    img.content = image
    img.save()
  end
end

CheckQueueContent.run
