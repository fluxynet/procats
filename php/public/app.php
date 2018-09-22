<?php
// formatting was done manually; the code was not written on a modern (bloated) ide, which would have rules predefined
// in which case all team members need to align thereupon (PSR probably; have you heard of PSR?)

$uri = $_SERVER['REQUEST_URI'];
chdir('/var/www/'); // for sanity; can be deduced but hardcoding for this excercise

// simple database connection code
// we assume pgsql drivers are installed
// although such a requirement is not specified anywhere; talk to your admin team to avoid surprises on prod!
function dbconnect() {
	try {
		$conn = new PDO('pgsql:dbname=fx;host=postgres', 'fx', 'fx');

		// we alter the way error handling flow behaves - use exceptions for errors
		// talk to your whole team about it to avoid assumptions and surprises!
		$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		return $conn;
	} catch (PDOException $e) {
		print 'Connection failed: ' . $e->getMessage();
		exit; // we can exit safely, the whole site will not crash; just this subprocess (processes handled by fpm; have you heard of fpm?)
	}
}

function homepageHandler() {
	$conn = dbconnect();
	// we must update stats table sequentially
	// it delays the actual response; not so neat...
	$conn->query("UPDATE stats SET visits = visits+1 WHERE url = '/'");

	$stmt     = $conn->query('SELECT id, proverb, url FROM proverbs');
	$proverbs = $stmt->fetchAll();

	// php originated as a templating language for C programs; it handles templating beautifully
	include('templates/proverbs.tpl.php');
}

function catsHandler() {
	$getcat = function() {
		// in real-life scenario, a proper library (guzzle?) would be used for requests
		// but we are not using those
		// it helps us understand the guiding philosophy of the language - much of the earlier code feel like C / Unix tools wrappers
		// if rewritten, modern php object-oriented approach might have been used instead
		$ch = curl_init('https://aws.random.cat/meow');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$data = curl_exec($ch);
		curl_close($ch);
		$json = json_decode($data, true);
		return $json;
	};

	// unless we go to great lengths; php cannot do threading; we have to fetch the cats sequentially :(
	// try adding like 20 cats - question: what happens when a php process times out?
	// can timeout be handled (easily) at php level or must we tune other parts of the stack? are you aware of other parts of the stack? talk to your admin team!
	$cats = [];
	$cats[] = $getcat();
	$cats[] = $getcat();
	$cats[] = $getcat();
	$cats[] = $getcat();

	// php originated as a templating language for C programs; it handles templating beautifully
	include('templates/cats.tpl.php');
}

if ($uri === '/') {
	homepageHandler();
} elseif ($uri === '/cats') {
	catsHandler();
} else {
	http_response_code(404);
	print '404';
}