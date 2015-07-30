Return-Path: <rtc-linux+bncBAABBPM55GWQKGQE6DGMHPY@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id bu1si282653pac.1.2015.07.30.09.20.12
        for <rtc-linux@googlegroups.com>;
        Thu, 30 Jul 2015 09:20:12 -0700 (PDT)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 21/27] rtc: Export OF module alias information in
 missing drivers
Date: Thu, 30 Jul 2015 18:18:46 +0200
Message-Id: <1438273132-20926-22-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-ab-b5ze-s3.c | 1 +
 drivers/rtc/rtc-isl12022.c   | 1 +
 drivers/rtc/rtc-isl12057.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 0fb1d767afa9..a319bf1e49de 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -1009,6 +1009,7 @@ static const struct of_device_id abb5zes3_dt_match[] = {
 	{ .compatible = "abracon,abb5zes3" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, abb5zes3_dt_match);
 #endif
 
 static const struct i2c_device_id abb5zes3_id[] = {
diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 372627136786..839d1fd63cd7 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -274,6 +274,7 @@ static const struct of_device_id isl12022_dt_match[] = {
 	{ .compatible = "isil,isl12022" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, isl12022_dt_match);
 #endif
 
 static const struct i2c_device_id isl12022_id[] = {
diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
index ee3e8dbcacaf..a0462e5430c7 100644
--- a/drivers/rtc/rtc-isl12057.c
+++ b/drivers/rtc/rtc-isl12057.c
@@ -648,6 +648,7 @@ static const struct of_device_id isl12057_dt_match[] = {
 	{ .compatible = "isil,isl12057" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, isl12057_dt_match);
 #endif
 
 static const struct i2c_device_id isl12057_id[] = {
-- 
2.4.3

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
