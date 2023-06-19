if which swiftlint >/dev/null; then
  git diff --name-only | grep .swift | while read filename; do
    swiftlint "$filename"
  done
else
  echo "SwiftLint does not exist, download from https://github.com/realm/SwiftLint"
fi
