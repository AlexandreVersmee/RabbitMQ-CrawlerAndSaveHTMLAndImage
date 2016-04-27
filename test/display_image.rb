#!/usr/bin/env ruby
# encoding: utf-8

require "./db/models/image.rb"
require 'base64'


class DisplayImage

  def self.run
    createimg()
  end

  def self.createimg()
    pick = ARGV[0] || 42

    img = Image.find_by(id:pick)

    File.open("image.jpg", "w") do |f|
      f.write(Base64.decode64(img.content))
    end

  end
end

DisplayImage.run
