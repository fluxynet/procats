<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Cats</title>
</head>
<body>
	<?php foreach ($cats as $cat) { ?>
	<div><img style="width: 400px; height:auto" src="<?php print $cat['file'];?>" alt=""></div>
	<?php } ?>
</body>
</html>