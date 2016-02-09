Return-Path: <rtc-linux+bncBAABBL4R462QKGQEFLC74LI@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 12si4598425pfb.1.2016.02.09.03.08.30
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Feb 2016 03:08:30 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-mediatek@lists.infradead.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH] rtc: mt6397: Add platform device ID table
Date: Tue,  9 Feb 2016 08:08:14 -0300
Message-Id: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The platform bus_type .match callback attempts to match the platform device
name with an entry on the .id_table if provided and fallbacks to match with
the driver's name if a table is not provided.

Using a platform device ID to match is more explicit, allows the driver to
support more than one device and also the MODULE_DEVICE_TABLE macro can be
used to export the module aliases information instead of the MODULE_ALIAS.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/rtc/rtc-mt6397.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 06a5c52b292f..46533f11f7fc 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -404,6 +404,12 @@ static const struct of_device_id mt6397_rtc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mt6397_rtc_of_match);
 
+static const struct platform_device_id mt6397_rtc_id[] = {
+	{"mt6397-rtc", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6397_rtc_id);
+
 static struct platform_driver mtk_rtc_driver = {
 	.driver = {
 		.name = "mt6397-rtc",
@@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
 	},
 	.probe	= mtk_rtc_probe,
 	.remove = mtk_rtc_remove,
+	.id_table = mt6397_rtc_id,
 };
 
 module_platform_driver(mtk_rtc_driver);
@@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
 MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
-MODULE_ALIAS("platform:mt6397-rtc");
-- 
2.5.0

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
