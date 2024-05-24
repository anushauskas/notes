# Prometheus Queries

Use increase for actual number of requests
Use rate to make average per second
Set options Min step to 2*metrics push interval

## Request count

```
topk by(http_request_method, server_address) (15, sum by(http_request_method, server_address) (increase(http_client_request_duration_seconds_count{job="$job", deployment_environment="$environment", instance=~"$instance"}[$__rate_interval])))
```

## Average request duration

```
sum by(server_address, http_request_method) (increase(http_client_request_duration_seconds_sum{job="$job", deployment_environment="$environment", instance=~"$instance"}[$__rate_interval])) / sum by(server_address, http_request_method) (increase(http_client_request_duration_seconds_count{job="$job", deployment_environment="$environment", instance=~"$instance"}[$__rate_interval]))
```

# Loki queries

## Extract field

Extract, filter, format

Trace id must be presented to get link to traces
```
{job="$job", deployment_environment="$environment"} | json traceid, body, instance="resources[\"service.instance.id\"]" | instance="$instance" | line_format "{{.body}}, traceId={{.traceid}}"
```

Summarise by label and extracted field

```
sum by(level, instance) (count_over_time({job="$job", deployment_environment="$environment"} | json instance="resources[\"service.instance.id\"]" [$__auto]))

```