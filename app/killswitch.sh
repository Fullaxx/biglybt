#!/bin/bash

ps ax | grep -v grep | grep 'BiglyBT.jar' | awk '{print $1}' | xargs kill
