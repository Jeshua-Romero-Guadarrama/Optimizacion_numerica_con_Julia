using SymEngine

@vars x y z

x=symbols(:x)
y=symbols(:y)
z=symbols(:z)

x,y,z = symbols("x y z")

x+3*x+5*x

A = [symbols("a_$i$j") for i in 1:4, j in 1:4]

A^2

b=rand(-10:10,4,1)

A*b

expand((x+y)^3)

expand((x+y+z)^2)

subs((x+y)^3, x=>2*y)

subs((x+y)^3, x=>2)

subs(3*x*y^2 + 3*x^2*y + x^3 + y^3, x^2=>2)

subs(3*x*y^2 + 3*x^2*y + x^3 + y^3, x=>1, y=>-1)

diff(3*x*y^2 + 3*x^2*y + x^3 + y^3, x)

diff((2*x+y)^3, x)

diff(sin(x), x)

diff(log(x), x)

diff(atan(x), x)

diff(sin(exp(log(atan(x)))), x)

diff(sinc(x), x)

using SymEngine

"""
---
### polinomio(n::Int64)

Rutina para construir un polinomio de grado `n` en la variable simbólica `z`

ENTRADA

    n  :  entero

SALIDA

    p  :  polinomio de grado n

---

### polinomio(a::Array)

Rutina para construir un polinomio en la variable simbólica `z` 

ENTRADA

    a  :  arreglo 1D

SALIDA

    p  :  polinomio cuyos coeficientes son los elementos de a
---
"""
function polinomio(n::Int64)
    I=-5:5
    a=rand(I,n+1,1)+im*rand(I,n+1,1)
    p = [ symbols("z^$i") for i in 0:n]
    P=(a'*p)[1]
    
    return P
end

function polinomio(a::Array{})
    (m,)=size(a)
    (n,)=size(a')
    
    k=length(a)
    p = [ symbols("z^$i") for i in 0:k-1]
    
    if (m == 1)&(n ≠ 1)
        P=(a*p)[1]
    
    elseif (n == 1)&(m ≠ 1)
        P=(a'*p)[1]
    
    elseif (m == 1)&(n == 1)
        P=a[1]*symbols("z^0")
    
    else
        P=println("Error: Debes introducir un arreglo 1D")
    
    end
    
    return P
end

?polinomio

a=collect(1:10)
polinomio(a)

b=rand(3,1)
polinomio(b)

c=rand(1,3)
polinomio(c)

d=[1 2; 2 3]
polinomio(d)

polinomio([5])

polinomio(5)
