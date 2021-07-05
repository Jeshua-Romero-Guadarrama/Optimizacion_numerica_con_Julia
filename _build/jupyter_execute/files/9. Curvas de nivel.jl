using PGFPlotsX

using Contour

x = LinRange(-1,1,100)
y = LinRange(-1,1,100)

f = (x,y) -> (x^2+y^2-1)^2+(y-x^2)^2

c =  contours(x, y, f.(x, y'), 10)

plt = @pgf Plot({
        contour_prepared,
        very_thick
    },
    Table(c))

pgfsave("c1.pdf", plt; include_preamble = true, dpi = 150)
