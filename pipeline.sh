#!/bin/bash

ps -ef | while read firstvar
do
  echo firstvar within the loop: $firstvar
  secondvar=$firstvar
  echo secondvar within the loop: $secondvar
done

echo firstvar outside the loop: $firstvar
echo secondvar outside the loop: $secondvar
