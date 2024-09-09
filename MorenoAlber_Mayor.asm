.data # Este segmento se utiliza para declarar e inicializar variables y datos
    mensaje1:   .asciiz "¿Cuantos numeros desea comparar? elegir entre 3 y 5: "  	# Mensaje que pide la cantidad de números
    mensaje2:   .asciiz "Ingrese el número: "                      			# Mensaje que muestra el número
    mensaje3:   .asciiz "El número mayor es: "                     			# Mensaje que muestra el número mayor
    nuevalinea: .asciiz "\n"                                      			# Nueva línea para formato

.text
    main:
        # Imprimir mensaje1
        li $v0, 4          # Carga el código a syscall para imprimir cadena
        la $a0, mensaje1   # Carga la dirección del mensaje en $a0
        syscall            # Llama a syscall
        
        # Leer la cantidad de números
        li $v0, 5          # Carga el código a syscall para leer entero
        syscall            # Llama a syscall
        move $t0, $v0      # Mueve el valor leído a $t0 (cantidad de números)
        
        # Inicializar max_num a un valor muy pequeño
        li $t1, -2147483648    # Carga el valor mínimo de entero en $t1 (para max_num)
        
        # Bucle para leer números y encontrar el máximo
        li $t2, 0          # Inicializar el índice a 0
    leer_numeros:
        bge $t2, $t0, termina_leer_numeros  # Si el índice >= cantidad, salir del bucle
        
        # Imprimir mensaje2
        li $v0, 4          	# Carga el código a syscall para imprimir cadena
        la $a0, mensaje2      	 # Carga la dirección del mensaje en $a0
        syscall            	# Llama a syscall
        
        # Leer el número
        li $v0, 5          # Carga el código a syscall para leer entero
        syscall            # Llama a syscall
        move $t3, $v0      # Mueve el número leído a $t3
        
        # Comparar con max_num
        bgt $t3, $t1, actualizar_max   # Si el número leído > max_num, actualizar max_num
        j continua_bucle   # Continua con el siguiente número
        
    actualizar_max:
        move $t1, $t3      # Actualiza max_num con el número leído
        
    continua_bucle:
        addi $t2, $t2, 1   # Incrementa el índice
        j leer_numeros     # Vuelve al inicio del bucle
        
    termina_leer_numeros:
        # Imprimir mensaje3
        li $v0, 4          	# Carga el código a syscall para imprimir cadena
        la $a0, mensaje3       	# Carga a la dirección del mensaje en $a0
        syscall            	# Llama a syscall
        
        # Imprimir el valor de max_num
        li $v0, 1          # Carga el código a syscall para imprimir entero
        move $a0, $t1      # Mueve el valor de max_num a $a0
        syscall            # Llama a syscall
        
        # Imprimir nueva línea
        li $v0, 4         	 # Carga el código a syscall para imprimir cadena
        la $a0, nuevalinea    	# Carga la dirección de la nueva línea en $a0
        syscall            	# Llama a syscall
        
        # Salir del programa
        li $v0, 10         # Carga el código a syscall para salir
        syscall            # Llama a syscall
