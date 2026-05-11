<?php
require_once 'ConexaoBD.php';

$con = new ConexaoBD();
$conn = $con->conectar();

if ($conn->connect_error){
die("Erro na conexão: ". $conn->connect_error);
}

echo "Conexão realizada com sucesso!";
?>