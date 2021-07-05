x_0=0;
x_inf=1;
N=100;

h=(x_inf-x_0)/N;
y=zeros(N+1,1);
y[1]=1.0;
λ=1.0;
x=LinRange(x_0,x_inf,N+1);

for n=2:N+1
  y[n]=y[n-1]+y[n-1]*h*λ;
  end

using PyPlot

plot(x,y);

function Eul(h)

    N=floor(Int, 1/h);
    y=zeros(N+1,1);
    y[1]=1.0;
    λ=1.0;

    x_0=0;
    x_inf=h*N+x_0;
    
    x=LinRange(x_0,x_inf,N+1);

    for n=2:N+1
        y[n]=y[n-1]+y[n-1]*h*λ;
      end
    
    return x, y
end


plot([0,1],[exp(1),exp(1)])
    xlabel("t")
    ylabel("y")
    title(L"Soluciones de $y'=y; \ \ y(0)=1; \ \ t \in [0,1]$ para diferentes valores de $h$ ")

for i in 2:5:1000
    x,y=Eul(1/i);
   
    if i in [2 12 22 992]
    plot(x,y,label="h = $(round(1/i; digits=3))")
        legend()
        else plot(x,y)
    end
  
end  

x_0=0;
x_inf=1;
N=100;

h=(x_inf-x_0)/N;
y=zeros(N+1,1);
y[1]=1.0;
λ=1.0;
x=LinRange(x_0,x_inf,N+1);

for n=2:N+1
    y[n]=((2+h*λ)/(2-h*λ))*y[n-1];
  end

plot(x,y);

function Trap(h)

    N=floor(Int, 1/h);
    y=zeros(N+1,1);
    y[1]=1.0;
    λ=1.0;

    x_0=0;
    x_inf=h*N+x_0;
    
    x=LinRange(x_0,x_inf,N+1);

    for n=2:N+1
        y[n]=((2+h*λ)/(2-h*λ))*y[n-1];
      end
    
    return x, y
end


plot([0,1],[exp(1),exp(1)])
    xlabel("t")
    ylabel("y")
    title(L"Soluciones de $y'=y; \ \ y(0)=1; \ \ t \in [0,1]$ para diferentes valores de $h$ ")

for i in 2:5:1000
    x,y=Trap(1/i);
   
    if i in [2 12 22 992]
    plot(x,y,label="h = $(round(1/i; digits=3))")
        legend()
        else plot(x,y)
    end
  
end  

function Eulf(N)
    h=1/N;
    y=1.0;
    λ=1.0;
    for n=1:N
        y=(1.0+h*λ)*y;
    end
  return y
end

function Trapf(N)
    h=1/N;
    y=1.0;
    λ=1.0;
        for n=1:N
            y=((2.0+h*λ)/(2.0-h*λ))*y;
          end
    return y
end

errT=[];
errE=[];
h=[];
for i in floor.(Int, exp10.(range(1, 10, length=19)) )
y1=Trapf(i);
y2=Eulf(i);
    h=append!(h,1/i);
    errT=append!(errT, abs(exp(1)-y1));
    errE=append!(errE, abs(exp(1)-y2));
    end    
  using PyPlot
loglog(h,errT, basex=10,label="Trapezoide",":s" );
loglog(h,errE, basex=10,label="Euler",":s");
legend()   ;
grid(1);
    xlabel("h");
    ylabel("Eror Relativo");
title(L"Comparación de soluciones en $x=1$");

errT=[];
errE=[];
h=[];
for i in floor.(Int, exp10.(range(1, 11, length=100)))
y1=Trapf(i);
y2=Eulf(i);
    h=append!(h,1/i);
    errT=append!(errT, abs(exp(1)-y1));
    errE=append!(errE, abs(exp(1)-y2));
    end    
  using PyPlot
loglog(h,errT, basex=10,label="Trapezoide","" );
loglog(h,errE, basex=10,label="Euler","");
legend()   ;
grid(1)
    xlabel("h");
    ylabel("Eror Relativo");
title(L"Comparación de soluciones en $x=1$");
loglog(h,errT, basex=10,"k." );
loglog(h,errT, basex=10,label="Trapezoide","" );

loglog(h,errE, basex=10,"k." );
loglog(h,errE, basex=10,label="Euler");

xlabel("h");
ylabel("Eror Relativo");
title(L"Comparación de soluciones en $x=1$");
legend()   
grid(1)




