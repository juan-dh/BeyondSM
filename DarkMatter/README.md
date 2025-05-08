# Dark Matter Scalar Field

Campo escalar añadido al Lagrangiano del modelo estandard.

## Creación de un campo escalar

En `DarkMatter.fr` definimos el campo escalar y sus parametros

En `main.wls` o `main.nb` cargamos el nuevo campo escalar definido en `DarkMatter.fr` y escribimos el nuevo Lagrangiano. A este le sumamos el Lagrangiano del Modelo Estandar y finalmente que podemos cargar a FeynRules desde los archivos de `/SM` También generamos las reglas de Feynman para los nuevos terminos. Finalmente exportamos el modelo en formato UFO en la carpeta `DarkMatter_UFO`.

## MadGraph

Creación de eventos a nivel partonico, en este caso nos interesan algunos canales que potencialmente nos permitirá detectar la partícula de materia oscura. Los canales usados son:
````
p p > h > sc sc
p p > Z h, Z > e+ e-, h > sc sc
p p > Z h, Z > mu+ mu-, h > sc sc
p p > h j, h > sc sc
`````

Estos dos pasos de crear el nuevo modelo y simular eventos a nivel partonico son encapsulados en `initializer.sh` que ejecuta `main.wls` y `madgraphsim.mg5`.