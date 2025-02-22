#!/bin/bash

# 从 manifest.json 读取版本号
VERSION=$(cat manifest.json | grep \"version\" | cut -d'"' -f4)

echo "Version from manifest.json: $VERSION"
echo "Will execute following commands:"
echo "git tag -a $VERSION -m \"$VERSION\""
echo "git push origin $VERSION"
echo "----------------------------------------"

# 创建带注释的 git tag
git tag -a $VERSION -m "$VERSION"

# 推送 tag 到远程仓库
git push origin $VERSION

echo "Successfully created and pushed tag $VERSION"
