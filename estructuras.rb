require 'terminal-table'
require_relative 'libreria'
@apartado = []

def ingreso_de_numeros
    puts 'Inserte a continuacion su listado de numeros separado por comas: '
    @apartado = gets.chomp.split(',').map{|n|n.to_i}
    size = @apartado.size - 1
    Funciones.limpiar
    puts "\nEl listado ha sido guardado exitosamente"
    Funciones.continuar
end

def ejecutar_ordenamiento
    if @apartado == []
        puts 'Aun no ha ingresado ninguna lista de valores'
        puts @apartado
        Funciones.continuar
        return
    end
    rows = []
    puts "ORDENAR TODOS LOS DATOS\n\nElementos a ordenar: #{@apartado}"
    pila = Funciones.ordenamiento_pila(@apartado, false)
    cola = Funciones.ordenamiento_cola(@apartado, false)
    lista = Funciones.ordenamiento_lista(@apartado, false)
    rows << ['Pila', pila[:pasos], 0.00, pila[:resultado]]
    rows << ['Cola', cola[:pasos], 0.00, cola[:resultado]]
    rows << ['Lista', lista[:pasos], 0.00, lista[:resultado]]
    mayor = rows [0][1]
    for x in 0..2
        if rows[x][1] > mayor
            mayor = rows[x][1].to_f
        end
    end
    puts mayor
    for x in 0..2
        rows[x][2] = (mayor / rows[x][1]) * 100.00
    end
    table = Terminal::Table.new :rows => rows
    table.headings = ['Estructura de datos', 'Pasos', 'Rendimiento', 'Resultado']
    puts table
    Funciones.continuar
end

def ordenar_paso_a_paso
    if @apartado == []
        puts 'Aun no ha ingresado ninguna lista de valores'
        puts @apartado
        Funciones.continuar
        return
    end
    puts '¿Que estructura desea ver?'
    puts '1. Cola'
    puts '2. Pila'
    puts '3. Lista'
    print "\nIngrese una opcion: "
    n = gets.chomp.to_i
    if n == 1
        Funciones.ordenamiento_cola(@apartado, true)
        Funciones.continuar
    elsif n == 2 
        Funciones.ordenamiento_pila(@apartado, true)
        Funciones.continuar
    elsif n == 3
        Funciones.ordenamiento_lista(@apartado, true)
        Funciones.continuar
    else
        while n != 1 && n != 2 && n != 3
            print 'Opcion invalida, ingrese de nuevo: '
            n = gets.chomp.to_i
        end
    end
end

begin
    Funciones.limpiar
    puts 'BIENVENIDO AL PROGRAMA DE ESTRUCTURAS CONTRA ESTRUCTURAS'
    puts '1. Ingreso de numeros'
    puts '2. Ejecutar ordenamiento'
    puts '3. Ordenar paso a paso'
    puts '4. Salir'
    print "\nElija una opcion: "
    n = gets.chomp.to_i
    puts ''

    if n == 1
        Funciones.limpiar
        ingreso_de_numeros
    elsif n == 2
        Funciones.limpiar
        ejecutar_ordenamiento
    elsif n == 3
        Funciones.limpiar
        ordenar_paso_a_paso
    elsif n == 4
        puts 'Que tenga un buen dia :)'
        Funciones.continuar
    else
        puts 'Opcion invalida'
        Funciones.continuar
    end
end while n !=4
