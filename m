Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: RTC: Add MODULE_DEVICE_TABLE to rtc-ds1672/rtc-max6900/rtc-max8998
From: Axel Lin <axel.lin@gmail.com>
Message-Id: <1303129017.8158.1.camel@phoenix>
To: linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Dale Farnsworth
 <dale@farnsworth.org>, Minkyu Kang <mk7.kang@samsung.com>, Joonyoung Shim
 <jy0922.shim@samsung.com>, rtc-linux@googlegroups.com
Date: Mon, 18 Apr 2011 20:16:57 +0800
List-ID: <rtc-linux.googlegroups.com>

The device table is required to load modules based on modaliases.
After adding MODULE_DEVICE_TABLE, below entries will be added to modules.alias:

alias i2c:ds1672 rtc_ds1672
alias i2c:max6900 rtc_max6900
alias platform:lp3974-rtc rtc_max8998
alias platform:max8998-rtc rtc_max8998

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Dale Farnsworth <dale@farnsworth.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/rtc/rtc-ds1672.c  |    1 +
 drivers/rtc/rtc-max6900.c |    1 +
 drivers/rtc/rtc-max8998.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 06dfb54..fa301d4 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -191,6 +191,7 @@ static struct i2c_device_id ds1672_id[] = {
 	{ "ds1672", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, ds1672_id);
 
 static struct i2c_driver ds1672_driver = {
 	.driver = {
diff --git a/drivers/rtc/rtc-max6900.c b/drivers/rtc/rtc-max6900.c
index 486142c..ef834c1 100644
--- a/drivers/rtc/rtc-max6900.c
+++ b/drivers/rtc/rtc-max6900.c
@@ -251,6 +251,7 @@ static struct i2c_device_id max6900_id[] = {
 	{ "max6900", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, max6900_id);
 
 static struct i2c_driver max6900_driver = {
 	.driver = {
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index 3f7bc6b..dade62e 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -315,6 +315,7 @@ static const struct platform_device_id max8998_rtc_id[] = {
 	{ "lp3974-rtc", TYPE_LP3974 },
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, max8998_rtc_id);
 
 static struct platform_driver max8998_rtc_driver = {
 	.driver		= {
