<?php

$input = file_get_contents("input.txt");
$group_results = preg_split("/\n\n/", $input);

$group_counts = array();
for ($i = 0; $i < count($group_results); $i++)  {
    $answers = preg_replace('/\s+/', '', $group_results[$i]); 
    $chars = str_split($answers);
    array_push($group_counts, count(array_unique($chars)));
}

echo array_sum($group_counts);
