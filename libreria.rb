require 'terminal-table'

module Funciones
    def self.size(cp)
        tamano = 0
        a = cp.tope
        while a != nil
            tamano += 1
            a = a.siguiente
        end
        return tamano
    end

    def self.vacia?(cp)
        if cp.tope == nil
            return true
        else
            return false
        end
    end
    
    def self.limpiar
        system('clear')
    end
    
    def self.continuar
        puts ''
        puts 'Pulse enter para continuar'
        gets
        limpiar
    end

    def self.mostrar_paso(paso, pasoapaso, cp, table)
        n = 1
        if pasoapaso == true
            limpiar
            puts table
            print "\nIngrese '1' para salir o Presione enter para continuar: "
            n = gets.chomp.to_i
            limpiar
        end
        table.add_row [paso, "#{cp}"]
        return true if n != 1
    end

    def self.ordenamiento_cola(apartadooriginal, mostrar)
        apartado = *apartadooriginal
        rows = []
        table = Terminal::Table.new :rows => rows 
        table.title = "COLA - PASO A PASO"
        table.headings = ['Iteracion', 'Estructura']
        pasoapaso = mostrar
        paso = 0
        size = apartado.size - 1
        cola = Cola.new
        for x in 0..size
            if cola.tope == nil
                cola.insertar(apartado[x])
                pasoapaso = mostrar_paso(paso, pasoapaso, cola, table)
                paso += 1
            elsif apartado[x] < cola.fondo.valor
                colaauxiliar = Cola.new
                a = cola.tope
                while a != nil
                    if apartado[x] != nil && apartado[x] < a.valor
                        colaauxiliar.insertar(apartado[x])
                        apartado[x] = nil
                    end
                    colaauxiliar.insertar(a.valor)
                    a = a.siguiente
                    cola.eliminar
                    pasoapaso = mostrar_paso(paso, pasoapaso, cola, table)
                    paso += 1
                    if a == nil && apartado[x] != nil
                        colaauxiliar.insertar(apartado[x])
                    end
                end
                a = colaauxiliar.tope
                while a != nil
                    cola.insertar(a.valor)
                    pasoapaso = mostrar_paso(paso, pasoapaso, cola, table)
                    paso += 1
                    a = a.siguiente
                end
            else
                cola.insertar(apartado[x])
                pasoapaso = mostrar_paso(paso, pasoapaso, cola, table)
                paso += 1
            end
        end
        puts table if mostrar == true
        return {resultado: cola, pasos: paso}
    end
