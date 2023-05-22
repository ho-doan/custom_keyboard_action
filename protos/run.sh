# flutter pub global deactivate protoc_plugin
# flutter pub global activate protoc_plugin
dart pub global activate protoc_plugin
export PATH="$PATH":"$HOME/.pub-cache/bin"
mkdir -p ../lib/src/generated
mkdir -p ../ios/Classes/Generated
protoc --dart_out=../lib/src/generated ./keyboard_action.proto
protoc --swift_out=../ios/Classes/Generated ./keyboard_action.proto