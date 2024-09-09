.data # Este segmento se utiliza para declarar e inicializar variables y datos
    mensaje1:   .asciiz "¿Cuantos numeros desea comparar? elegir entre 3 y 5: "  	# Mensaje que pide la cantidad de numeros
    mensaje2:   .asciiz "Ingrese el número: "                      			# Mensaje que muestra un número
    mensaje3:   .asciiz "El número menor es: "                      		        # Mensaje que muestra el número menor
    nuevalinea: .asciiz "\n"                                      		        # Nueva línea para formato

.text
    main:
        # Imprimir mensaje1
        li $v0, 4          # Carga el código a syscall para imprimir cadena
        la $a0, mensaje1   # Carga la dirección del mensaje en $a0
        syscall            # Llama a syscall
        
        # Leer la cantidad de numeros
        li $v0, 5          # Carga el código de syscall para leer entero
        syscall            # Llama a syscall
        move $t0, $v0      # Move el valor leído a $t0 (cantidad de numeros)
        
        # Inicializar min_num a un valor muy grande
        li $t1, 2147483647    # Carga el valor máximo de entero en $t1 (para min_num)
        
        # Bucle para leer numeros y encontrar el mínimo
        li $t2, 0          # Inicializar el índice a 0
    leer_numeros:
        bge $t2, $t0, termina_leer_numeros  # Si el índice >= cantidad, salir del bucle
        
        # Imprimir mensaje2
        li $v0, 4          # Carga el código a syscall para imprimir cadena
        la $a0, mensaje2       # Carga la dirección del mensaje en $a0
        syscall            # Llama a syscall
        
        # Leer el número
        li $v0, 5          # Carga el código a syscall para leer entero
        syscall            # Llama a syscall
        move $t3, $v0      # Mueve el número leído a $t3
        
        # Comparar con min_num
        blt $t3, $t1, actualizar_min   # Si el número leído < min_num, actualizar min_num
        j continua_bucle   # Continuar con el siguiente número
        
    actualizar_min:
        move $t1, $t3      # Actualiza min_num con el número leído
        
    continua_bucle:
        addi $t2, $t2, 1   # Incrementa el índice
        j leer_numeros     # Vuelve al inicio del bucle
        
    termina_leer_numeros:
        # Imprimir mensaje3
        li $v0, 4          	# Carga el código a syscall para imprimir cadena
        la $a0, mensaje3       	# Carga la dirección del mensaje en $a0
        syscall           	# Llama a syscall
        
        # Imprimir el valor de min_num
        li $v0, 1          # Carga el código a syscall para imprimir entero
        move $a0, $t1      # Mueve el valor de min_num a $a0
        syscall            # Llama a syscall
        
        # Imprimir nueva línea
        li $v0, 4          	# Carga el código a syscall para imprimir cadena
        la $a0, nuevalinea    	# Carga la dirección de la nueva línea en $a0
        syscall            	# Llama a syscall
        
        # Salir del programa
        li $v0, 10         # Carga el código a syscall para salir
        syscall            # Llama a syscall
