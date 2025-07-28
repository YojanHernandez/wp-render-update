<?php
// Archivo para validar conexión MySQL
// Guarda esto como db-test.php en tu sitio

$host = $_ENV['WORDPRESS_DB_HOST'];
$dbname = $_ENV['WORDPRESS_DB_NAME'];
$username = $_ENV['WORDPRESS_DB_USER'];
$password = $_ENV['WORDPRESS_DB_PASSWORD'];

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    echo "<h2>✅ Conexión MySQL exitosa!</h2>";
    echo "<p><strong>Host:</strong> $host</p>";
    echo "<p><strong>Base de datos:</strong> $dbname</p>";
    echo "<p><strong>Usuario:</strong> $username</p>";
    
    // Mostrar tablas
    $stmt = $pdo->query("SHOW TABLES");
    echo "<h3>Tablas en la base de datos:</h3>";
    echo "<ul>";
    while ($row = $stmt->fetch()) {
        echo "<li>" . $row[0] . "</li>";
    }
    echo "</ul>";
    
    // Mostrar versión MySQL
    $stmt = $pdo->query("SELECT VERSION() as version");
    $version = $stmt->fetch();
    echo "<p><strong>Versión MySQL:</strong> " . $version['version'] . "</p>";
    
} catch(PDOException $e) {
    echo "<h2>❌ Error de conexión:</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
}
?>
