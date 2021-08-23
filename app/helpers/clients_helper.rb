module ClientsHelper
  def clients_collection
    @clients = []

    Client.includes(:address).where(enterprise: current_user.enterprise).each do |client|
      @clients << ["#{client.company_name} - #{client.address.state} | #{client.document_number.to_br_cnpj}", client.id]
    end

    @clients.sort
  end
end
