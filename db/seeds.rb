
puts "Cadastrando as Categorias"
categories = [
                "Carros",
                "Motos",
                "Vans",
                "Microônibus",
                "Ônibus",
                "Caminhões",
                "Carregadeiras",
                "Escavadeiras",
                "Guinchos"
            ]

categories.each do |category|
    Category.find_or_create_by!(description: category)
end

puts "Categorias Cadastradas com sucesso!"

###############################################################################


puts "Cadastrando o Administrador Principal..."

Admin.create!(
    name: "Management",
    email: "admin@admin.com", password: '123456', 
    password_confirmation: '123456',
    role: 0
    )
puts "Administrador Padrão adicionado!"