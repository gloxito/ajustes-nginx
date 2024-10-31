<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
    $uploads_dir = 'uploads';  // Directorio donde se guardarán los archivos

    // Asegúrate de que el directorio de carga existe
    if (!is_dir($uploads_dir)) {
        mkdir($uploads_dir, 0755, true);
    }

    // Mueve el archivo subido a la ubicación deseada
    $tmp_name = $_FILES['file']['tmp_name'];
    $name = basename($_FILES['file']['name']);
    
    if (move_uploaded_file($tmp_name, "$uploads_dir/$name")) {
        echo "El archivo se ha subido correctamente: $name";
    } else {
        echo "Error al subir el archivo.";
    }
} else {
    echo "No se ha enviado ningún archivo.";
}
?>
