<?php

$google_script_url = "https://script.google.com/macros/s/AKfycbxtzKr8k9rnh1TEZXRgvH26XN4c55vl1rrftCGBLSwunB-hpE_i/exec";

function http_post($url, $postData) {
  $options = array(
    'http' => array(
      'header'  => "Content-type: application/json\r\n",
      'method'  => 'POST',
      'content' => $postData
    )
  );
  $context  = stream_context_create($options);
  return file_get_contents($url, false, $context);
}


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





$headers = getallheaders();
if (array_key_exists("X-Hook-Secret", $headers)) {
  $x_hook_secret = $headers["X-Hook-Secret"];
  header("X-Hook-Secret: $x_hook_secret");
  output(encode_csv_row(array($x_hook_secret)));
  // ccd1f28609b20b1c1011b8c2a6dd73518207b7a2ac046842e1d505aa81449c0b
} else if (array_key_exists("X-Hook-Signature", $headers)) {
  // TODO: check that the signature matches the secret

  // {
  //    "events" : [
  //       {
  //          "action" : "changed",
  //          "created_at" : "2019-12-21T03:33:19.007Z",
  //          "parent" : null,
  //          "resource" : {
  //             "gid" : "1154849068499809",
  //             "resource_subtype" : "default_task",
  //             "resource_type" : "task"
  //          },
  //          "user" : {
  //             "gid" : "55010250146157",
  //             "resource_type" : "user"
  //          }
  //       }
  //    ]
  // }
  $raw_post_body = file_get_contents('php://input');
  $response = http_post($google_script_url, $raw_post_body);
  output("response = " . $response);

  // google apps script returns 200 OK if the script throws an exception, so we
  // have to look at the contents to figure out if the request succeeded.
  if (strpos($response, "<title>Error</title>") !== false) {
    trigger_error("Google script failed, propagating the failure to Asana", E_USER_ERROR);
  }
} else {
  // for debugging
  output("headers = " . encode_csv_row(array_keys($headers)));
}

?>
