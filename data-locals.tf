
locals {
    domain_name = "danielshiplett.com"
    s3_site_origin = "danielshiplett-site-s3"
    price_class = "PriceClass_100"

    #
    # A hard coded list of the cookies we want to pass through CloudFront.
    #
    common_cookie_whitelist = [

    ]
}