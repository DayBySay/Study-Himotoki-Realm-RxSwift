<?php

$RSSpath = "https://github.com/ReactiveX/RxSwift/releases.atom";
$XML = new SimpleXMLElement($RSSpath, 0, true);
$json = json_encode($XML);
echo $json;
