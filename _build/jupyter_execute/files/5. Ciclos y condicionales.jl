letra = "α"
abc = ("α","β",0,1)
letra in abc

a = 21
C = rand(0:50,5,5)

a in C

R = rand([1,10,100,1000],3,3)

R[3,3] == 1000

R[2,2] ≠ 1000

A = [1 10
     100 1000]
A == R[1:2,1:2]

R[ R .== 1000] .= 0
R

r = rand(0:10)
r ≤ 5

C = rand(0:50,5,5)

( 40 ∈ C ) | ( 17 ∈ C ) | ( 23 ∈ C ) 

|( 40 ∈ C, 17 ∈ C, 23 ∈ C )

( 9 ∈ C ) & ( 28 ∈ C )

r = rand(["J,","U","L","I","A"])
if r == "L" println("$r"); end

 |(r == "L",r == "A")  ?  println("acertaste\nvalor de variable = $r") : println("fallaste")

ram = Sys.total_memory() *2.0^(-20);

using Printf

if 2000 < ram ≤ 4000
    s=@sprintf "Mi RAM es de 4GB"
else
    s=@sprintf "Mi RAM es de %1.3e GB" ram
   end
println(s)

x = 1.0; contador = 0; tmp = 0.0;



using Pkg
Pkg.installed()



T = [ i-j for j in 1:5, i in 1:5 ]



n = 10000; r = rand(n);

A₁ = Array{Float64, 2}(undef, n, n);  #pre alocación de un arreglo sin inicialización
@elapsed for i ∈ 1:n A₁[i,:] = r; end

A₂ = Array{Float64, 2}(undef, n, n);
@elapsed for j ∈ 1:n A₂[:,j] = r; end

A₃ = Array{Float64, 2}(undef, n, n); 
@elapsed A₃ = repeat(r,1,n)


