class SemesterMailer < ApplicationMailer
  def export_semester(user, semester, csv)
    @semester = semester
    @user = user

    attachments["#{@semester.name}.csv"] = csv
    mail(to: @user.email, subject: @semester.name)
  end
end
