# IIC2413 - Base de Datos 2026-2

## Tabla de contenidos

- [IIC2413 - Base de Datos 2026-2](#iic2413---base-de-datos-2026-2)
  - [Tabla de contenidos](#tabla-de-contenidos)
  - [Equipo](#equipo)
    - [Profesores](#profesores)
    - [Cuerpo de ayudantes](#cuerpo-de-ayudantes)
      - [Coordinadores](#coordinadores)
      - [Ayudantes](#ayudantes)
    - [Bibliografía](#bibliografía)
  - [Calendario Evaluaciones](#calendario-evaluaciones)
    - [Cátedra](#cátedra)
    - [Ayudantías (tentativo)](#ayudantías-tentativo)
  - [Evaluación](#evaluación)
    - [Aprobación del curso](#aprobación-del-curso)
  - [Uso de IA](#uso-de-ia)
  - [Política de integridad académica](#política-de-integridad-académica)
  - [Compromiso del Código de Honor](#compromiso-del-código-de-honor)

---

## Equipo

### Profesores

Nombre              | Sección | Email
------------------- | ------- | ---------------------
Eduardo Bustos      | 1       | [eb@uc.cl]
Christian Alvarez   | 2       | [cal@uc.cl]

### Cuerpo de ayudantes

#### Coordinadores

Nombre           | Rol                 | Email
---------------- |-------------------- | ----------------
Giuliana Tirachini  | Coordinadora Cátedra             | [giuliana.tirachini@uc.cl]
Gabriel Segovia | Coordinador Proyecto                  | [gesegovia@uc.cl]
Por Definir  | Bienestar Sección 1 | [na@uc.cl]
Por Definir | Bienestar Sección 2 | [na@uc.cl]

#### Ayudantes
Nombre           | Rol | Email
---------------- | ------------ | ----------------



[eb@uc.cl]:mailto:eb@uc.cl
[cal@uc.cl]:mailto:cal@uc.cl

[giuliana.tirachini@uc.cl]:mailto:giuliana.tirachini@uc.cl
[gesegovia@uc.cl]:mailto:gesegovia@uc.cl



---


### Bibliografía 
- Apuntes de clases y ayudantías.
- Recursos de Internet entregados en clase y ayudantía.
- Material complementario disponible en [https://github.com/IIC2413/Syllabus-2026-2-s1-2](https://github.com/IIC2413/Syllabus-2026-2-s1-2).
- Database Management Systems, 3rd edition, de Raghu Ramakrishnan y Johannes Gehrke, disponible en [Bibliotecas UC](https://bmdigitales-bibliotecas-uc-cl.pucdechile.idm.oclc.org/html5/DATABASE%20MANAGEMENT%20SYSTEMS/).

---

## Calendario Evaluaciones

### Cátedra

Fecha                  | Hora | Evaluación
-----------------------| ------- | ------------
**26 - 09 - 2026** |  09:00   | I1
**18 - 11 - 2026** |  17:30   | I2
**04 - 12 - 2026** |  17:30  | Examen


### Ayudantías (tentativo)
Fecha                  | # Ayudantía | Tema
-----------------------|------------|------


---

## Evaluación

### Aprobación del curso

El promedio $\bar{C}$ de las evaluaciones de cátedra (I1, I2, Examen) se calcula según

$\bar{C} = \frac{I1 + I2 + 1,5 \cdot Examen}{3,5}$

La Nota del proyecto tiene 3 componentes: 

a) Puntaje total de las evaluaciones que consiste en la suma de todos los puntajes parciales de las etapa menos los eventuales descuentos.   

Cada etapa tiene un puntaje asociado, siendo el total del proyecto 100 puntos. El puntaje máximo de
cada etapa es el siguiente: E1 = 30pts, E2 = 30pts, E3 = 40pts. El puntaje final del proyecto es:

$PT = \sum_{i=1}^{3} E_i$

b) El valor de $f$ corresponde al factor de asistencia a ayudantías, que se calcula según la siguiente tabla:

Asistencia | $f$
-------- | -------
0% a 49%   | 0,7
50% a 59%   | 0,8
60% a 69%   | 0,9
70% a 99%   | 1
100%   | 1,05

c) Prueba final $p$ de logro de competencias. Para aprobar el proyecto, se debe obtener un puntaje >= 50% en esta prueba. El factor de la prueba $pp$ se calcula de la siguiente forma:


```math
pp =
\begin{cases}
1{,}0 & \text{si } p \geq 50\% \\
0 & \text{si } p < 50\%
\end{cases}
```

d) La nota final del proyecto $P$ se calcula de la siguiente forma

$$
P = PT \cdot f \cdot pp \cdot 0,06 + 1
$$

La nota de presentación al examen $(NP)$ se calculará como:

$NP = ( 0.5 \cdot P + 0.5 \cdot \frac{I1 + I2}{2} )$

Se eximirán los estudiantes que cumplan todas las siguientes condiciones

- Haber rendido ambas interrogaciones
- Cada interrogación con nota mayor o igual a 4,0
- Asistencia a ayudantías mayor o igual a 70%
- Cada etapa del proyecto mayor o igual al 50% del puntaje de ella
- Prueba del proyecto con puntaje mayor o igual a 50%
- $NP$ ≥ 5,3

La nota final $(NF)$ se calcula como

```math
NF =
\begin{cases}
0{,}5 \cdot \bar{C} + 0{,}5 \cdot P, & \text{si } p \ge 50\% \\
\min(\bar{C}, 3{,}9), & \text{en otro caso}
\end{cases}
```

El curso se aprueba si, y solo si, todas las siguiente condiciones se cumplen:

- Nota final mayor o igual a 4,0 ($NF$ ≥ 4,0).
- Promedio de las evaluaciones de cátedra es mayor o igual a 3.9 ($\bar{C}$ ≥ 3,9)
- Nota del proyecto mayor o igual a 3,9 ($P$ ≥ 3,9)
- Prueba final del proyecto con puntaje mayor o igual a 60% ($p$ ≥ 60%)

En caso de no aprobar, la nota final del curso se calculará como Min{ **NF**, 3,9 }.

IMPORTANTE: La recorrección final es SOLO PRESENCIAL el lunes 14 de diciembre.

## Uso de IA

De manera general, a continuación se define el nivel de uso de Inteligencia Artificial en cada tipo de evaluación
del curso. Los enunciados de cada evaluación específica detallarán con mayor precisión qué usos están
autorizados y cuáles no.

| **Tipo de evaluación** | **Nivel de uso** |
|---|---|
| Interrogaciones | No permitido¹ |
| Proyecto | Permitido² |

<sub>¹ No permitido: El uso de IA no está autorizado, dado que la actividad busca evaluar exclusivamente el desempeño individual sin apoyo de herramientas automatizadas.</sub>

<sub>² Permitido: El uso de IA es aceptado como apoyo general, sin constituir un requisito para el desarrollo de la actividad.</sub>

En caso de uso de asistentes de inteligencia artificial, el/la estudiante sigue siendo responsable de comprender, verificar, explicar y defender todo el contenido
presentado. El equipo docente podrá solicitar explicación, defensa,
presentación, entrevista, modificación de código/modelo/cálculo o control asociado
para verificar el logro de aprendizajes.

---

## Política de integridad académica
Departamento Ciencia de la Computación
Escuela de Ingeniería – Pontificia Universidad Católica de Chile
 
Los/as estudiantes de la Escuela de Ingeniería de la Pontificia Universidad Católica de Chile deben mantener un comportamiento acorde a la Declaración de Principios de la Universidad.  En particular, se espera que mantengan altos estándares de honestidad académica.  Cualquier acto deshonesto o fraude académico está prohibido; los/as estudiantes que incurran en este tipo de acciones se exponen a un Procedimiento Sumario. Es responsabilidad de cada estudiante conocer y respetar el documento sobre Integridad Académica publicado por la Dirección de Docencia de la Escuela de Ingeniería.

Específicamente, para los cursos del Departamento de Ciencia de la Computación, rige obligatoriamente la siguiente política de integridad académica. Todo trabajo presentado por un/a estudiante para los efectos de la evaluación de un curso debe ser hecho individualmente por el/la estudiante, sin apoyo en material de terceros.  Por “trabajo” se entiende en general las interrogaciones escritas, las tareas de programación u otras, los trabajos de laboratorio, los proyectos, el examen, entre otros.

En particular, si un/a estudiante copia un trabajo, o si a un/a estudiante se le prueba que compró o intentó comprar un trabajo, obtendrá nota final 1.1 en el curso y se solicitará a la Dirección de Pregrado de la Escuela de Ingeniería que no le permita retirar el curso de la carga académica semestral.

Por “copia” se entiende incluir en el trabajo presentado como propio, partes hechas por otra persona. En caso que corresponda a “copia” a otros estudiantes, la sanción anterior se aplicará a todos los involucrados.  En todos los casos, se informará a la Dirección de Pregrado de la Escuela de Ingeniería para que tome sanciones adicionales si lo estima conveniente.

También se entiende por copia extraer contenido sin modificarlo sustancialmente desde fuentes digitales como Wikipedia o mediante el uso de asistentes inteligentes como ChatGPT o Copilot. Se entiende que una modificación sustancial involucra el análisis crítico de la información extraída y en consecuencia todas las modificaciones y mejoras que de este análisis se desprendan. Cualquiera sea el caso, el uso de fuentes bibliográficas, digitales o asistentes debe declararse de forma explícita, y debe indicarse cómo el/la estudiante mejoró la información extraída para cumplir con los objetivos de la actividad evaluativa.

Obviamente, está permitido usar material disponible públicamente, por ejemplo, libros o contenidos tomados de Internet, siempre y cuando se incluya la referencia correspondiente.

Lo anterior se entiende como complemento al Reglamento del Estudiante de la Pontificia Universidad Católica de Chile (https://registrosacademicos.uc.cl/reglamentos/estudiantiles/).  Por ello, es posible pedir a la Universidad la aplicación de sanciones adicionales especificadas en dicho reglamento.
 
## Compromiso del Código de Honor

Este curso suscribe el Código de Honor establecido por la Universidad, el que es vinculante.  Todo trabajo evaluado en este curso debe ser propio. En caso que exista colaboración permitida con otros/as estudiantes, el trabajo deberá referenciar y atribuir correctamente dicha contribución a quien corresponda. Como estudiante es un debe conocer el Código de Honor (https://www.uc.cl/codigo-de-honor/)
