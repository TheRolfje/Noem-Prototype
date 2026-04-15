#TAREAS PENDIENTES: Aca anoto todo lo que debería de hacer.

#Ultimo hecho:
#Sistema de activacion de Cualidades de Ejecución Continua y de One Shot terminada.
#Ahora ya no existen más las acciones de One Shot puro. 

#Por hacer:
#Agregar el concepto de One Shot de nuevo, pero distinto: Marcar una tilde de One Shot indica a la
#action of subquality que solo se ejecute una vez y ya. Sirve para Cualidades que no tienen ninguna acción
#continua más que solo ejecutar una animación, como la cualidad de transition_of_direction.
#Ahora, si la Cualidad es One Shot, pero requiere uso continuo, no se marca esta casilla.

#Agregar un método que inicie animaciones y chequee si ya se iniciaron para no volverlas a iniciar.

#Corregir todo el tema de Data y Crear clase Entity.

#Buscar una forma de que la Entidad o el entorno validen que la Entidad ya está en un estado activo
#y que no intente cambiar a ese mismo estado, pero tampoco que en cada fotograma intente hacer esa
#validación con un if o algo. Ideal: No se procesa nada (o lo minomo) hasta que llega una señal de
#estado diferente al activo. Quizas usar activadores de estado en lugar de un rastreo constante.
#Podría traer bugs de que la Entidad esté en un estado lógico, cuando en el juego debería estar en otro,
#o que el jugador pueda usar un activador de estado no pensado para esa parte del juego.

#Como las Cualidades Chequean los estados y Cualidades permitidos de forma PERSONALIZABLE:
#Existe un nodo en cada entidad que guarda una lista o diccionario con los nombres de cada
#Cualidad que tenga la lista de Negados Personalizada. Cuando el Manager de Cualidades está en modo
#de verificar condiciones para activar una Cualidad, entra a ese nodo a chequear la información de la
#cualidad a la que se quiere cambiar. Si no tiene nada escrito, o directamente no encuentra el nombre de
#la Cualidad en ese nodo, asume que no tiene ningún bloqueo y se cambia. Si la encuentra, verifica que
#los nombres de los estados/cualidades activos no sean los que la nueva Cualidad tiene bloqueados.
#En base a esto determina si cambiar o no de Cualidad Activa. 

#Posible problema con estados activos: Si Noem está "Tranquilo" y algo lo atacase de golpe, no reaccionaría
#como se espera, o al menos tengo el miedo de eso. El punto: Intentar que el juego no mezcle "atmosferas de
#juego". Si estás tranquilo, estás tranquilo, si entras en una zona donde algo podría llegar a atacarte,
#Noem se pone tenso. Esto no es un juego de mundo abierto donde cualquier cosa puede pasar, JAMAS debería
#darse una situación en donde Noem y Malba esten totalmente tranquilos y de la nada algo los ataca, al menos
#no en "tiempo de juego", si hay una escena de por medio está bien. 

#Crear una Documentación real que Godot pueda mostrar externamente.
