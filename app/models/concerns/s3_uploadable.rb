module S3Uploadable
  extend ActiveSupport::Concern

  attr_accessor :former_path_pattern

  EXPIRES = 1.minute

  included do
    validates :path, format: { with: %r{\A([\w-]+\/)+[\w-]+\.[a-z]+\z} }
  end

  def mime_type
    content_type && Mime::Type.lookup(content_type)
  end

  def extname_from_mime
    mime_type.symbol.to_s
  end

  def uuid
    @uuid ||= SecureRandom.uuid
  end

  def generate_path!
    raise 'former path pattern is not valid' unless former_path_pattern.is_a?(Array) &&
                                                    former_path_pattern.map { |e| e.is_a? String }.all?

    self.path ||= File.join(former_path_pattern + %W(#{uuid}.#{extname_from_mime}))
  end

  def upload_policy
    bucket.presigned_post(
      url: "https://#{aws_creds(:s3_bucket)}.s3.dualstack.#{aws_creds(:region)}.amazonaws.com",
      content_type: mime_type.to_s,
      key: self.path,
      content_length_range: size..size,
      expires: EXPIRES.from_now.utc,
      cache_control: 'max-age=315360000',
      metadata: {
        'original-filename' => '${filename}'
      }
    )
  end

#   def url
#     bucket.object(path).public_url
#   end
#
#   def presigned_url
#     urls[:original]
#   end
#
#   def download_presigned_url
#     urls(attachment: true)[:original]
#   end
#
#   def urls(attachment: false)
#     uri = URI::HTTPS.build(
#       host: Settings.cloudfront.host,
#       path: '/' + path.sub('uploaded/', 'cloudfront/'),
#       query: 'response-content-disposition=' + URI.encode(
#         "#{attachment ? 'attachment; ' : ''}filename*=UTF-8''#{URI.encode(original_name)}"
#       )
#     )
#
#     fetch_signed_urls(uri)
#   end

  private

#   def fetch_signed_urls(uri)
#     key = "cf-upload-signed-url:#{uri}"
#     expires_in = Settings.cloudfront.expires.seconds - 1.hour
#
#     Rails.cache.fetch(key, expires_in: expires_in) do
#       signed_urls(uri)
#     end
#   end
#
#   def signed_urls(uri)
#     if self.content_type.match?(/\Aimage/)
#       ImageUrls.new(uri).to_h
#     else
#       SharedFileUrls.new(uri).to_h
#     end
#   end

  def creds
    if Settings.s3.use_iam_profile
      Aws::InstanceProfileCredentials.new
    else
      Aws::Credentials.new(aws_creds(:access_key_id), aws_creds(:secret_access_key))
    end
  end

  def s3_client
    Aws::S3::Client.new(
      region: aws_creds(:region),
      credentials: creds,
      use_dualstack_endpoint: true
    )
  end

  def bucket
    @bucket ||= Aws::S3::Bucket.new(
      name: aws_creds(:s3_bucket),
      client: s3_client
    )
  end

  def aws_creds(key)
    Rails.application.credentials.dig(:aws, key)
  end
end
