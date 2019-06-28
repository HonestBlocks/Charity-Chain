<?php
$emailaddress = $_POST['emailaddress'];
$fullname = $_POST['fullname'];
$type = $_POST['type'];
$password = $_POST['password'];

if(!empty($emailaddress)||!empty($fullname)||!empty($type)||!empty($password)){
	$host = "localhost";
	$dbUsername = "root";
	$dbPassword = "";
	$dbname = "charitydb";

	//create connection
	$conn = new mysqli($host, $dbUsername, $dbPassword, $dbname);
	
	if (mysqli_connect_error()){
		die('Connect Error('. mysqli_connect_errorno().')'. mysqli_connect_error());	
	else{
	$SELECT = "SELECT emailaddress FROM register WHERE emailaddress = ? LIMIT 1";
	$INSERT = "INSERT INTO register(emailaddress, fullname, type, password) VALUES (?, ?, ?, ?)";
	
	//prepare statement
	$stmt = $conn->prepare($SELECT);
	$stmt->bind_param("s", $emailaddress);
	$stmt->execute();
	$stm->bind_result($emailaddress);
	$stm-.store_result();
	$rnum = $stmt->num_rows;
	
	if ($rnum==0){
		$stmt = $conn->prepare($INSERT);
		$stmt->bind_param("ssss", $emailaddress, $fullname, $type, $password);
		$stmt->execute();
		echo "New record inserted successfully!"

	}
	else{
	echo "Someone already registered!";
	}
	
	$stmt->close();
	$conn->close();	
	
	}

	
	}
}
else{
	echo "All fields are required!!!";
	die();
	
}

?>
