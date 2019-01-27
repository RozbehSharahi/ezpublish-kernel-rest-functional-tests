<?php

$composer = json_decode(file_get_contents(__DIR__ . '/composer.json'), true);

$composer['repositories'] = !empty($composer['repositories']) ? $composer['repositories'] : [];

$composer['repositories'][] = [
    'type' => 'path',
    'url' => '../ezpublish-kernel'
];

file_put_contents(__DIR__ . '/composer.json', json_encode($composer, JSON_PRETTY_PRINT));