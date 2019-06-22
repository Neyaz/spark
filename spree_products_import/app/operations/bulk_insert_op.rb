class BulkInsertOp < ::Subroutine::Op
  field :model
  field :data

  validates :model, presence: true

  outputs :result

  def perform
    result = model.import(data, recursive: true)
    output :result, result
  end
end
