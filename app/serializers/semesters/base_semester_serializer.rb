class BaseSemesterSerializer < ActiveModel::Serializer
  attributes :id, :start, :finish, :season

  def season
    object[:season]
  end
end
