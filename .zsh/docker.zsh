#!/bin/env zsh

function jekyll {
    if (( $# == 0 )) then 
        echo usage: jekyll [blog-path] ...;
    fi
    docker run --rm --name blog_instance --volume="$1:/srv/jekyll" \
        -p 4000:4000 -it jekyll/jekyll:latest jekyll serve --watch --drafts
}
