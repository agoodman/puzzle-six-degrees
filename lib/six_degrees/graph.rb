module SixDegrees

  class Graph

    def initialize
      @nodes = []
      @mentions = {}
    end
  
    # 
    # used to populate the graph
    #
    def add_tweet(tweet)
      # grab sender
      source = tweet.scan(/^([a-zA-Z0-9_]+)?\:.+/).flatten[0]

      # only add to nodes if not already there
      @nodes << source unless @nodes.include?(source)
    
      # grab mentions
      mentions = tweet.scan(/\@([a-zA-Z0-9_]+)/).flatten

      # add mentions if found 
      if @mentions[source]
        @mentions[source] = (@mentions[source] + mentions).uniq 
      else
        @mentions[source] = mentions
      end
    end

    #
    # returns true if source and target have mentioned each other
    #
    def is_mutual_mention?(source,target)
      return false unless @mentions[source] && @mentions[target]
      @mentions[source].include?(target) && @mentions[target].include?(source)
    end
    
    #
    # returns an array of nodes who have mutually mentioned the given node
    #
    def mutual_mentions_for(source)
      @mentions[source].select {|mention| is_mutual_mention?(source,mention)}
    end

    #
    # prints the nodes and their connections
    #
    def print
      for node in @nodes
        puts node
        visited_nodes = [node]
        next_level = mutual_mentions_for(node)
        while !next_level.empty?
          visited_nodes = (visited_nodes + next_level).uniq
          puts next_level.join(", ")
          next_level = (next_level.map {|n| mutual_mentions_for(n)}.flatten - visited_nodes).uniq
        end
        puts
      end
    end
  
  end

end
