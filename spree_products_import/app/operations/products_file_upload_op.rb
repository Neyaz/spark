class ProductsFileUploadOp < ::Subroutine::Op
  field :io

  validates :io, presence: true

  outputs :path

  UPLOAD_PATH = 'public/uploads'.freeze

  def perform
    unless File.directory?(upload_path)
      FileUtils.mkdir_p(upload_path)
    end
    
    path = file_path(io.original_filename)

    File.open(path, 'wb') do |file|
      file.write(io.read)
    end
    output :path, path
  end

  private

  def file_path(filename)
    Rails.root.join(UPLOAD_PATH, filename)
  end

  def upload_path
    Rails.root.join(UPLOAD_PATH)
  end
end
