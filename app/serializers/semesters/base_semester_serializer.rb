class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :season, :paused

  def season
    object[:season]
  end
end
