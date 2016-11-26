class Bill
  include Mongoid::Document
  include Mongoid::Timestamps

  field :event, type: String
  field :date, type: DateTime
  field :location, type: String
  field :total_amount, type: Float
  field :splits_in, type: Array

  embeds_many :payers, class_name: "Payer"
  accepts_nested_attributes_for :payers, :allow_destroy => true

  validates :event, :location, :total_amount, presence: true
  validates :event, inclusion: { in: BILL_EVENTS }

  after_create :calculate_owes

  private
  def calculate_owes
   	amount_per_person = self.total_amount / self.splits_in.count
   	payers = self.payers


   	self.splits_in.each do |user_id|
   		payer = payers.where(user_id: user_id).first
   		amount = (payer.amount_paid - amount_per_person)  if payer.present?
   		
   		user = (User.find(user_id) rescue nil)
   		if amount > 0
   			user.owes_you += amount
   		else
   			user.owes += -(amount) 
   		end
   		user.save
   	end
   end 
end
