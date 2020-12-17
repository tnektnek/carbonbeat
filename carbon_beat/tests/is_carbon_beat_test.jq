# JQ Imports
import "shared/assert.jq" as ASSERT;
import "../is_carbon_beat.jq" as INCLUDE;

# JSON Imports
import "./testdata/general.json" as $GENERAL;

# Tests
{
    # TODO: add more test cases
    "empty JSON object does not pass carbon_beat include": ASSERT::is_false( {} | INCLUDE::is_carbon_beat),
    "catch all carbon_beat JSON passes carbon_beat include": ASSERT::is_true($GENERAL::GENERAL | INCLUDE::is_carbon_beat)
}
