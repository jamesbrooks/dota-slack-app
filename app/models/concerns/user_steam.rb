module UserSteam
  extend ActiveSupport::Concern


  module ClassMethods
    def find_or_create_from_auth_hash(auth_hash)
      find_or_create_by(steam_id: auth_hash['uid']) do |user|
        user.name       = auth_hash['info']['nickname']
        user.avatar_url = auth_hash['extra']['raw_info']['avatarfull']
      end
    end
  end


  def friend_ids
    @friend_ids ||= SteamAPI.get_friend_list(steam_id)
  end

  def friends
    missing_ids = friend_ids - User.where(steam_id: friend_ids).pluck(:steam_id)

    # Fetch missing friends
    SteamAPI.get_player_summaries(missing_ids).each do |user_data|
      User.create({
        steam_id:   user_data['steamid'],
        name:       user_data['personaname'],
        avatar_url: user_data['avatarfull']
      })
    end

    User.where(steam_id: friend_ids).order(name: 'asc')
  end
end
