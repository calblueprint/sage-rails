class PhotoUtils
  def self.convert_base64(data)
    return unless data

    temp_file = Tempfile.new [Devise.friendly_token, "jpg"]
    temp_file.binmode
    temp_file.write(Base64.decode64(data))

    ActionDispatch::Http::UploadedFile.new(tempfile: temp_file, filename: "#{Devise.friendly_token}.jpg")
  end
end
