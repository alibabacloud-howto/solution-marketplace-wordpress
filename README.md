# WordPress (Marketplace) on Alibaba Cloud
Quick start with Wordpress on Alibaba Cloud.

### Project URL
[https://github.com/alibabacloud-howto/solution-marketplace-wordpress](https://github.com/alibabacloud-howto/solution-marketplace-wordpress)


### Phase 0: "ALL-IN-ONE" for entry level deployment
Wordpress with web app server and MySQL database are all built within a single ECS instance.

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/0_wordpress/main.tf) to initialize the resources.

### Phase 1: Wordpress ECS Server + Standalone RDS MySQL in Basic Edition

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/1_wordpress_rds/main.tf) to initialize the resources.

### Phase 2-1: SLB + Wordpress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_1_wordpress_slb_polardb/main.tf) to initialize the resources.

### Phase 2-2: SLB + Wordpress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_2_wordpress_slb_redis_rds/main.tf) to initialize the resources.

### Phase 2-3: SLB + Wordpress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_3_wordpress_slb_redis_polardb/main.tf) to initialize the resources.