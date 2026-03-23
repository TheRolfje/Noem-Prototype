#TAREAS PENDIENTES: Aca anoto todo lo que debería de hacer.

#Empezar a programar Cualidades y Estados Reales para el sistema.

#Empecé a crear los emisores de estados para probar. Fuerzan a la Entidad que los toque a cambiar uno
#de sus estados activos, a menos que ya esten en dicho estado, aunque creo que eso lo valida por
#si misma la entidad; eso también habría que verlo. 

#Además de eso ya cree el nodo de entradas de teclado, así que solo tengo que programar que hace
#cada una. En teoría después ya puedo programar Cualidades. Recordar que es el sistema de Cualidades
#el que valida si una Cualidad se puede usar o no, así que en el nodo de Entradas de Teclado o en
#el futuro Nodo de Control, no debería tener que preocuparme por eso, solo programar las Cualidades
#para que estas impidan cambiar a una Cualidad Bloqueada, ya sea por el estado activo o por la cualidad
#activa.

#IMPORTANTE: ARREGLAR DEPENDIENCIAS DE ENTITY EN LAS SUBCUALIDAD. ESTA INTENTANDO EXTRAER ENTITY
#SIN QUE LA QUALITIES MANAGER ESTE CARGADA AÚN. Primero se carga el ready de la sub cualidad, después el
#de la Cualidad y por último el del Qualitis Manager, yo necesito que la SubCualidad tenga a la Entidad antes.
