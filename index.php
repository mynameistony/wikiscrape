<?php
	echo "Random Articles";
	for ($i=0; $i < 7; $i++) { 
		echo shell_exec("./output-random-link.sh");	
	}
	
	echo shell_exec("./output-links.sh");
?>

