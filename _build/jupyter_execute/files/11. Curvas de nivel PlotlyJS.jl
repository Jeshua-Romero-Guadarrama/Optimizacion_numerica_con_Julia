using PlotlyJS

layout = Layout(showlegend = false,
                autosize   = false, 
	            width  = 800, 
	            height = 800,
				xaxis_constrain   = "range", #restringe los ejes al dominio/(al rango)
	            yaxis_scaleanchor = "x") #Preservar la relación de aspecto

"""
Contornos(f,Ix,Iy)

Rutina para trazar curvas de nivel de una función f: [a, b] × [c, d] → R

ENTRADA

    f   rutina para evaluar la función

        entrada: x arreglo 1D de longitud 2

        salida: evaluación de f en x

    Ix  partición del intervalo [a, b], de tipo LinRange

    Iy  partición del intervalo [c, d], de tipo es LinRange

SALIDA

    plt figura con la gráfica de las curvas de nivel
"""
function Contornos(f::Function, Ix::LinRange{Float64}, Iy::LinRange{Float64})

	n  = length(Iy)
	z  = [f([xᵢ;yⱼ]) for xᵢ ∈ Ix,  yⱼ ∈ Iy]
	z_ = [z[:,j] for j in 1:n]
	data = contour(z=z_, x=Ix, y=Iy, showscale  = false)
	plt  = plot(data,layout)

	display(plt)
    
    return plt

end

?Contornos

f(x::Array{Float64}) =  (x[1]^2+x[2]^2-1).^2+(x[2]-x[1]^2).^2

Ix = LinRange(-1.,1.,501)
Iy = LinRange(-.2,1.2,501)

Contornos(f,Ix,Iy);
