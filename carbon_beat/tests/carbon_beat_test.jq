# JQ Imports
import "shared/assert.jq" as ASSERT;
import "../carbon_beat.jq" as TRANSFORM;

# JSON Imports
import "./testdata/general.json" as $JSON;

# Transform test data
$JSON::JSON | TRANSFORM::transform as $transformed |

# Tests
# build an assertion object. Each key should be the name of a test, and each value a
# test evaluating to boolean. Any other value is considered a failure and will be reported
{
    # TODO: fill out expected beatname
    "Transform applies correctly end to end":  ASSERT::equal(""; $transformed | .output.beatname)
}
