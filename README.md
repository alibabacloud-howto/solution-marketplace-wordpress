<!--
 * @Author: your name
 * @Date: 2021-06-24 19:01:27
 * @LastEditTime: 2021-07-01 15:49:55
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /ws_cloudsolution/solution-marketplace-wordpress/README.md
-->
# WordPress (Marketplace) on Alibaba Cloud
Quick start with WordPress on Alibaba Cloud. We use the [WordPress image on Alibaba Cloud Marketplace](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

### Project URL
[https://github.com/alibabacloud-howto/solution-marketplace-wordpress](https://github.com/alibabacloud-howto/solution-marketplace-wordpress)

### Index

- [Phase 0: "ALL-IN-ONE" for entry level deployment](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-0-all-in-one-for-entry-level-deployment)
- [Phase 1: WordPress ECS Server + Standalone RDS MySQL in Basic Edition](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-1-wordpress-ecs-server--standalone-rds-mysql-in-basic-edition)
- [Phase 2-1: SLB + WordPress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-1-slb--wordpress-ecs-servers-auto-scaling--cloud-native-polardb-mysql)
- [Phase 2-2: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-2-slb--wordpress-ecs-servers-auto-scaling--multi-az-redis-cache--rds-mysql-in-high-availability-edition)
- [Phase 2-3: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-3-slb--wordpress-ecs-servers-auto-scaling--multi-az-redis-cache--cloud-native-polardb-mysql)
- [Pricing](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#pricing)

---
### Phase 0: "ALL-IN-ONE" for entry level deployment
- **WordPress with web app server and MySQL database are all built within a single ECS instance.**
- **This is for entry level deployment with low cost but without high availability feature for both web app and database.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-0.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/0_wordpress/main.tf) to initialize the resources. 
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase0_1.png)

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase0_2.png)

After the Terraform script execution, open the following URL in a Web browser to initialize WordPress: 

```bash
http://<ECS_EIP>
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase0_3.png)

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance. 

---
### Phase 1: WordPress ECS Server + Standalone RDS MySQL in Basic Edition
- **Decouple the database from web app server.**
- **More stable for both web app and database but still without high availability feature for both of them.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-1.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/1_wordpress_rds/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

- After the Terraform script execution, logon to ECS via SSH, use the account root/N1cetest, the password has been predefined in Terraform script for this tutorial. If you changed the password, please use the correct password accordingly.

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase1_1.png)

```bash
ssh root@<EIP_ECS>
```

Edit the WordPress configuration file to set the RDS MySQL URL, database and account information.

```bash
vim /data/wwwroot/wordpress/wp-config.php
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase1_2.png)

Open the following URL in a Web browser to initialize WordPress:

```
http://<ECS_EIP>
```

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance that you obtained previously.

---
### Phase 2-1: SLB + WordPress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use cloud native database PolarDB with high availability and scalability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-1.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_1_wordpress_slb_polardb/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

- After the Terraform script execution, logon to ECS via SSH, use the account root/N1cetest, the password has been predefined in Terraform script for this tutorial. If you changed the password, please use the correct password accordingly.

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_1_1.png)

```bash
ssh root@<EIP_ECS>
```

Edit the WordPress configuration file to set the PolarDB MySQL URL, database and account information.

```bash
vim /data/wwwroot/wordpress/wp-config.php
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_1_2.png)

Open the following URL in a Web browser to initialize WordPress:

```
http://<ECS_EIP>
```

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance that you obtained previously.

#### Auto-scaling configuration
After you have successfully configured and installed WordPress, you can follow the following guide for auto-scaling configurations:

[https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling)

---
### Phase 2-2: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use RDS with cross availability zone feature for high availability.**
- **Use Redis as data cache to improve web app performance. The cross availability zone feature also ensure the high availability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-2.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_2_wordpress_slb_redis_rds/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

- After the Terraform script execution, logon to ECS via SSH, use the account root/N1cetest, the password has been predefined in Terraform script for this tutorial. If you changed the password, please use the correct password accordingly.

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_2_1.png)

```bash
ssh root@<EIP_ECS>
```

Edit the WordPress configuration file to set the RDS MySQL URL, database and account information.

```bash
vim /data/wwwroot/wordpress/wp-config.php
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_2_2.png)

Open the following URL in a Web browser to initialize WordPress:

```
http://<ECS_EIP>
```

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance that you obtained previously.

#### Configure Redis caching
Run the following commands in sequence to download the Redis object cache plugin and unzip the plugin package: 

```bash
wget https://downloads.wordpress.org/plugin/redis-cache.2.0.18.zip 
unzip redis-cache.2.0.18.zip 
```

Run the following commands in sequence to copy the redis-cache folder to the ``/data/wwwroot/wordpress/wp-content/plugins/`` path and configure WordPress to access ApsaraDB for Redis:

```bash
cp -rf redis-cache /data/wwwroot/wordpress/wp-content/plugins/ 
vim /data/wwwroot/wordpress/wp-config.php
```

Complete the settings as follows: 

