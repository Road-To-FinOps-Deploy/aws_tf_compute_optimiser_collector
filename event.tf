resource "aws_cloudwatch_event_rule" "finops" {
  count               = var.enable_cloudwatch_event ? 1 : 0
  name                = "Account_List"
  schedule_expression = var.aws_co_cron
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  count     = var.enable_cloudwatch_event ? 1 : 0
  target_id = "Account_List"
  rule      = aws_cloudwatch_event_rule.finops[count.index].name
  arn       = module.lambda_compute_optimiser.function_arn

  input = "{ \"Records\":[ { \"messageId\":\"1\", \"body\":\"455007007237\" }, {\"messageId\":\"2\", \"body\":\"423143053313\" } ] }"
}

# data "template_file" "sql" {
#   template = var.query_location

#   vars = {
#     Database_Value = "kpmgcostanalysisathenadatabase${var.env}"
#     Team_Value     = var.team
#     Icm_Db_Val     = "icminfra${var.icm_env}"
#   }
# }

