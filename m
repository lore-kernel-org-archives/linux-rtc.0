Return-Path: <rtc-linux+bncBCSJFY6GXEGBB67EZ65AKGQEUSHXGLY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mx2.suse.de (mx2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id l184si253658wmg.2.2016.06.05.02.35.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 05 Jun 2016 02:35:55 -0700 (PDT)
From: Alexander Graf <agraf@suse.de>
To: rtc-linux@googlegroups.com
Cc: leif.lindholm@linaro.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [rtc-linux] [PATCH] rtc: efi: Fail probing if RTC reads don't work
Date: Sun,  5 Jun 2016 11:35:56 +0200
Message-Id: <1465119356-129799-1-git-send-email-agraf@suse.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

While the EFI spec mandates an RTC, not every implementation actually adheres
to that rule (or can adhere to it - some systems just don't have an RTC).

For those, we really don't want to probe the EFI RTC driver at all, because if
we do we'd get a non-functional driver that does nothing useful but only spills
our kernel log with warnings.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 drivers/rtc/rtc-efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 96d3860..0130afd 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -259,6 +259,12 @@ static const struct rtc_class_ops efi_rtc_ops = {
 static int __init efi_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
+	efi_time_t eft;
+	efi_time_cap_t cap;
+
+	/* First check if the RTC is usable */
+	if (efi.get_time(&eft, &cap) != EFI_SUCCESS)
+		return -ENODEV;
 
 	rtc = devm_rtc_device_register(&dev->dev, "rtc-efi", &efi_rtc_ops,
 					THIS_MODULE);
-- 
1.8.5.6

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
