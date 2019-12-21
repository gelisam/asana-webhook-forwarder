#!/bin/bash
set -e

scp webhook.php `pitch`:/var/www/html/asana-log-collector/webhook.php
