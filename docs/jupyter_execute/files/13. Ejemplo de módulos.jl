push!(LOAD_PATH,pwd())     #Carga la lista de módulos localizados en el directorio actual
using Revise               #Actualiza automáticamente los módulos 
using PolinomiosComplejos  #Carga módulo 

?polinomio

P=polinomio(5)

a=rand(-5:5,9,1)+im*rand(-5:5,9,1)

polinomio(a)

f = (z)-> 

using SymEngine
@vars x,y,z

f(z)

f(x+im*y)

F=expand(f(x+im*y))

?realF

fr=realF(F)

?imagF

fi=imagF(F)

expand(F-(fr+im*fi))

using PGFPlotsX
using LaTeXStrings

using Contour

lx = LinRange(-1.5,1.5,200)
ly = LinRange(-1.5,1.5,200);

rf = (x,y) -> ()^2

c1 =  contours(lx, ly, rf.(lx, ly'), .4:.5:10)

plt1 =@pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
        title = "Real(P)"
    },
    Plot({
    color = "red",
    },
    Table(c1))
)

display(plt1)

imf = (x,y)-> ()^2

c2 =  contours(lx, ly, imf.(lx, ly'), .4:.5:10)

plt2 =@pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
        title = "Imag(P)"
    },
    Plot({
    color = "blue",
    },
    Table(c2))
)

display(plt2)

plt3 =@pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
        label = "Raíces de P(z)"
    },
     Plot({
     color = "red",
    },
    Table(c1)),
    Plot({
    color = "blue",
    },
    Table(c2))
)

display(plt3)

lx = LinRange(-1.5,1.5,1000)
ly = LinRange(-1.5,1.5,1000);

eps=0.01
c1 =  contours(lx, ly, rf.(lx, ly'), [eps])
c2 =  contours(lx, ly, imf.(lx, ly'), [eps])

plt =@pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
        label = "Real(P)"
    },
     Plot({
     color = "red",
    },
    Table(c1)),
    Plot({
    color = "blue",
    },
    Table(c2))
)

display(plt)

pgfsave("roots.pdf", plt; include_preamble = true, dpi = 150)
