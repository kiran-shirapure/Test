class Payer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: BSON::ObjectId
  field :amount_paid, type: Float

  embedded_in :bill

  def user
  	User.find(self.user_id) rescue nil
  end
end