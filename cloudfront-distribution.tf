resource "aws_cloudfront_origin_access_identity" "site" {
}

data "aws_cloudfront_cache_policy" "managed_cachingoptimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "managed_cors_s3origin" {
  name = "Managed-CORS-S3Origin"
}

resource "aws_cloudfront_distribution" "distribution" {

	aliases             = [
        local.domain_name
    ]
    enabled             = true
	is_ipv6_enabled     = true
    default_root_object = "index.html"
	price_class         = local.price_class
    tags                = {
        Name = "Site Distribution"
    }

	origin {
        #
        # Domain name should be regional.  However, see https://github.com/hashicorp/terraform-provider-aws/issues/15102
        # for why 'aws_s3_bucket.site.bucket_regional_domain_name' isn't working.  Update this later once that issue is
        # resolved.
        #
		domain_name = "site-${data.aws_caller_identity.current.account_id}.s3.us-east-1.amazonaws.com"
		origin_id = local.s3_site_origin

		s3_origin_config {
       	    origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
        }
	}

	restrictions {
		geo_restriction {
			restriction_type = "none"
		}
	}

	viewer_certificate {
		acm_certificate_arn = aws_acm_certificate.site.arn
		ssl_support_method = "sni-only"
		minimum_protocol_version = "TLSv1.2_2019"
	}

	default_cache_behavior {
		target_origin_id         = local.s3_site_origin
        cache_policy_id          = data.aws_cloudfront_cache_policy.managed_cachingoptimized.id
        origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_cors_s3origin.id

		allowed_methods  = [ "GET", "HEAD", "OPTIONS" ]
		cached_methods   = [ "GET", "HEAD" ]

		viewer_protocol_policy = "redirect-to-https"
		compress    = true
	}
}