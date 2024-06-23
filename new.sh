#!/bin/sh

read -p "Give a name to your new example: " project_name
project_name=$(echo "$project_name" | tr ' ' '-')

mkdir "$project_name"
cd "$project_name"
mkdir src
touch src/.gitkeep
touch main.jac README.md requirements.txt

git add .
git commit -m "Initiated the $project_name" 