#!/bin/bash

composer install
bin/console server:run --env=prod 0.0.0.0:8080
