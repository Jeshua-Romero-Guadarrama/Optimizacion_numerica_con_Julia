#!/usr/bin/env python
# coding: utf-8

# ```{contents}
# :depth: 4
# ```

# # Operaciones y funciones

# ## <font color=blue>Operaciones</font>
# 
# 
# ### <font color=blue>Operaciones con variables numéricas </font>                  
# 
# Operaciones entre variables numéricas como `+`,`-`,`*`,`/` 
# 
# exponenciación `^`, residuo `%`  
# 
# **Ejemplo:**
# 
# Fórmula cuadrática

# In[ ]:


a = 1; b = 5; c = 1/2
s = ( -b + √(b^2 - 4a*c) )/2a


# Nota que basta escribir 
# ```julia 
#    2variable``` 
# en vez de 
# ```julia 
#    2*variable```
# lo mismo para cualquier otra cifra   

# ### <font color=blue>Operaciones entre arreglos de números</font>
# 
# 
# Síntaxis para operaciones elemento a elemento
# 
# 
# - exponenciación  
# ```julia 
# arreglo1.^2```
# 
# - multiplicación  
# ```julia 
# arreglo1 .* arreglo2```
# 
# - división 
# ```julia 
# arreglo1 ./ arreglo2```
# 
# - residuo 
# 
# ```julia 
# arreglo1 .% arreglo2```
# 
# - `+` y `-`   no requieren `.`
# 
# **Ejemplo:**
# 
# Residuo elemento a elemento

# In[ ]:


divi = [101.1 253.3 π]
nume = [10 50 3]
divi .% nume


# Síntaxis para operaciones entre matrices
# 
# - Transpuesta conjugada
# ```julia 
#  arreglo2D'```
#  
# - Potencias de matrices
# ```julia 
#  arreglo2D^2``` 
# 
# - Producto de matrices
# 
#   NOTA: Los tamaños deben empatar
#   
# ```julia 
#  arreglo2D * arreglo2D
# 
#  arreglo2D * arreglo1D```
#  
# 

# **Ejemplo:**
# 
# Matriz de rango uno

# In[ ]:


u = collect(1:15)
v = collect(2:2:30)
C = u*v'


# Polinomio de matrices

# In[ ]:


C^3 + 2C^2 + 5C + 6 


# - Resuelve sistema de ecuaciones lineales
#  ```julia 
#  arreglo2D \ arreglo1D```
#  
# **Ejemplo:**  

# In[ ]:


A = randn(5,5)
b = ones(5)
x = A\b


# ### <font color=blue>Operaciones entre cadenas</font>
# concatenación
# 
# ```julia 
# cadena1 * cadena2 * cadena3```
# 
# repite y concatena
# 
# ```julia 
# cadena^2```

# ## <font color=blue>Funciones</font>
# 
# Son objetos que reciben una tupla de argumentos y devuelven un valor
# 
# 
# ###  <font color=blue>Algunas funciones matemáticas predefinidas</font>
# 
# trigonométricas como `sin`, `cos`, `tan`, `asin`,
# 
# exponencial `exp`, logarítmo `log`, 
# 
# raíz cuadrada `sqrt` , valor absoluto `abs`,
#  
# piso `floor`, techo `ceil` y muchas más
# 
# ###  <font color=blue>Algunas funciones para arreglos</font>

# In[ ]:


sum([1,3,4,5])


# In[ ]:


prod([-1,4,-5,-20])


# In[ ]:


minimum([-5,-20,0,10])


# In[ ]:


maximum([-5,-20,0,10])


# ###  <font color=blue>Define tus propias funciones</font>
# 
# Sintaxis para funciones especificadas por fórmula
# 
# ```julia 
# nombre_función(variable1) = fórmula en variable1 
# ```
# 
# **Ejemplo:**

# In[ ]:


f₁(x) = x^2 +1 
println(f₁(10))
println(f₁(100))
println(f₁(1000))


# Puede usar otras variables en la función además de la variable principal
# 
# **Ejemplo:**

# In[ ]:


c₁ = 2; c₂ = 10
f₂(x) = x^c₁ + c₂
f₂(5.5)


# Si cambia el valor de una variable en la función,
# 
# también cambia el resultado que regresa

# In[ ]:


c₂ = 20
f₂(5.5)


# Trata de aplicar la  función `f₂` al  arreglo [-1,0,1]

# Sintaxis para **evaluar** funciones que reciben tuplas y arreglos
# 
# ```julia 
# map(función,variables)
# ```
# Evalua las variables elemento a elemento con base a la función 
# 
# **Ejemplos:**

# In[ ]:


f₃ = x -> (x > 1e-3)


# In[ ]:


map(f₃, 1:10)


# Rutinas como `map` reciben como argumento una función
# 
# En ese caso podemos usar funciones anónimas con la sintaxis
# 
# ```julia
# variable1 -> fórmula en variable1
# ```
# 
# que podemos usar como
# 
# ```julia 
#  rutina(variable1 -> fórmula en variable1, otros argumentos) 
# ```
# **Ejemplo:**
# 
# Evalua una tupla de números 
# 
# por cada elemento usa la aplicación
# 
# $$ x \mapsto 
# \begin{cases}
#  \sqrt x + 1, & \text{si } x >0; \\
#  x +1, & \text{en otro caso}
# \end{cases} $$

# In[ ]:


map(x -> (x > 0) ? √x + 1 : x + 1, (-5,0,π)) 


# ### <font color=blue>Broadcasting</font>
# 
# Extiende las funciones para que reciban tuplas o arreglos usando la sintaxis
# 
# ```julia 
# función.(variables)
# ```
# 
# De esa manera la función evalua elemento a elemento
# 
# **Ejemplo:**
# 
# Evalua los elementos del arreglo
# 
# ```julia
# a = [-5  -1//2  2.5  1e4]
# ```
# usando la aplicación $x \mapsto \sqrt|x| +1$ 

# In[ ]:


a = [-5  -1//2  2.5  1e4]


# In[ ]:


f = x -> sqrt(abs(x)) +1


# In[ ]:


f.(a)


# Sintaxis más general para funciones
# 
# ```julia 
#  function nombre(variable1::Tipo,variable2::Tipo)
# 
#  return variable_salida
# end
# ```
# 
# - Si el tipo de variable no se especifica, Julia tratara de inferirlo.
# 
# **Ejemplo**
# 
# Una función sencilla puede dar lugar a diferentes operaciones con base al tipo de argumentos

# In[ ]:


function p(A,n)
    pA = A^n
   return pA 
end


# In[ ]:


p.(fill(2.0,3,3),3)


# In[ ]:


p(fill(2.0,3,3),3)


# raíz cuadrada de una matriz 

# In[ ]:


p(fill(2.0,3,3),1/2)


# concatenación elemento a elemento de arreglos de cadenas 

# In[ ]:


p.(rand(["a","b","c","d"],2,2),3)


# In[ ]:





# ###  <font color=blue>Conversiones</font>

# In[ ]:


Float64(101//5) # Racional ⟶ Flotante de 64 bits 


# In[ ]:


println(typeof(π))
Float32(π) # Irracional ⟶ Flotante de 32 bits


# In[ ]:


println(typeof(1024.5))
Rational(1024.5) # Flotante ⟶ Racional


# In[ ]:


x = 1501.123; 
string(x) # Flotante ⟶ Cadena


# In[ ]:


Int64(floor(-1.55)) # Flotante ⟶ Entero (truncado)


# Para tuplas y arreglos usa `Float64.`, `Float32.`, `Rational.`, `Int64.`, `string.`
