using PGFPlotsX, Contour, LaTeXStrings, Latexify, Printf, LinearAlgebra

"""
Rutina para resolver el sistema de ecuaciones lineales `Ax=b` por método de descenso del gradiente

Entrada: 

* `A`  arreglo n×n 
* `b`  arreglo n×1 
* `itmax`  número máximo de iteraciones
* `tol`  tolerancia a la aproximación

Salida:

* `x` arreglo con la aproximación de la solución
* `X` conjunto de aproximaciones de x
"""
function miG(A::Array{Float64},b::Array{Float64}, itmax::Int64, tol::Float64)
        n = length(b)

        x = zeros(n,1)    # aprox inicial en el origen
        it = 0        # contador 
        nd = norm(b)        # tamaño del residual
        XX=[]
        # CICLO PRINCIPAL
            while nd ≥ tol # criterio de paro por tamaño del residual
                XX=push!(XX,x)
        
                # muestra tamaño del gradiente
                cad = @sprintf "%1.5e" nd
                display(latexstring("\$\\|d_{$it}\\|\$ = "*cad))
                d = b-A*x       # nuevo gradiente ortogonal al anterior
                α  = d'*d / (d'*A*d)                # mínimo sobre la línea
                x +=  α[1]*d               # actualiza la aproximación
                it += 1                # actualiza contador
                ( it ≥ itmax ) && break                # criterio de paro por iteraciones
                nd=norm(d)
            end
    
            if ( it < itmax ) 
               println("salí por tamaño de gradiente")
            else
               println("salí por iteraciones") 
            end

            cad = @sprintf "%1.5e" nd            # muestra tamaño del último residual
            display(latexstring("\$\\|g_{$it}\\|\$ = "*cad))
            XX=push!(XX,x)
            XX=[( i[1],i[2] ) for i in XX]

    return x,XX
end

A=[6.0 -5.0; -5.0 5.0]
b=[4.0;0.0]
A\b

latexify(A)

x,XX=miG(A,b, 1000,  1e-5);

X = LinRange((x[1]-5),(x[1]+5),50)
Y = LinRange((x[2]-5),(x[2]+5),50)
R=[ (i,j) for  i in X, j in Y];

f = (u) -> ((1/2)*[u[1] u[2]] *A*[u[1]; u[2]])[1]-b'*[u[1]; u[2]]
c =  contours(X, Y, f.(R), 20)

    plt = @pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
    },
     Plot({
     color = "red",
    },
    Table(c)),
    Plot(
        {
        },
        Coordinates(XX)
    )
)

display(plt)

"""
Rutina para resolver el sistema de ecuaciones lineales `Ax=b` por método del gradiente conjugado

Entrada: 

* `A`  arreglo n×n 
* `b`  arreglo n×1 
* `itmax`  número máximo de iteraciones
* `tol`  tolerancia a la aproximación

Salida:

* `x` arreglo con la aproximación de la solución
"""
function miGC(A::Array{Float64},b::Array{Float64}, itmax::Int64, tol::Float64)
        n = length(b)

        x = vec(zeros(n))    # aprox inicial en el origen
        r = -vec(b)        # gradiente inicial = residual inicial = - lado derecho 
        p = -r       # primera dirección contraria al gradiente inicial
        it = 0        # contador 
        nr = norm(r)        # tamaño del residual
        XX=[]

        # CICLO PRINCIPAL
            while nr ≥ tol # criterio de paro por tamaño del gradiente
                XX=push!(XX,x)

                # muestra tamaño del residual
                cad = @sprintf "%1.5e" nr
                display(latexstring("\$\\|r_{$it}\\|\$ = "*cad))
        
                α  = -r'*p / (p'*A*p)                # mínimo sobre la línea
                x +=  α[1]*p                # actualiza la aproximación
                rnew = A*x-b        # nuevo residual ortogonal al anterior
                β = ((rnew'*rnew) / (r'*r))[1]        # coeficientes para A-ortogonalidad de las direcciones
                r = rnew                # actualiza gradiente
                nr = norm(r)                # tamaño del residual
                p = -r + β*p                # actualiza dirección
                it += 1                # actualiza contador
                ( it ≥ itmax ) && break                # criterio de paro por iteraciones
            end
    
            if ( it < itmax ) 
               println("salí por tamaño de gradiente")
            else
               println("salí por iteraciones") 
            end

            cad = @sprintf "%1.5e" nr            # muestra tamaño del último residual
            display(latexstring("\$\\|r_{$it}\\|\$ = "*cad))
                XX=push!(XX,x)

                XX=[( i[1],i[2] ) for i in XX]

    return x,XX
end

X = LinRange((x[1]-5),(x[1]+5),50)
Y = LinRange((x[2]-5),(x[2]+5),50)
R=[ (i,j) for  i in X, j in Y];

