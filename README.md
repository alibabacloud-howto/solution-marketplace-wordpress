# WordPress (Marketplace) on Alibaba Cloud
Quick start with Wordpress on Alibaba Cloud. We use the [Wordpress image on Alibaba Cloud Marketplace](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

### Project URL
[https://github.com/alibabacloud-howto/solution-marketplace-wordpress](https://github.com/alibabacloud-howto/solution-marketplace-wordpress)


### Phase 0: "ALL-IN-ONE" for entry level deployment
Wordpress with web app server and MySQL database are all built within a single ECS instance.

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-0.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/0_wordpress/main.tf) to initialize the resources.

### Phase 1: Wordpress ECS Server + Standalone RDS MySQL in Basic Edition

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-1.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/1_wordpress_rds/main.tf) to initialize the resources.

### Phase 2-1: SLB + Wordpress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-1.png)


Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_1_wordpress_slb_polardb/main.tf) to initialize the resources.

### Phase 2-2: SLB + Wordpress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-2.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_2_wordpress_slb_redis_rds/main.tf) to initialize the resources.

### Phase 2-3: SLB + Wordpress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-3.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_3_wordpress_slb_redis_polardb/main.tf) to initialize the resources.