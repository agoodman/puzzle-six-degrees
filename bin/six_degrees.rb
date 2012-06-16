#!/usr/bin/env ruby

require_relative '../lib/six_degrees'

graph = SixDegrees::Graph.new
tweets = File.open(ARGV[0]).readlines
for tweet in tweets
  graph.add_tweet(tweet)
end
graph.print
