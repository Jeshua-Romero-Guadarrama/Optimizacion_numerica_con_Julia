using LinearAlgebra

A=rand(5,5)

A+=I

?lu

A=rand(5,5)

F=lu(A)

L=F.L

U=F.U

using Latexify

latexify(L)

latexify(U)

b=ones(5,1);

L=F.L
U=F.U
y=L\b

x=U\y

A\b

?cholesky

A=rand(10,5)

B=A'A+I

C=cholesky(B)

C.L

chol(A*A')

isposdef(A*A')

?qr

A=rand(8,5)

F=qr(A)

F.Q

F.R

qr(A, Val(true))
