.data # Este segmento se utiliza para declarar e inicializar variables y datos

    mensaje1:   .asciiz "Cuantos n�meros de la serie Fibonacci desea generar: "  	# Mensaje que pide la cantidad de numeros de la serie de Fibonacci
    mensaje2:   .asciiz "La serie Fibonacci es: "                               	# Mensaje que muestra la serie de Fibonacci
    mensaje3:   .asciiz "La suma de la serie es: "                               	# Mensaje que muestra la suma de la serie de Fibonacci
    nuevalinea: .asciiz "\n"                                                   		# Define una cadena que contiene solo el car�cter de nueva l�nea

.text # Este segmento se utiliza para escribir el c�digo del programa
    main: 
     # Imprimir mensaje mensaje1
        li $v0, 4         	# Carga el c�digo de syscall para imprimir cadena
        la $a0, mensaje1     	# Carga la direcci�n del mensaje en $a0
        syscall            	# Llamar a syscall
        
        # Leer la cantidad de n�meros de la serie
        li $v0, 5          # Carga el c�digo syscall para leer el n�mero entero
        syscall            # Llama a syscall
        move $t0, $v0      # Mueve el valor le�do a $t0 (que es la cantidad de n�meros)
        
        # Inicializar los primeros dos n�meros de Fibonacci
        li $t1, 0          # $t1 = fib0 (0)
        li $t2, 1          # $t2 = fib1 (1)
        li $t3, 1          # $t3 = suma (inicialmente 1, con el primer n�mero 1)
        li $t4, 2          # $t4 = �ndice (empieza en 2 porque ya tenemos los primeros dos n�meros)
        
        # Imprimir la serie de Fibonacci
        li $v0, 4          	# Carga el c�digo de syscall para imprimir cadena
        la $a0, mensaje2        # Carga la direcci�n del mensaje en $a0
        syscall            	# Llama a syscall
        
        # Imprimir los primeros dos n�meros (0 y 1)
        li $v0, 1          # Carga el c�digo syscall para imprimir entero
        li $a0, 0          # Imprimir 0
        syscall            # Llama a syscall
        li $v0, 1          # Carga el c�digo de syscall para imprimir entero
        li $a0, 1          # Imprimir 1
        syscall            # Llama a syscall
        
    bucle_fibonacci:	# Etiqueta que marca el inicio del bucle
    
        bge $t4, $t0, fibonacci_realizado  # Si el �ndice es >= a cantidad, sale del bucle
        
        # Calcular el siguiente n�mero de Fibonacci
        add $t5, $t1, $t2      # $t5 = siguiente_fib (fib0 + fib1)
        move $t1, $t2          # Actualiza fib0 a valor anterior fib1
        move $t2, $t5          # Actualiza fib1 a siguiente_fib
        add $t3, $t3, $t5      # Actualiza la suma
        
        # Imprimir el n�mero de Fibonacci
        li $v0, 1              # Carga el c�digo de syscall para imprimir entero
        move $a0, $t5          # Mueve el siguiente n�mero a $a0
        syscall                # Llama a syscall
        
        addi $t4, $t4, 1        # Incrementa el �ndice
        j bucle_fibonacci       # Vuelve al inicio del bucle
        
    fibonacci_realizado:	# Etiqueta que marca el final del c�lculo de Fibonacci
    
        # Imprimir nueva l�nea
        li $v0, 4          	# Carga el c�digo a syscall para imprimir cadena
        la $a0, nuevalinea    	# Carga la direcci�n de la nueva l�nea en $a0
        syscall            	# Llama a syscall
        
        # Imprimir mensaje
        li $v0, 4              # Carga el c�digo a syscall para imprimir cadena
        la $a0, mensaje3       # Carga la direcci�n del mensaje en $a0
        syscall                # Llama a syscall
        
        # Imprimir la suma de la serie
        li $v0, 1          # Carga el c�digo a syscall para imprimir entero
        move $a0, $t3      # Mueve la suma a $a0
        syscall            # Llama a syscall
        
        # Imprimir nueva l�nea
        li $v0, 4          	# Carga el c�digo a syscall para imprimir cadena
        la $a0, nuevalinea   	# Carga la direcci�n de la nueva l�nea en $a0
        syscall           	# Llama a syscall
        
        # Salir del programa
        li $v0, 10         # Carga el c�digo a syscall para salir
        syscall            # Llama a syscall

