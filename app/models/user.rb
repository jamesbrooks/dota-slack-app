class User < ActiveRecord::Base
  include UserSteam


  def to_s
    name
  end
end
