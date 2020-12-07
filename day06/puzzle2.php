<?php

$input = file_get_contents("input.txt");
$group_results = preg_split("/\n\n/", $input);

$group_counts = array();
for ($i = 0; $i < count($group_results); $i++)  {
    $per_person = preg_split("/\n/", trim($group_results[$i]));

    $answers = array();
    foreach($per_person as $person_answers) {
        array_push($answers, str_split($person_answers));
    }

    $result = call_user_func_array('array_intersect', $answers);
    array_push($group_counts, count($result));
}

print(array_sum($group_counts) . "\n");
