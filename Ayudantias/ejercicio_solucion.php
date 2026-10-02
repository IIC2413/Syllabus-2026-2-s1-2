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
  $correoLimpio = trim($correo);
  $correoLimpio = str_replace("..", ".", $correoLimpio);
  $correoLimpio = strtolower($correoLimpio);

  // Validar
  $correoValido = filter_var($correoLimpio, FILTER_VALIDATE_EMAIL);
  $edadValida = filter_var($edad, FILTER_VALIDATE_INT);

  // Registrar acciones
  if ($correoValido === false) {
    // Eliminación: no se puede arreglar
    fputcsv($log, [$id, "Eliminación", "correo inválido: $correo"]);

  } elseif ($edadValida === false) {
    // Ajuste: se rellena con un valor
    fputcsv($ok, [$id, $nombre, $correoValido, 0]);
    fputcsv($log, [$id, "Ajuste", "edad '$edad' cambia a 0"]);

  } elseif ($correoValido !== $correo) {
    // Corrección: el correo se arregló
    fputcsv($ok, [$id, $nombre, $correoValido, $edadValida]);
    fputcsv($log, [$id, "Corrección", "correo '$correo' cambia a '$correoValido'"]);

  } else {
    // Ninguna: estaba bien
    fputcsv($ok, [$id, $nombre, $correo, $edadValida]);
    fputcsv($log, [$id, "Ninguna", "permanece"]);
  }
}

fclose($entrada);
fclose($ok);
fclose($log);
?>