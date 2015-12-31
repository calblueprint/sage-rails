class UserArchiveJob
  include SuckerPunch::Job

  def perform
    User.role(User.roles[:student]).each { |u| u.archive }
  end
end
