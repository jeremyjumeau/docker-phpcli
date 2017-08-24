<?php

// this php snippet doesn't respect Symfony coding standard
$hi = 'Hello World!';
$var = "unused variable";
if (true){
    print_r($hi);
    return;
} else {
    // there should be no `else` instruction
    eval('$param = 23;');
    exit;
}
