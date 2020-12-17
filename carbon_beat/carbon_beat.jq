# get_io_format converts incoming data to a standard IO format. The original
#   content is added to the output in the "original_message" field automatically.
def get_io_format:
    {
        "input": .,
        "output": {
            "original_message": . | tojson
        }
    }
;

# transform will normalize the incoming log into the LogRhythm Schema
#   that can then be forwarded to the SIEM
def transform:
    # First, convert to IO format.
    get_io_format |

    .output.beatname = .input.beat.name |
    .output.process = .input.cb.threat_info.summary.actorName |
    .output.hash = .input.cb.threat_info.indicators[0].sha256Hash |
    .output.vendorinfo = .input.cb.threat_info.summary.reason | 
    .output.policy = .input.cb.threat_info.incidentId |
    .output.subject = .input.cb.threat_info.summary.threatCategory |
    .output.sname = .input.deviceName | 
    .output.dname = .input.externalIpAddress |
    .output.sip = .input.internalIpAddress |
    .output.account = .input.email |
    # this function only produces the output object
    .output
;
