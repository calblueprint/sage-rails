class SemesterMailer < ApplicationMailer
  def export_semester(user, semester, csv)
    @semester = semester
    @user = user

    mail(to: @user.email, subject: 'SAGE semester export')
  end
end
