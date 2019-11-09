module ImageUploadable
  extend ActiveSupport::Concern

  included do
    include S3Uploadable
  end

  def content_class
    Image
  end
end
