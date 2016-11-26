class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :owes_you, type: Float, default: 0.0
  field :owes, type: Float, default: 0.0

  validates :first_name, :email, presence: true

  def full_name
  	"#{first_name} #{last_name}".strip
  end
end
