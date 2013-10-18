#!/usr/bin/env ruby

require 'rss'
require 'uri'
require 'net/http'

class HnFeed
  def self.run(limit)
    (@instance ||= HnFeed.new).run(limit)
  end

  def run(limit)
    items(limit).each { |item| puts "* #{item.title}" }
  end

  private

  def items(limit)
    RSS::Parser.parse(content, false).items[0..limit]
  end

  def content
    @content ||= Net::HTTP.get_response(URI.parse(URL).host, URI.parse(URL).path).body
  end

  URL="http://news.ycombinator.com/rss"
end

HnFeed.run(ARGV.length > 0 ? ARGV[0].to_i : 10)