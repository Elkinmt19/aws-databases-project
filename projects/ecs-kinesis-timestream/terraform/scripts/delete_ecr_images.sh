#!/bin/bash

repositories=$(aws ecr describe-repositories --query 'repositories[].repositoryName' --output text)

for repository in $repositories; do
    echo "Deleting images from repository: $repository"
    aws ecr batch-delete-image --repository-name "$repository" --image-ids imageTag=latest
done