output "alb_sg_id" {
    value = "aws_security_group.sg-wp-base-alb.id"    
}
output "alb_arn" {
    value = "aws_lb.alb-wp-base.id"   
}
output "tg_arn" {
    value = "aws_lb_target_group.tg-wp-base.id"    
}