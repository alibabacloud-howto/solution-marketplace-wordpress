<!--
 * @Author: your name
 * @Date: 2021-06-24 19:01:27
 * @LastEditTime: 2021-06-30 20:02:27
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

Note: Replace the ``<ECS_EIP>`` placeholder with the Elastic IP address of the ECS instance. 

---
### Phase 1: WordPress ECS Server + Standalone RDS MySQL in Basic Edition
- **Decouple the database from web app server.**
- **More stable for both web app and database but still without high availability feature for both of them.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-1.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/1_wordpress_rds/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

![image.png]()

- After the Terraform script execution, logon to ECS via SSH, use the account root/N1cetest, the password has been predefined in Terraform script for this tutorial. If you changed the password, please use the correct password accordingly.

```bash
ssh root@<EIP_ECS>
```

Edit the WordPress configuration file to set the RDS MySQL URL, database and account information.

```bash
vim /data/wwwroot/wordpress/wp-config.php
```

![image.png]()

Open the following URL in a Web browser to initialize WordPress:

http://<ECS_EIP>
Note: Replace the <ECS_EIP> placeholder with the Elastic IP address of the ECS instance that you obtained previously.

---
### Phase 2-1: SLB + WordPress ECS Servers (Auto-scaling) + Cloud Native PolarDB MySQL
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use cloud native database PolarDB with high availability and scalability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-1.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_1_wordpress_slb_polardb/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

---
### Phase 2-2: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + RDS MySQL in High Availability Edition
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use RDS with cross availability zone feature for high availability.**
- **Use Redis as data cache to improve web app performance. The cross availability zone feature also ensure the high availability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-2.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_2_wordpress_slb_redis_rds/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).

---
### Phase 2-3: SLB + WordPress ECS Servers (Auto-scaling) + Multi-AZ Redis Cache + Cloud Native PolarDB MySQL
- **Setup SLB and auto-scaling group for multiple ECS servers with WordPress web app.**
- **Use cloud native database PolarDB with high availability and scalability.**
- **Use Redis as data cache to improve web app performance. The cross availability zone feature also ensure the high availability.**

![image.png](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/raw/master/images/archi-2-3.png)

Run the [terraform script](https://github.com/alibabacloud-howto/solution-marketplace-wordpress/blob/master/deployment/terraform/2_3_wordpress_slb_redis_polardb/main.tf) to initialize the resources.
Within the terraform script, please use the right ``Image ID`` of [WordPress image on the corresponding region](https://marketplace.alibabacloud.com/products/56720001/WP_CMS_on_LAMP-sgcmjj00025386.html).