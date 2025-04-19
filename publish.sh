#!/bin/bash

# -----------------------------------------------------------------------------
# 用途：自动读取 manifest.json 的版本号，创建并推送对应的 Git tag。
#
# 用法：
#   bash publish.sh
#
# 注意事项：
#   - 需要确保 manifest.json 文件中有 "version" 字段。
#   - 需要有 Git 推送权限，且本地仓库已与远程仓库同步。
#   - 脚本会自动终止于任何命令失败时。
# -----------------------------------------------------------------------------

# 定义一个执行命令的函数，它会先打印命令然后再执行
execute_cmd() {
    echo "Executing: $@"
    echo "----------------------------------------"
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "Error: Command failed with status $status"
        exit $status
    fi
    echo "----------------------------------------"
}

# 从 manifest.json 读取版本号
VERSION=$(cat manifest.json | grep \"version\" | cut -d'"' -f4)

echo "Version from manifest.json: $VERSION"
echo "Will execute following commands:"
echo "git tag -a $VERSION -m \"$VERSION\""
echo "git push origin $VERSION"
echo "----------------------------------------"

# 创建带注释的 git tag
execute_cmd git tag -a "$VERSION" -m "$VERSION"

# 推送 tag 到远程仓库
execute_cmd git push origin "$VERSION"

echo "Successfully created and pushed tag $VERSION"
