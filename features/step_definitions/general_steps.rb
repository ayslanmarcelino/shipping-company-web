Quando('o sistema retornar a seguinte mensagem {string}') do |message|
  expect(page).to have_content(message)
end

Então('o sistema deve retornar a seguinte mensagem {string}') do |message|
  expect(page).to have_content(message)
end
