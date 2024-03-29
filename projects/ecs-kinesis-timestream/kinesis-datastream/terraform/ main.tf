# Elastic Container Repository Configuration
resource "aws_kinesis_stream" "kinesis_stream" {
	name = var.kds_name
	retention_period = 24

	shard_level_metrics = [
		"IncomingBytes",
		"IncomingRecords",
		"OutgoingBytes",
		"OutgoingRecords",
	]
	stream_mode_details {
		stream_mode = "ON_DEMAND"
	}
    tags = {
		name = var.project_name
		env = var.env
    }
}
