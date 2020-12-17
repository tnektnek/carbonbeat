package app

import (
	"time"
	"fmt"

	"github.com/elastic/beats/libbeat/common"
	"github.com/elastic/beats/libbeat/logp"
	"github.com/tnektnek/carbonbeat/carbonclient"
)

func (bt *Carbonbeat) processNotifications(n carbonclient.Notifications) ([]common.MapStr, error) {
	var notifications []common.MapStr
	if n.Success {
		logp.Debug("api", "%v events collected", len(n.Notifications))
		for _, e := range n.Notifications {
				event := common.MapStr{
					// fields common b/w event types
					"@eventTime": common.Time(time.Now()),
					"eventTime":  e.EventTime,
					"type":       e.Type,
					"url":        e.URL,
					"internalIpAddress":     e.DeviceInfo.InternalIPAddress,
					"deviceName":   e.DeviceInfo.DeviceName,
					"externalIpAddress":     e.DeviceInfo.ExternalIPAddress,
					"email":       e.DeviceInfo.Email,
					"eventDescription":    e.EventDescription,

					// fields specific to cb defense
					"cb": common.MapStr{
						"ruleName":            e.RuleName,
						"deviceVersion":       e.DeviceInfo.DeviceVersion,
						"deviceType":          e.DeviceInfo.DeviceType,
						"deviceId":            e.DeviceInfo.DeviceID,
						"groupName":           e.DeviceInfo.GroupName,
						"targetPriorityType": e.DeviceInfo.TargetPriorityType,
						"targetPriorityCode": e.DeviceInfo.TargetPriorityCode,
					},
				}

				// fields specific to threatInfo events
				if e.ThreatInfo.IncidentID != "" {
					event.Put("cb.threat_info.incidentId", e.ThreatInfo.IncidentID)
					event.Put("cb.threat_info.score", e.ThreatInfo.Score)
					event.Put("cb.threat_info.summary", e.ThreatInfo.Summary)

					event.Put("cb.threat_info.indicators", e.ThreatInfo.Indicators)
					event.Put("cb.threat_info.summary", e.ThreatInfo.ThreatCause)
					notifications = append(notifications, event)
				}

				// fields specific to policyAction events
				if e.PolicyAction.Action != "" {
					event.Put("cb.policy_action", e.PolicyAction)
					notifications = append(notifications, event)
				}

			}
			fmt.Printf("%+v\n",notifications)
			return notifications, nil
	}
	logp.Warn("something went wrong, because notifications['success'] was false for what ever reason. good luck."+
		"here's whatever they gave us: %v", n)
	return notifications, nil
}
