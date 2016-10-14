Return-Path: <rtc-linux+bncBAABBAVVQPAAKGQEJT42BMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from s-opensource.com (ec2-52-27-115-49.us-west-2.compute.amazonaws.com. [52.27.115.49])
        by gmr-mx.google.com with ESMTP id 203si3223021pfw.0.2016.10.14.06.15.45
        for <rtc-linux@googlegroups.com>;
        Fri, 14 Oct 2016 06:15:45 -0700 (PDT)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH] rtc: asm9260: fix module autoload
Date: Fri, 14 Oct 2016 10:15:35 -0300
Message-Id: <1476450935-19105-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If the driver is built as a module, autoload won't work because the module
alias information is not filled so user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/rtc/rtc-asm9260.ko | grep alias
$

After this patch:

$ modinfo drivers/rtc/rtc-asm9260.ko | grep alias
alias:          of:N*T*Calphascale,asm9260-rtcC*
alias:          of:N*T*Calphascale,asm9260-rtc

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/rtc/rtc-asm9260.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 18a93d3e3f93..d36534965635 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -327,6 +327,7 @@ static const struct of_device_id asm9260_dt_ids[] = {
 	{ .compatible = "alphascale,asm9260-rtc", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, asm9260_dt_ids);
 
 static struct platform_driver asm9260_rtc_driver = {
 	.probe		= asm9260_rtc_probe,
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
