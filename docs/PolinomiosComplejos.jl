module PolinomiosComplejos

    using SymEngine

    export polinomio
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
        P = (a'*p)[1]
        P = replace(string(P), "I" => "im")       
        return P
    end

    function polinomio(a::Array{})
        (m,)=size(a)
        (n,)=size(a')
    
        k=length(a)
        p = [ symbols("z^$i") for i in 0:k-1]
    
        if (m == 1)&(n ≠ 1)
            P = (a*p)[1]
            P = replace(string(P), "I" => "im")
        elseif (n == 1)&(m ≠ 1)
            P = (a'*p)[1]
            P = replace(string(P), "I" => "im")
        elseif (m == 1)&(n == 1)
            P = a[1]*symbols("z^0")
            P = replace(string(P), "I" => "im")
        else
            P=println("Error: Debes introducir un arreglo 1D")
    
        end
    
        return P
    end


    export realF
    """
    ---
    ### realF(F::Basic)

    Rutina que regresa la parte Real de un polinomio complejo en las variables simbólicas x, y
    
    `F(x,y)=Real(F)+im*Imag(F)`

    ENTRADA

        F        :  polinomio simbólico que depende de x,y 

    SALIDA

        Real(F)  : parte real de F

    ---
    """
    function realF(F::Basic)
        fr=Basic(replace(string(F), "I" => "0"))    
        return fr
    end

    export imagF
    """
    ---
    ### imagF(F::Basic)

    Rutina que regresa la parte Imaginaria de un polinomio complejo en las variables simbólicas x, y
    
    `F(x,y)=Real(F)+im*Imag(F)`

    ENTRADA

        F        :  polinomio simbólico que depende de x,y 

    SALIDA

        Imag(F)  : parte imaginaria de F

    ---
    """
    function imagF(F::Basic)
        fi=Basic(replace(string(expand(F-realF(F))...), "I" => "1"))
    return fi
    end


end