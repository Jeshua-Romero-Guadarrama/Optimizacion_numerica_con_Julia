contactos = Dict("Mao" => "mao777@hotmail.com", "Rubia" => "soloruby01@yahoo.com" )

califica = Dict("Hugo Pancera" => 6, "Sofía Regalado" => 10, "Octavia Ortiz" => 8  )

contactos["Mao"]

contactos["Rubia"]

# Utiliza pop! para remover elementos de un diccionario
pop!(contactos,"Rubia") 

# Agrega elementos a un diccionario 
contactos["Julia"] = "jjson2002@gmail.com" 

contactos

contactos["Julia"] = "jjson2012@gmail.com"

contactos

contactos[1]

arreglo_caracteres = [ 'a','b','c' ]

arreglo_cadenas = [ "JPG","PNG","GIF" ]

arreglo_enteros = [ 1, 10, 100, 1000 ]

arreglo1_flotantes = [ 1/3, π, 0.52, 1e2 ]

arreglo2_flotantes = [ 1/3 π 0.52 1e2 ]

arreglo_mixto = [ "pan" 14.5 10 ]

Arreglo_2D=[[1, 2, 0] [3, 4, 0]]

Arreglo_1D=[1, 2, 0, 3, 4, 0]

length(Arreglo_2D)

using Latexify

latexify(Arreglo_2D)

latexify(Arreglo_2D)|> print

latexify(Arreglo_1D)

latexify(Arreglo_1D)|> print

ones(5)

ones(Int64,5)

zeros(3)

zeros(3,1)

zeros(3,4)

zeros(Int64,3,4)

rand(4)

rand(4,4)

# Podemos especificar el rango donde se toman los números
rand(-10:10,4,4) 

# Podemos usar un arreglo arbitrario de donde tomar los elementos
rand(['α','β','γ','δ','ϵ'],4,4) 

#Partición del intervalo [-π,π] de 11 puntos
R = LinRange(-π,π, 11)
P = collect(R) 

println(typeof(R)) 
println(typeof(P)) 

fill(π,3)

fill(Float64(π),3) #Float64(x) cambia el tipo de x a Float64

fill(Float64(π),3,2)

r=rand(3,4)

vec(r)

reshape(r,2,6) #cambiamos de una matriz 3×4 a una matriz 2×6

r'

typeof(r')

typeof(collect(r'))

collect(r')

t = ("h", 1, [1, 2, 3], π)

typeof(t)

t[1]

t[3]

t[1]*"ola!"

t[4] = 3.1416
