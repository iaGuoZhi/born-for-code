#!/usr/bin/env sh

_() {
  echo "Github Username: "
  read -r USERNAME
  echo "Repo Name: "
  read -r REPO
  echo "Year: "
  read -r YEAR
  echo "Month: "
  read -r MONTH
  echo "Day: "
  read -r DAY

  [ -z "$USERNAME" ] && exit 1
  [ -z "$REPO" ] && exit 1
  [ -z "$YEAR" ] && exit 1
  [ -z "$MONTH" ] && exit 1
  [ -z "$DAY" ] && exit 1

  [ ! -d $REPO ] && mkdir $REPO

  cd "${REPO}" || exit
  git init
  printf "**${REPO}: in ${YEAR}:${MONTH}:${DAY}**\n\n - *Inspired by https://github.com/antfu/1990-script*" \
    >README.md

  # copy this script to repo
  cp ../$0 ./

  git add .
  GIT_AUTHOR_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
    GIT_COMMITTER_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
    git commit -m "${YEAR}-${MONTH}-${DAY}"
  git remote add origin "https://github.com/${USERNAME}/${REPO}.git"
  git branch -M main
  git push -u origin main -f
  cd ..

  echo
  echo "Cool, check your profile now: https://github.com/${USERNAME}"
} && _

unset -f _
