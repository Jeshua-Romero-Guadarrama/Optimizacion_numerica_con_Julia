function prodA(X::Array{Float64},h::Float64,q::Array{Float64},p::Array{Float64})
    n  = length(X)
    
    A1X = zeros(n)
    A1X[1] = -2X[1] +X[2]    
    A1X[2:end-1] = X[1:end-2] - 2X[2:end-1] +X[3:end]
    A1X[end] = X[end-1] - 2X[end]
    
    A2X = zeros(n)
    A2X =h^2*q.*X
    
    A3X = zeros(n)
    A3X[1] = (h/2)*p[1].*X[2]    
    A3X[2:end-1] = (h/2)* p[2:end-1].*(-X[1:end-2]+X[3:end])
    A3X[end] = -(h/2)*p[end].*X[end-1]
    
    AX = A1X+A2X+A3X
    return AX
end

function vecb(f::Function, px::Array{Float64}, u₀::Number, uₙ₊₁::Number,p::Function)
    # núm de pts en partición
    n = length(px)
    h = px[2]-px[1]
    # lado derecho de la ecuación diferencial en la partición
    fx = f.(px)
    # lado derecho del sistema de ecuaciones lineales
    b  = fx*h^2
    b[1]  = b[1]- (1-p.(px[1])*(h/2))*u₀
    b[end]= b[end]- (p.(px[end])*(h/2)+1)*uₙ₊₁
    return b
end

using Printf, LinearAlgebra,LaTeXStrings

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

function ODE2_1DCG(f::Function, p::Function, q::Function, n::Int64, u₀::Float64 = 0.0, uₙ₊₁::Float64 = 0.0, α::Float64 = 0.0, β::Float64 = 1.0 )
    # partición del intervalo [0,1] en n+2 pts
    px = LinRange(α,β,n+2)
    # partición del intervalo (0,1) en n pts
    px = collect(px)[2:end-1]
    # lado derecho del sistema de ecuaciones
    h=(β-α)/(n+1)
    b = vecb(f, px, u₀, uₙ₊₁, p)
    # solución del sistema de ecuaciones lineales por CG
    P=collect(p.(px))
    Q=collect(q.(px))
    F= (x)-> prodA(x,h,Q,P)
    ûx = miCG(F,b)
    return px, ûx
end

f = x-> 0.0
p = x-> 0.0
q = x-> 1.0

α = 0.0
β = 10.0

u₀   = 0.0
uₙ₊₁ = 1.0

n = 75

px, ûx=ODE2_1DCG(f, p, q, n, u₀, uₙ₊₁, α, β )

using PGFPlotsX

# solución analítica 
u(x) = csc(10)*sin(x)
ux = u.(px);

plt = @pgf Axis({
        height = "12cm",
        width  = "12cm",
        xlabel = L"$x$",
        },
        PlotInc({"no marks",  color="blue"},Coordinates(px,ux)),
        LegendEntry("exact"),
        PlotInc({"only marks",color="red"}, Coordinates(px,ûx)),
        LegendEntry("aprox")
    )

f = x-> 0.0
p = x-> x
q = x-> -1.0

α = 0.0
β = 1.0

u₀   = 0.0
uₙ₊₁ = 1.0

n = 10

px, ûx=ODE2_1DCG(f, p, q, n, u₀, uₙ₊₁, α, β )


# solución analítica
u(x) =x
ux = u.(px);

plt = @pgf Axis({
        height = "12cm",
        width  = "12cm",
        xlabel = L"$x$",
        },
        PlotInc({"no marks",  color="blue"},Coordinates(px,ux)),
        LegendEntry("exact"),
        PlotInc({"only marks",color="red"}, Coordinates(px,ûx)),
        LegendEntry("aprox")
    )

f= x-> 1/x^2
p= x-> 3/x
q= x-> 1/x^2

α = 1.0
β = 2.0

u₀   = 0.0
uₙ₊₁ = 0.0

n = 20

px, ûx=ODE2_1DCG(f, p, q, n, u₀, uₙ₊₁, α, β )

# solución analítica
u(x) = 1 - log(2*x)/(x*log(2))
ux = u.(px);

plt = @pgf Axis({
        height = "12cm",
        width  = "12cm",
        xlabel = L"$x$",
        },
        PlotInc({"no marks",  color="blue"},Coordinates(px,ux)),
        LegendEntry("exact"),
        PlotInc({"only marks",color="red"}, Coordinates(px,ûx)),
        LegendEntry("aprox")
    )