f = (u) -> ((1/2)*[u[1] u[2]] *A*[u[1]; u[2]])[1]-b'*[u[1]; u[2]]
c =  contours(X, Y, f.(R), 20)

    plt = @pgf Axis(
    {
        xlabel = "x",
        ylabel = "y",
    },
     Plot({
     color = "red",
    },
    Table(c)),
    Plot(
        {
        },
        Coordinates(XXc)
    ),
    
    Plot(
        {
        },
        Coordinates(XX)
    )
    
)

display(plt)

using IterativeSolvers

?cg!

n = length(b)
x = vec(zeros(n)) 

cg!(x,A,b)

function prodT(X::Array{Float64})
    s  = size(X)
    TX = zeros(s)
    TX[1,:] = 2X[1,:] -X[2,:]    
    TX[2:end-1,:] = -X[1:end-2,:] + 2X[2:end-1,:] -X[3:end,:]
    TX[end,:] = -X[end-1,:] + 2X[end,:]
    return TX
end

function vecb(funf::Function, px::Array{Float64}, u₀::Number,uₙ₊₁::Number)
    # núm de pts en partición
    n = length(px)
    # lado derecho de la ecuación diferencial en la partición
    fx = funf.(px)
    # lado derecho del sistema de ecuaciones lineales
    b  = fx/(n+1)^2
    b[1] += u₀
    b[end] += uₙ₊₁
    return b
end

function miCG(fun::Function,b::Array{Float64}, itmax::Int64 = 300, tol::Float64 = 1e-5)
        #=
            Rutina para resolver sistema de ecuaciones lineales
                Ax=b
            por método del gradiente conjugado
    
            Entrada: 
                función fun para realizar producto matriz vector
                arreglo b   con el lado derecho
            Salida:
                arreglo x con la aproximación de la solución
        =#

            l = length(b)
            # aprox inicial en el origen
            x = zeros(l) 
            # gradiente inicial = residual inicial = - lado derecho
            g = -copy(b) 
            # primera dirección contraria al gradiente inicial
            d = -copy(g)
            # contador 
            it = 0
            # máximo numéro de iteraciones
            #itmax = 300
            # tamaño del gradiente
            ng = norm(g)
            # toleracia
            #tol = 1e-5
            # CICLO PRINCIPAL
            while ng ≥ tol # criterio de paro por tamaño del gradiente
                # muestra tamaño del gradiente
                cad = @sprintf "%1.5e" ng
                display(latexstring("\$\\|g_{$it}\\|\$ = "*cad))
                # rutina para producto matriz vector
                Ad = fun(d)
                # mínimo sobre la línea
                α  = (g'*g) / (d'*Ad)
                # actualiza la aproximación
                x +=  α*d
                # nuevo gradiente ortogonal al anterior
                gnew = g + α*Ad
                # coeficientes para A-ortogonalidad de las direcciones
                β = (gnew'*gnew) / (g'*g)
                # actualiza gradiente
                g = gnew
                # tamaño del gradiente
                ng = norm(g)
                # actualiza dirección
                d = -g + β*d
                # actualiza contador
                it += 1
                # criterio de paro por iteraciones
                ( it ≥ itmax ) && break
            end
            if ( it < itmax ) 
               println("salí por tamaño de gradiente")
            else
               println("salí por iteraciones") 
            end
            # muestra tamaño del último gradiente
            cad = @sprintf "%1.5e" ng
            display(latexstring("\$\\|g_{$it}\\|\$ = "*cad))
    return x
end

function poisson1DCG(funf::Function, n::Int64, u₀::Number = 0,uₙ₊₁::Number = 0)
    # partición del intervalo [0,1] en n+2 pts
    px = LinRange(0,1,n+2)
    # partición del intervalo (0,1) en n pts
    px = collect(px)[2:end-1]
    # lado derecho del sistema de ecuaciones
    b = vecb(funf,px, u₀,uₙ₊₁)
    # solución del sistema de ecuaciones lineales por CG
    ûx = miCG(prodT,b)
    return px, ûx
end

# lado derecho de ecuación diferencial
ff(x) =  cos(π*x)
# solución analítica a la ecuación de poisson con el lado derecho anterior 
u(x) = (cos(π*x) + 2.0x - 1.0)/π^2

# partición y solución aprox en partición
px, ûx = poisson1DCG(ff,30)
# solución analítica en la partición
ux = u.(px);

plt = @pgf Axis({
        height = "12cm",
        width  = "12cm",
        xlabel = L"$x$",
        ylabel = L"$u(x) = \frac{\pi}{2}(\cos(\pi x) + 2x - 1)$",
        title  = "solución de "*L"$-u''(x) = \cos(\pi x),\ u(0)=u(1)=0 $"*" por CG"
        },
        PlotInc({"no marks",  color="blue"},Coordinates(px,ux)),
        LegendEntry("exact"),
        PlotInc({"only marks",color="red"}, Coordinates(px,ûx)),
        LegendEntry("aprox")
    )

# guarda gráfica de solución
pgfsave("sol1.pdf", plt; include_preamble = true, dpi = 150)
