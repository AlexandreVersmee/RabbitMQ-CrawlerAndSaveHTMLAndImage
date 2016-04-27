#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"
require "mysql"
require "./db/models/web_page.rb"
require "./lib/init_create_q.rb"

class SaveHTML

  def self.run
    check_queue_content()
  end

  private
  def self.check_queue_content()
    message_queue, channel, _ = InitCreateQ.init_create_Q(0, 37)

    puts " [*] Waiting for messages in #{message_queue.name}. To exit press CTRL+C"
    message_queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
      insert_to_db(body)
      channel.ack(delivery_info.delivery_tag, false)
    end
  end

  def self.insert_to_db(html)
    obj = WebPage.new
    obj.html = Mysql.escape_string(html)
    obj.save
    puts "HTML Sucessfully inserted to database's table \"web_page\"\n\n"
  end

end

SaveHTML.run
