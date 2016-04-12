class SessionSerializer < BaseSessionSerializer
  attributes :check_in_requests, :sign_up_requests

  has_one :user, serializer: UserSerializer
  has_one :school, serializer: SchoolSessionSerializer
  has_one :current_semester, serializer: SemesterListSerializer

  def check_in_requests
    object.is_director? ? CheckIn.verified(false).school_id(object.director_id).size : 0
  end

  def sign_up_requests
    object.is_director? ? User.verified(false).school_id(object.director_id).size : 0
  end

  def user
    object
  end

  def school
    object.school
  end

  def current_semester
    Semester.current_semester.first
  end
end
