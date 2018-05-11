require 'csv'


def al_to_hash (h)
  file = File.open('notas.csv', 'r')
  data = file.readlines
  file.close

  h = {}

  data.each do |al|
    arr = []
    i = 1

    # agregar las notas al arreglo
    until al.split(', ')[i] == nil
      arr.push(al.split(', ')[i].chomp)
      i += 1
    end

    # agrega el hash con el nombre del alumno y el arreglo de notas
    h[al.split(', ')[0]] = arr
  end

  return h
end

def obtiene_aprobados(alumnos, nota_min)
  al_menos_uno = false
  alumnos.each do |k, arr|
    prom = arr.inject(0){|sum, x| sum + x.to_f}
    prom /= arr.length
    if prom >= nota_min
      puts "El alumno #{k} está aprobado con un promedio de #{prom}"
      al_menos_uno = true
    end
  end
  puts "Ningún alumno ha aprobado" if al_menos_uno == false
end


def menu()
  puts "***************Programa prueba Ruby***************"
  puts "Ingrese una de las siguientes opciones"
  puts "1. Obtener los promedios de los alumnos en archivos"
  puts "2. Mostrar la cantidad de inasistencias totales"
  puts "3. Mostrar los nombres de los alumnos aprobados"
  puts "4. Salir"
  puts
  opc_usr = gets.chomp.to_s

  case opc_usr
  when "1" #Obtener los promedios de los alumnos en archivos

      alumnos = al_to_hash(alumnos)

      alumnos.each do |k, arr|
        prom = arr.inject(0){|sum, x| sum + x.to_f}
        prom /= arr.length
        file = File.open("#{k}", 'w')
        file.puts "El promedio de notas de #{k} es: #{prom}"
        file.close
      end

      puts
      puts "Archivos creados correctamente"
      puts
      menu()


    when "2" # Mostrar la cantidad de inasistencias totales

      alumnos = al_to_hash(alumnos)

      puts

      alumnos.each do |k, arr|
        if arr.count('A') > 0
          puts "El alumno #{k} tiene #{arr.count('A')} ausencias"
        else
          puts "El alumno #{k} no tiene ausencias"
        end
      end

      puts
      menu()

    when "3" # Mostrar los nombres de los alumnos aprobados

      alumnos = al_to_hash(alumnos)

      puts
      puts "Ingrese la nota necesaria para aprobar (opcional). Presione Enter para utilizar por defecto el valor 5"
      nota_apro = gets.chomp.to_s

      #puts "nulo" if nota_apro == ""

      if nota_apro == ''
        puts
        obtiene_aprobados(alumnos, 5)
      else
        if nota_apro.to_i > 0
          puts
          obtiene_aprobados(alumnos, nota_apro.to_i)
        else
          puts
          puts "El valor indicado no está permitido"
          puts
          #menu()
        end
      end

      puts
      menu()


    when "4" # Salir
      puts "Gracias por utilizar el programa. Vuelva pronto"

    else # opción errónea
      puts "La opción ingresada no existe. Por favor intente nuevamente"
      puts
      menu()

  end
end

menu()
