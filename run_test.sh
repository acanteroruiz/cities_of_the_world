# Main script
echo "Running tests...."
fvm flutter test --coverage --test-randomize-ordering-seed random
echo "Tests completed...."
echo "Filtering coverage report...."
lcov --remove coverage/lcov.info \
'*/view/*' \
'*/pages/*' \
'*/widgets/*' \
'*_interface.dart' \
'*.g.dart' \
-o coverage/lcov_filtered.info
echo "Generating coverage report...."
genhtml coverage/lcov_filtered.info -o coverage/
echo "Coverage report generated...."
open coverage/index.html