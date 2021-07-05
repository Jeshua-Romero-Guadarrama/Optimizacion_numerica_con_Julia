# EJEMPLO DE CELDA EN MODO CODE
# CÓDIGO DE JULIA EJECUTABLE
# presiona el icono Run
using Latexify, LaTeXStrings

A = [ (2 ≤ i ≤ 4) ? i-j : 5 for i ∈ 1:5, j ∈ 1:5 ]

B=A
C=copy(A)

display(latexstring("Matriz\\ A"))
display(latexify(A))

A[end,1] = -1000

display(latexstring("Matriz\\ B"))
display(latexify(B))
display(latexstring("Matriz\\ C"))
display(latexify(C))


using Pkg
Pkg.add("Latexify")
Pkg.add("LaTeXStrings")
