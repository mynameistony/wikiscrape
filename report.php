<body>
<?php
	if(isset($_POST['report'])) {
		$page = $_SERVER['HTTP_REFERER'];
		echo shell_exec("./report.sh $page");
		echo "<p>Thanks for your help</p>";
	}else{
		echo "What the fuck?";
	}
?>
</body>