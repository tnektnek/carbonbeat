# JQ Imports
import "shared/assert.jq" as ASSERT;
import "shared/lib.jq" as SHAREDLIB;
import "../lib/log_type.jq" as LOGTYPE;

# JSON Imports
import "./testdata/carbon_beat.json" as $JSON;

# Tests
{
    "log type get retrieves correct type from carbon_beat.json": ASSERT::equal(""; $JSON::JSON | SHAREDLIB::get_io_format | LOGTYPE::get_sub_type)
}
