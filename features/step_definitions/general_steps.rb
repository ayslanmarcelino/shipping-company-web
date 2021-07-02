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
