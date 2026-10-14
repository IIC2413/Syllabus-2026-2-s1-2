<?php
$entrada = fopen("datos.csv", "r");
$ok = fopen("datosok.csv", "w");
$log = fopen("datoslog.csv", "w");

fputcsv($ok, ["id", "nombre", "correo", "edad"]); // Agregamos nombres columnas
fputcsv($log, ["registro", "accion", "detalle"]); // Agregamos nombres columnas

fgetcsv($entrada); // Saltar encabezado

while (($fila = fgetcsv($entrada)) !== false) {
  [$id, $nombre, $correo, $edad] = $fila;

  // Limpiar

  // Validar

  // Registrar acciones
  if ($correoValido === false) {
    // Eliminación: no se puede arreglar

  } elseif ($edadValida === false) {
    // Ajuste: se rellena con un valor

  } elseif ($correoValido !== $correo) {
    // Corrección: el correo se arregló

  } else {
    // Ninguna: estaba bien
    
  }
}

fclose($entrada);
fclose($ok);
fclose($log);
?>