```bash
// Redis settings
define( 'WP_REDIS_HOST', '<Redis URL>' );
define( 'WP_REDIS_CLIENT', 'predis' );
define( 'WP_REDIS_PORT', '6379' );
define( 'WP_REDIS_DATABASE', '0');
define( 'WP_REDIS_PASSWORD', 'wordpress:N1cetest' );
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_2_3.png)

Please MAKE SURE this Redis setting block is set at the first settings block of the wp-config.php file as shown in the image above.


Run the following command to copy the object-cache configuration file to the ``/data/wwwroot/wordpress/wp-content/`` path:

```bash
cp /data/wwwroot/wordpress/wp-content/plugins/redis-cache/includes/object-cache.php /data/wwwroot/wordpress/wp-content/ 
```

Log on to WordPress to enable Redis object cache. 

![image.png](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting/raw/main/images/step3_2.png)

In the left-side navigation pane, click Plugins. Find the Redis Object Cache plugin and click Activate.  
After the plugin is activated, click Settings. 

![image.png](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting/raw/main/images/step3_3.png)

Verify that the plugin status is Connected. Click Flush Cache to synchronize cache data to the ApsaraDB for Redis instance.

![image.png](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting/raw/main/images/step3_4.png)

Now, your cloud native Wordpress has been setup successfully. You can visit it via SLB EIP:

```php
http://<SLB_EIP>/
```

#### Auto-scaling configuration
After you have successfully configured and installed WordPress, you can follow the following guide for auto-scaling configurations:

[https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling)

---
### Phase 2-3: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use cloud native database PolarDB with high availability and scalability.**
- **Use Redis as data cache to improve web app performance. The cross availability zone feature also ensure the high availability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-3.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_3_wordpress_slb_redis_polardb/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

- After the Terraform script execution, logon to ECS via SSH, use the account root/N1cetest, the password has been predefined in Terraform script for this tutorial. If you changed the password, please use the correct password accordingly.

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_3_1.png)

```bash
ssh root@<EIP_ECS>
```

Edit the WordPress configuration file to set the PolarDB MySQL URL, database and account information.

```bash
vim /data/wwwroot/wordpress/wp-config.php
```

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/phase2_3_2.png)

Open the following URL in a Web browser to initialize WordPress:

```
http://<ECS_EIP>
```

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance that you obtained previously.

#### Configure Redis caching
Please follow the this step to configure the Redis caching:

[https://github.com/alibabacloud-howto/solution-marketplace-wordpress#configure-redis-caching](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#configure-redis-caching)

#### Auto-scaling configuration
After you have successfully configured and installed WordPress, you can follow the following guide for auto-scaling configurations:

[https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling](https://github.com/alibabacloud-howto/solution-cloud-native-web-hosting#step-4-optional-make-custom-ecs-image-for-auto-scaling)

---
### Pricing

- We calculate the price based on the resource and service in ``Singapore`` region.
- If auto-scaling is configured, the extra scaled ECS instances are not counted within the total price.
- PolarDB is compute and storage decoupled, the fee of storage is not counted within the total price.

| Cloud Service  | Specification | Pay-As-You-Go Price | Subscription Price |
| --- | --- | --- | --- |
| ECS | ecs.c5.large, 40GB SSD system disk, 100GB ultra disk data disk  | $0.11 USD/Hour | $55.94 USD/Month |
| WordPress Image | | $0.055 USD/Hour | $40 USD/Month |
| EIP | Pay By Bandwith 10Mbit/s | $3.3612 USD/Day | |
| SLB | slb.s2.medium | $0.12 USD/Hour | |
| RDS MySQL basic | mysql.n2.small.1, 1 core 2GB general purpose, 20GB ESSD | $0.03 USD/Hour | $14.18 USD/Month |
| RDS MySQL high availability | mysql.x2.medium.2c, 2 core 4GB dedicated instance, 20GB ESSD | $0.25 USD/Hour | $119.17 USD/Month |
| PolarDB MySQL | polar.mysql.x4.medium, 2 core 8 GB dedicated instance | $0.318 USD/Hour | $152 USD/Month |
| Redis | redis.master.small.default, 1GB Master-Replica | $0.034 USD/Hour | $16.32 USD/Month |

| Solution Phase  | Services | Estimated Hourly Price | Estimated Monthly Subscription Price |
| --- | --- | --- | --- |
| [Phase 0: "ALL-IN-ONE" for entry level deployment](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-0-all-in-one-for-entry-level-deployment) | ECS, WordPress Image, EIP for ECS | $0.305 USD/Hour | $196.776 USD/Month |
| [Phase 1: WordPress ECS Server + Standalone RDS MySQL in Basic Edition](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-1-wordpress-ecs-server--standalone-rds-mysql-in-basic-edition) | ECS, WordPress Image, EIP for ECS, RDS MySQL basic| $0.335 USD/Hour | $210.956 USD/Month |
| [Phase 2-1: SLB + WordPress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-1-slb--wordpress-ecs-servers-auto-scaling--cloud-native-polardb-mysql) | ECS, WordPress Image, SLB, EIP for ECS, EIP for SLB, PolarDB MySQL | $0.883 USD/Hour | $536.012 USD/Month |
| [Phase 2-2: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-2-slb--wordpress-ecs-servers-auto-scaling--multi-az-redis-cache--rds-mysql-in-high-availability-edition) | ECS, WordPress Image, SLB, EIP for ECS, EIP for SLB, RDS MySQL high availability, Redis | $0.849 USD/Hour | $519.502 USD/Month |
| [Phase 2-3: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL](https://github.com/alibabacloud-howto/solution-marketplace-wordpress#phase-2-3-slb--wordpress-ecs-servers-auto-scaling--multi-az-redis-cache--cloud-native-polardb-mysql) | ECS, WordPress Image, SLB, EIP for ECS, EIP for SLB, PolarDB MySQL, Redis | $0.917 USD/Hour | $552.332 USD/Month |