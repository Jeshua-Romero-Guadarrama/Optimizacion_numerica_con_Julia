using Plots

pyplot()

using Pkg
Pkg.add("PyPlot")
Pkg.add("PlotlyJS")
Pkg.add("PGFPlotsX")

#función anónima  para la gaussiana
f(x) = exp(-x^2/2)/√(2π)

# puntos de la cuadrática y=1/2-x²
x = LinRange(-5,5,201)
y = fill(1/2,201) - x.^2/50;

# gráfica de la gaussiana
plt = plot(f,-6,6,label = "f(x) = exp(-x²/2)/√(2π)")

# gráfica los puntos de la cuadrática
scatter!(x,y,label = "f₂(x) = 1/2 - x²/50")

savefig(plt,"mis gráficas.pdf")

using PGFPlotsX    #Paquete de Graficación basado en Latex-Tikz
using LaTeXStrings #Para mostar código LaTex en pantalla
using DelimitedFiles #Para importar tu archivo de texto con los datos

Data  = readdlm("datos.txt");
E     = Data[:,1]
dos   = Data[:,2]
p_dos = Data[:,3]
display(Data)

plt = @pgf Axis(
    {
        title = "Densidad de Estados del Óxido de Aluminio",
        xlabel = "Energía (eV)",
        ylabel = "Densidad de Estados (Estados/eV)",
        height = "7.5cm",
        width = "15cm",
    },  
    
    LegendEntry(L"Densidad\ de\ Estados\ Al_2O_3"),
    
    Plot(
        {
             color = "blue",
        },
        Coordinates(E,p_dos)
    ),
        
)

pgfsave("gráfico.pdf", plt; include_preamble = true, dpi = 300)

# En esta libreta ya cargamos el módulo de gráficación con
# backend pyplot por lo que no es necesario volver a cargarlo 
using Plots
pyplot()

n = 50
rango = LinRange(-4,4,n)
X = repeat(rango',n,1)
Y = repeat(rango,1,n)

surface(X,Y, @. exp(-(X^2/2 + Y^2/2)))

n = 51
animación2 = 
@animate for θ ∈ LinRange(0,π/2,11)
            u = LinRange(-π,π,n)
            v = LinRange(-1,1,n)
    
            x = cos(θ)*sin.(u)*sinh.(v)' +  sin(θ)*cos.(u)*cosh.(v)'
            y = -cos(θ)*cos.(u)*sinh.(v)' +  sin(θ)*sin.(u)*cosh.(v)'
            z = u*fill(cos(θ),1,n) +  fill(sin(θ),n)*v'
    
            surface(x,y,z, xlim=(-1,1), ylim=(-1.,1.), zlim=(-2.5,2.5))
end
gif(animación2, "catenoid.gif", fps = 1);
Cambia esta celda al modo markdown y presiona Run para mostrar animación

<img src="catenoid.gif">  

