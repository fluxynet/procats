<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Go Proverbs</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Proverb</th>
				<th>URL</th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($proverbs as $proverb) {?>
			<tr>
				<td><?php print $proverb['id']; ?></td>
				<td><?php print $proverb['proverb']; ?></td>
				<td><a href="<?php print $proverb['url']; ?>"><?php print $proverb['url']; ?></a></td>
			<tr>
			<?php }?>
		</tbody>
	</table>
	
</body>
</html>