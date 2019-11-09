module ImageAttachable
  extend ActiveSupport::Concern
  included do
    has_one :image_attachment,
      as: :attachable,
      dependent: :delete
    has_one :image,
      through: :image_attachment
    accepts_nested_attributes_for :image_attachment,
      reject_if: proc { |attributes| attributes['image_id'].blank? }
  end

  def image_exists?
    self.image_attachment.present?
  end
end
