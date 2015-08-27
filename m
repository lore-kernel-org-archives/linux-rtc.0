Return-Path: <rtc-linux+bncBAABBQ6P7OXAKGQEAWQUG6Y@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id zt8si265325pbc.0.2015.08.27.03.34.43
        for <rtc-linux@googlegroups.com>;
        Thu, 27 Aug 2015 03:34:43 -0700 (PDT)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Luis de Bethencourt <luis.bg@samsung.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Sangbeom Kim <sbkim73@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	rtc-linux@googlegroups.com,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH] rtc: Fix module autoload for rtc-{ab8500,max8997,s5m}
 drivers
Date: Thu, 27 Aug 2015 12:34:32 +0200
Message-Id: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
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

These platform drivers have a platform device ID table but the module
alias information is not created so module autoloading will not work.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-ab8500.c  | 1 +
 drivers/rtc/rtc-max8997.c | 1 +
 drivers/rtc/rtc-s5m.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 133d2e2e1a25..8537d1e3a995 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -446,6 +446,7 @@ static const struct platform_device_id ab85xx_rtc_ids[] = {
 	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
 	{ "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },
 };
+MODULE_DEVICE_TABLE(platform, ab85xx_rtc_ids);
 
 static int ab8500_rtc_probe(struct platform_device *pdev)
 {
diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 9e02bcda0c09..db984d4bf952 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -521,6 +521,7 @@ static const struct platform_device_id rtc_id[] = {
 	{ "max8997-rtc", 0 },
 	{},
 };
+MODULE_DEVICE_TABLE(platform, rtc_id);
 
 static struct platform_driver max8997_rtc_driver = {
 	.driver		= {
diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index ab60287ee72d..f2504b4eef34 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -807,6 +807,7 @@ static const struct platform_device_id s5m_rtc_id[] = {
 	{ "s2mps14-rtc",	S2MPS14X },
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, s5m_rtc_id);
 
 static struct platform_driver s5m_rtc_driver = {
 	.driver		= {
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
