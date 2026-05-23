<?php 

switch ($_POST)
{
// caso a variavel seja nula mostrar na tela de login

case isset($_POST[null]):
include_once "View/login.php";
break;

// primeiro acesso

case isset($_POST["btnPrimeiroAcesso"]);
    include_once "../View/primeiroAcesso.php";
    break;





} 
?>