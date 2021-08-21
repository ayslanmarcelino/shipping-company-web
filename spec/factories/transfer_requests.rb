FactoryBot.define do
  factory :transfer_request do
    method_cd { 'ted' }
    type_cd { 'advance' }
    value { '500.50' }
    enterprise { create(:enterprise) }
    truckload { create(:truckload) }
    bank_account { create(:bank_account) }
  end
end
