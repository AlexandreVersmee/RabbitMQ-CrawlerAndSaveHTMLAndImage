#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"
require "./db/models/url.rb"
require "./lib/init_create_q.rb"

class CreateFillQ1

  def self.run
    message_queue, channel, connection = InitCreateQ.init_create_Q(0, 42)

    # Get All url store in database
    @all_urls = Url.all

    puts "Nombre d'urls dans all_url #{@all_urls.length}"

    @all_urls.each do |url|
      channel.default_exchange.publish(url.url, :routing_key => message_queue.name)
      puts "Add in #{message_queue.name} => #{url.url} and #{message_queue.message_count} messages not treated"
    end
    connection.close
  end
end

CreateFillQ1.run