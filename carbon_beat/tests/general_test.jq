# JQ Imports
import "shared/assert.jq" as ASSERT;
import "shared/lib.jq" as LIB;
import "../transforms/general.jq" as GENERAL;

# JSON Imports
import "./testdata/general.json" as $JSON;

# Transform test data
$JSON::JSON | LIB::get_io_format | GENERAL::add_fields as $transformed |

# Tests
{
    # TODO: fill out expected beatname
    "Catchall log parses beat name":  ASSERT::equal(""; $transformed | .output.beatname)
}
