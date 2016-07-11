class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :season, :paused, :date_paused

  def season
    object[:season]
  end
end
