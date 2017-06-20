Return-Path: <rtc-linux+bncBDKNBMNKRMJRB5OZUPFAKGQEOJBYBLQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id w193si3483598wmf.3.2017.06.20.02.37.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:37:55 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id d73so14472917wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:37:55 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 24/51] rtc: ds2404: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:32 +0200
Message-Id: <1497951359-13334-25-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

For the same reasons use set_mmss64 callback instead of set_mmss

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-ds2404.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-ds2404.c b/drivers/rtc/rtc-ds2404.c
index 9a1582e..b7d04a7 100644
--- a/drivers/rtc/rtc-ds2404.c
+++ b/drivers/rtc/rtc-ds2404.c
@@ -201,16 +201,16 @@ static void ds2404_enable_osc(struct device *dev)
 
 static int ds2404_read_time(struct device *dev, struct rtc_time *dt)
 {
-	unsigned long time = 0;
+	unsigned long long time = 0;
 
 	ds2404_read_memory(dev, 0x203, 4, (u8 *)&time);
 	time = le32_to_cpu(time);
 
-	rtc_time_to_tm(time, dt);
+	rtc_time64_to_tm(time, dt);
 	return rtc_valid_tm(dt);
 }
 
-static int ds2404_set_mmss(struct device *dev, unsigned long secs)
+static int ds2404_set_mmss64(struct device *dev, time64_t secs)
 {
 	u32 time = cpu_to_le32(secs);
 	ds2404_write_memory(dev, 0x203, 4, (u8 *)&time);
@@ -219,7 +219,7 @@ static int ds2404_set_mmss(struct device *dev, unsigned long secs)
 
 static const struct rtc_class_ops ds2404_rtc_ops = {
 	.read_time	= ds2404_read_time,
-	.set_mmss	= ds2404_set_mmss,
+	.set_mmss64	= ds2404_set_mmss64,
 };
 
 static int rtc_probe(struct platform_device *pdev)
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
