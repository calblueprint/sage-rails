class BaseCheckInSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :verified, :comment, :school_id, :user_id

  def start
    object.start.in_time_zone("Pacific Time (US & Canada)")
  end

  def finish
    object.finish.in_time_zone("Pacific Time (US & Canada)")
  end
end
