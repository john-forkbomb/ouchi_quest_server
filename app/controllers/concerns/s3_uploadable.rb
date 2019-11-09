module S3Uploadable
  extend ActiveSupport::Concern

  def publish_policy
    @s3_useable = content_class.new(content_params)
    @s3_useable.generate_path!

    if @s3_useable.save
      render json: {
        object: @s3_useable,
        form: @s3_useable.upload_policy.fields,
        upload_url: @s3_useable.upload_policy.url
      }, status: :created
    else
      render_errors @s3_useable
    end
  end

  def attach
    @storable = self.instance_variable_get("@#{storable_name.underscore}")

    @target_contents = content_class.where(id: content_ids)

    @attachable_class = "#{content_class}Attachment".constantize
    @target_contents.each do |target|
      attachable = @attachable_class.create!(
        attachable: @storable,
        content_class.name.underscore.to_sym => target
      )

      @storable.increment_size_by target.size if content_class == 'Album'
    end

    head :no_content
  end

  def detach
    @storable = self.instance_variable_get("@#{storable_name.underscore}")
    @target_contents = content_class.where(id: content_ids)
    @storable.send(content_class.name.underscore.pluralize.to_s).destroy @target_contents

    @storable.decrement_size_by @target_contents.sum(&:size) if content_class == 'Album'

    render json: @storable
  end

  private

  def content_params
    params.require(content_class.name.underscore.to_sym).permit(
      :content_type,
      :size,
      :original_name
    ).merge(
      user_id: current_user.id,
      former_path_pattern: former_path_pattern
    )
  end

  def storable_name
    self.controller_name.classify
  end

  def content_ids
    ids_sym = "#{content_class.name.underscore}_ids".to_sym
    params.require(storable_name.underscore.to_sym).permit(
      ids_sym => []
    )[ids_sym]
  end
end
