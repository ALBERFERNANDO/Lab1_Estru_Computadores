.data # Este segmento se utiliza para declarar e inicializar variables y datos
    mensaje1:   .asciiz "�Cuantos numeros desea comparar? elegir entre 3 y 5: "  	# Mensaje que pide la cantidad de numeros
    mensaje2:   .asciiz "Ingrese el n�mero: "                      			# Mensaje que muestra un n�mero
    mensaje3:   .asciiz "El n�mero menor es: "                      		        # Mensaje que muestra el n�mero menor
    nuevalinea: .asciiz "\n"                                      		        # Nueva l�nea para formato

.text
    main:
        # Imprimir mensaje1
        li $v0, 4          # Carga el c�digo a syscall para imprimir cadena
        la $a0, mensaje1   # Carga la direcci�n del mensaje en $a0
        syscall            # Llama a syscall
        
        # Leer la cantidad de numeros
        li $v0, 5          # Carga el c�digo de syscall para leer entero
        syscall            # Llama a syscall
        move $t0, $v0      # Move el valor le�do a $t0 (cantidad de numeros)
        
        # Inicializar min_num a un valor muy grande
        li $t1, 2147483647    # Carga el valor m�ximo de entero en $t1 (para min_num)
        
        # Bucle para leer numeros y encontrar el m�nimo
        li $t2, 0          # Inicializar el �ndice a 0
    leer_numeros:
        bge $t2, $t0, termina_leer_numeros  # Si el �ndice >= cantidad, salir del bucle
        
        # Imprimir mensaje2
        li $v0, 4          # Carga el c�digo a syscall para imprimir cadena
        la $a0, mensaje2       # Carga la direcci�n del mensaje en $a0
        syscall            # Llama a syscall
        
        # Leer el n�mero
        li $v0, 5          # Carga el c�digo a syscall para leer entero
        syscall            # Llama a syscall
        move $t3, $v0      # Mueve el n�mero le�do a $t3
        
        # Comparar con min_num
        blt $t3, $t1, actualizar_min   # Si el n�mero le�do < min_num, actualizar min_num
        j continua_bucle   # Continuar con el siguiente n�mero
        
    actualizar_min:
        move $t1, $t3      # Actualiza min_num con el n�mero le�do
        
    continua_bucle:
        addi $t2, $t2, 1   # Incrementa el �ndice
        j leer_numeros     # Vuelve al inicio del bucle
        
    termina_leer_numeros:
        # Imprimir mensaje3
        li $v0, 4          	# Carga el c�digo a syscall para imprimir cadena
        la $a0, mensaje3       	# Carga la direcci�n del mensaje en $a0
        syscall           	# Llama a syscall
        
        # Imprimir el valor de min_num
        li $v0, 1          # Carga el c�digo a syscall para imprimir entero
        move $a0, $t1      # Mueve el valor de min_num a $a0
        syscall            # Llama a syscall
        
        # Imprimir nueva l�nea
        li $v0, 4          	# Carga el c�digo a syscall para imprimir cadena
        la $a0, nuevalinea    	# Carga la direcci�n de la nueva l�nea en $a0
        syscall            	# Llama a syscall
        
        # Salir del programa
        li $v0, 10         # Carga el c�digo a syscall para salir
        syscall            # Llama a syscall
