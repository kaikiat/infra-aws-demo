resource "aws_codedeploy_app" "gt_codedeploy_app" {
  name = "GTApplication"
}

resource "aws_codedeploy_deployment_group" "gt_codedeploy_deployment_group" {
  app_name               = aws_codedeploy_app.gt_codedeploy_app.name
  deployment_group_name  = "production"
  service_role_arn       = "arn:aws:iam::474252128070:role/CodeDeployServiceRole"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = "Instance-1"
      type  = "KEY_AND_VALUE"
    }
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = "Instance-2"
      type  = "KEY_AND_VALUE"
    }
  }

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
}