#! /usr/bin/env bash

npm rebuild

echo ">> Starting server..."

grunt --no-color &

echo ">> Server started"

sleep 5

echo ">> Running acceptance tests..."
grunt --no-color test:acceptance
_test_exit_code=$?

echo ">> Killing server"

kill %1

echo ">> Done"

exit $_test_exit_code
