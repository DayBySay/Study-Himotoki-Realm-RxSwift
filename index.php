<?php

$json_array = [
    "users" => [
        [
            "id" => 0,
            "name" => "take",
            "age" => 29
        ],
        [
            "id" => 1,
            "name" => "yoppi",
            "age" => 22
        ],
        [
            "id" => 2,
            "name" => "sema",
            "age" => 19
        ],
        [
            "id" => 3,
            "name" => "unko",
            "age" => 99
        ],
    ]
];

$json = json_encode($json_array);
echo $json;
