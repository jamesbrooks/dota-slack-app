require 'open-uri'

class SteamAPI
  BASE_URI = 'http://api.steampowered.com'

  class << self
    def get_friend_list(id, relationship: 'friend')
      res = request('ISteamUser/GetFriendList/v0001', {
        steamid:      id,
        relationship: relationship
      })

      # filter
      res['friendslist']['friends'].map { |f| f['steamid'] }
    end

    def get_player_summaries(ids)
      # API allows a maxmimum of 100 ids at a time
      ids.each_slice(100).flat_map do |ids|
        res = request('ISteamUser/GetPlayerSummaries/v0002', {
          steamids: ids.join(',')
        })

        # filter
        res['response']['players']
      end
    end


  private
    def request(path, args={})
      puts "[STEAM]    #{path}    #{args.inspect}"

      args  = args.merge(key: ENV['STEAM_WEB_API_KEY'])
      query = URI.encode_www_form(args)
      url   = "#{BASE_URI}/#{path}?#{query}"

      JSON.parse(open(url).read)
    end
  end
end
