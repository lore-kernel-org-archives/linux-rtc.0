Return-Path: <rtc-linux+bncBDKZNNNLXAHBBFV7R2VAKGQERCWODEI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com. [2607:f8b0:400e:c03::236])
        by gmr-mx.google.com with ESMTPS id xv6si560761pab.2.2015.05.01.08.45.26
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 08:45:26 -0700 (PDT)
Received: by mail-pa0-x236.google.com with SMTP id yx8so93989817pac.1
        for <rtc-linux@googlegroups.com>; Fri, 01 May 2015 08:45:26 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [rtc-linux] [PATCH 3/3] rtc: mxc: Constify platform_device_id
Date: Sat,  2 May 2015 00:44:37 +0900
Message-Id: <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
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

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/rtc/rtc-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 09d422b9f7f7..5fc292c2dfdf 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -84,7 +84,7 @@ struct rtc_plat_data {
 	enum imx_rtc_type devtype;
 };
 
-static struct platform_device_id imx_rtc_devtype[] = {
+static const struct platform_device_id imx_rtc_devtype[] = {
 	{
 		.name = "imx1-rtc",
 		.driver_data = IMX1_RTC,
-- 
2.1.4

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
