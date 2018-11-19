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

    def self.ordenamiento_pila(apartado, mostrar)
        rows = []
        table = Terminal::Table.new :rows => rows 
        table.title = "PILA - PASO A PASO"
        table.headings = ['Iteracion', 'Estructura']
        pasoapaso = mostrar
        paso = 0
        size = apartado.size - 1
        pila = Pila.new
        for x in 0..size
            if pila.tope == nil
                pila.insertar(apartado[x])
                pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                paso += 1
            elsif apartado[x] < pila.tope.valor
                pilaauxiliar = Pila.new
                a = pila.tope
                while a != nil
                    if a.valor < apartado[x]
                        pila.insertar(apartado[x])
                        pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                        paso += 1
                        break
                    end
                    pilaauxiliar.insertar(a.valor)
                    a = a.siguiente
                    pila.eliminar
                    pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                    paso += 1
                    if a == nil
                        pila.insertar(apartado[x])
                        pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                        paso += 1
                    end
                end
                a = pilaauxiliar.tope
                while a != nil
                    pila.insertar(a.valor)
                    pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                    paso += 1
                    a = a.siguiente
                end
            else
                pila.insertar(apartado[x])
                pasoapaso = mostrar_paso(paso, pasoapaso, pila, table)
                paso += 1
            end
        end
        puts table if mostrar == true
        return {resultado: pila, pasos: paso}
    end

    def self.ordenamiento_lista(apartado, mostrar)
        rows = []
        table = Terminal::Table.new :rows => rows
        table.title = "LISTA - PASO A PASO"
        table.headings = ['Iteracion', 'Estructura']
        pasoapaso = mostrar
        paso = 0
        size = apartado.size - 1
        lista = Lista.new
        for x in 0..size
            if lista.tope == nil
                lista.insertar(apartado[x])
                pasoapaso = mostrar_paso(paso, pasoapaso, lista, table)
                paso += 1
            else
                a = lista.tope
                while a != nil
                    if a.siguiente == nil 
                        if a.valor < apartado[x]
                            lista.insertar_despues(apartado[x], a.valor)
                            pasoapaso = mostrar_paso(paso, pasoapaso, lista, table)
                            paso += 1
                            break 
                        else
                            lista.insertar_antes(apartado[x], a.valor)
                            pasoapaso = mostrar_paso(paso, pasoapaso, lista, table)
                            paso += 1
                            break 
                        end
                    elsif a.valor <= apartado[x] && a.siguiente.valor >= apartado[x]
                        lista.insertar_despues(apartado[x], a.valor)
                        pasoapaso = mostrar_paso(paso, pasoapaso, lista, table)
                        paso += 1
                        break
                    elsif a.valor >= apartado[x]
                        lista.insertar_antes(apartado[x], a.valor)
                        pasoapaso = mostrar_paso(paso, pasoapaso, lista, table)
                        paso += 1
                        break
                    else
                        a = a.siguiente
                    end
                end
            end
        end
        puts table if mostrar == true
        return {resultado: lista, pasos: paso}
    end
end

class Elemento
    attr_accessor :valor, :siguiente
    def initialize(valor)
        @valor = valor
        @siguiente = nil
    end
end

class Pila
    attr_accessor :tope
    def initialize
        @tope = nil
    end

    def insertar(valor)
        elemento = Elemento.new(valor)
        elemento.siguiente = @tope
        @tope = elemento
    end

    def eliminar
        @tope = @tope.siguiente
    end

    def to_s
        cadena = ''
        a = @tope
        while a != nil
            if a.siguiente != nil
                cadena += "#{a.valor} => "
            else
                cadena += "#{a.valor}"
            end
            a = a.siguiente
        end
        return cadena
    end
end

class Cola
    attr_accessor :tope, :fondo
    def initialize
        @tope = nil
        @fondo = nil
    end

    def insertar(valor)
        elemento = Elemento.new(valor)
        a = @tope
        begin
            if a == nil
                @tope = elemento
                @fondo = elemento
                break
            elsif a.siguiente == nil
                a.siguiente = elemento
                @fondo = elemento
                break
            else
                a = a.siguiente
            end
        end while a != nil
    end

    def eliminar
        @tope = @tope.siguiente
    end

    def to_s
        cadena = ''
        a = @tope
        while a != nil
            if a.siguiente != nil
                cadena += "#{a.valor} => "
            else
                cadena += "#{a.valor}"
            end
            a = a.siguiente
        end
        return cadena
    end
end

class Lista
    attr_accessor :tope, :fondo
    def initialize
        @tope = nil
        @fondo = nil
    end

    def insertar(valor)
        elemento = Elemento.new(valor)
        @fondo = elemento
        @tope = elemento
    end

    def insertar_despues(valor, referencia)
        elemento = Elemento.new(valor)
        a = @tope
        while a != nil
            if a.valor == referencia
                elemento.siguiente = a.siguiente
                a.siguiente = elemento
                @fondo = elemento if elemento.siguiente == nil
                break
            end
            a = a.siguiente
        end
    end

    def insertar_antes(valor, referencia)
        elemento = Elemento.new(valor)
        a = @tope
        while a != nil
            if a.valor == referencia
                insertar_despues(a.valor, a.valor)
                a.valor = valor
                break
            end
            a = a.siguiente
        end
    end

    def to_s
        cadena = ''
        a = @tope
        while a != nil
            if a.siguiente != nil
                cadena += "#{a.valor} => "
            else
                cadena += "#{a.valor}"
            end
            a = a.siguiente
        end
        return cadena
    end
end
