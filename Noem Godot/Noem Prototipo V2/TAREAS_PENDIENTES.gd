#TAREAS PENDIENTES: Aca anoto todo lo que debería de hacer.

#Ultimo hecho:
#El Sistema integró el buffer.

#Por hacer:
#Agregar Derrapar como prueba de otro tipo de acciones.

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
