#!/usr/bin/env bash
set -e

skaffold delete
cd terraform && terraform destroy
