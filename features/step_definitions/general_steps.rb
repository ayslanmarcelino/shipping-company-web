Quando('o sistema retornar a seguinte mensagem {string}') do |message|
  expect(page).to have_content(message)
end

Então('o sistema deve retornar a seguinte mensagem {string}') do |message|
  expect(page).to have_content(message)
end

Então('o sistema deve retornar os seguintes valores da tabela') do |table|
  values = table.raw

  values.each do |value|
    expect(page).to have_content(value.first)
  end
end

Quando('clicar em OK') do
  @general_page.click_yes
end

Quando('digitar a URL de admins de {string} {string}') do |method, controller|
  visit("admins/#{controller}/#{method}")
end

Quando('digitar a URL de admins de atualizar {string}') do |controller|
  visit("admins/#{controller}/#{@users.last.id}/edit")
end

Quando('digitar a URL de admins de detalhes {string}') do |controller|
  visit("admins/#{controller}/#{@users.last.id}")
end
