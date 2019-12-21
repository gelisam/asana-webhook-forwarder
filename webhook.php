<?php

function output($output) {
  file_put_contents('output.txt', $output . "\n");
}

// wrap in quotes (and double existing quotes)
function encode_csv_entry($str) {
  return '"' . str_replace('"', '""', $str) . '"';
}

function encode_csv_row($array) {
  return implode(",", array_map("encode_csv_entry", $array));
}


//$request = json_decode($_REQUEST['rawRequest'], true);

$header_name = "X-Hook-Secret";
$headers = getallheaders();
if (array_key_exists($header_name, $headers)) {
  $x_hook_secret = $headers[$header_name];
  header("$header_name: $x_hook_secret");
  output(encode_csv_row(array($x_hook_secret)));
} else {
  output(encode_csv_row(array_keys($headers)));
}

?>
