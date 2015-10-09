<form action=index.php method="post">
<input type=text name=query placeholder=Search>
<input type=submit name=search value=Search>
</form>

<?php

	if(isset($_POST['search'])){
		$query = escapeshellarg($_POST['query']);

		echo shell_exec("./search.sh $query");
	}
	echo "Random Articles";
	for ($i=0; $i < 7; $i++) { 
		echo shell_exec("./output-random-link.sh");	
	}
	echo shell_exec("./output-links.sh");
?>

