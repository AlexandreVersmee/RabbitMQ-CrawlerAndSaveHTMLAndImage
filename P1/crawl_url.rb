#!/usr/bin/env ruby
# encoding: utf-8
require "bunny"
require "cobweb"
require "./lib/init_create_q.rb"

class CrawleWebsitesOfQueue

  def self.run
    get_urls_from_queue()
  end

  private
  def self.get_urls_from_queue
    message_queue_1, channel_1, _ = InitCreateQ.init_create_Q(0, 42)

    puts " [*] Waiting for messages in #{message_queue_1.name}. To exit press CTRL+C"
    message_queue_1.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
      puts "Received #{body}\n\n"
      crawl_urls(body)
      channel_1.ack(delivery_info.delivery_tag, false)
    end
  end

  def self.crawl_urls(url)
    # create a new cobweb crawler with the settings required
    crawler = CobwebCrawler.new()

    puts "---- Web site crawled => `#{url}` ----\n\n"
    crawler.crawl(url) do |content|
      if content[:mime_type] == "image/jpeg" || content[:mime_type] == "image/png"
        puts "Envoi de l'image (JPG/PNG)"
        send_images(content[:body])
      elsif content[:mime_type] == "text/html"
        puts "Envoi du HTML"
        send_htmls(content[:body])
      end
    end
  end

  def self.send_htmls(html)
    message_queue, channel, connection = InitCreateQ.init_create_Q(1, 37)
    channel.default_exchange.publish(html, :routing_key => message_queue.name)
    puts "Add message in #{message_queue.name} and #{message_queue.message_count} messages not treated\n\n"
    connection.close
  end

  def self.send_images(img)
    message_queue, channel, connection = InitCreateQ.init_create_Q(2, 1337)
    channel.default_exchange.publish(img, :routing_key => message_queue.name)
    puts "Add in #{message_queue.name} and #{message_queue.message_count} messages not treated\n\n"
    connection.close
  end
end

CrawleWebsitesOfQueue.run
