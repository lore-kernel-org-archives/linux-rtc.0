Return-Path: <rtc-linux+bncBDE6RCFOWIARBR7UYC5AKGQESXPJAUQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-lf0-x22d.google.com (mail-lf0-x22d.google.com. [2a00:1450:4010:c07::22d])
        by gmr-mx.google.com with ESMTPS id u7si14315lbo.3.2016.06.02.06.53.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2016 06:53:11 -0700 (PDT)
Received: by mail-lf0-x22d.google.com with SMTP id b73so34421354lfb.3
        for <rtc-linux@googlegroups.com>; Thu, 02 Jun 2016 06:53:11 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Linus Walleij <linus.walleij@linaro.org>,
	stable@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [rtc-linux] [PATCH] rtc: ab8500: move device_init_wakeup() call
Date: Thu,  2 Jun 2016 15:53:04 +0200
Message-Id: <1464875584-31505-1-git-send-email-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

commit 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
introduced the dev_pm_set_wake_irq() call to register a wake
IRQ for the AB8500 driver.

However this causes a regression since device_init_wakeup() must be
called *after* dev_pm_set_wake_irq() not *before* it. Before this
patch we get an error message like this during system resume from
sleep:

[  217.585571] PM: noirq resume of devices complete after 0.762 msecs
[  217.585815] ------------[ cut here ]------------
[  217.585845] WARNING: CPU: 0 PID: 200 at ../kernel/irq/manage.c:603 irq_set_irq_wake+0xc4/0xf8
[  217.585845] Unbalanced IRQ 396 wake disable
[  217.585845] Modules linked in:
[  217.585876] CPU: 0 PID: 200 Comm: sh Tainted: G        W       4.6.0-rc1-00010-gc6ade5a1da15-dirty #123
[  217.585876] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[  217.585906] [<c010e81c>] (unwind_backtrace) from [<c010b1b4>] (show_stack+0x10/0x14)
[  217.585937] [<c010b1b4>] (show_stack) from [<c034a150>] (dump_stack+0x8c/0xa0)
[  217.585937] [<c034a150>] (dump_stack) from [<c0121138>] (__warn+0xe8/0x100)
[  217.585937] [<c0121138>] (__warn) from [<c0121188>] (warn_slowpath_fmt+0x38/0x48)
[  217.585967] [<c0121188>] (warn_slowpath_fmt) from [<c0164f84>] (irq_set_irq_wake+0xc4/0xf8)
[  217.585967] [<c0164f84>] (irq_set_irq_wake) from [<c03c3648>] (device_wakeup_disarm_wake_irqs+0x30/0x48)
[  217.585998] [<c03c3648>] (device_wakeup_disarm_wake_irqs) from [<c03c152c>] (dpm_resume_noirq+0x208/0x21c)
[  217.585998] [<c03c152c>] (dpm_resume_noirq) from [<c0160248>] (suspend_devices_and_enter+0x1dc/0x444)
[  217.585998] [<c0160248>] (suspend_devices_and_enter) from [<c01606ac>] (pm_suspend+0x1fc/0x25c)
[  217.585998] [<c01606ac>] (pm_suspend) from [<c015f420>] (state_store+0x68/0xb8)
[  217.586029] [<c015f420>] (state_store) from [<c0266758>] (kernfs_fop_write+0xb8/0x1b4)
[  217.586029] [<c0266758>] (kernfs_fop_write) from [<c0204978>] (__vfs_write+0x1c/0xd8)
[  217.586059] [<c0204978>] (__vfs_write) from [<c02057fc>] (vfs_write+0x90/0x19c)
[  217.586059] [<c02057fc>] (vfs_write) from [<c02067a0>] (SyS_write+0x44/0x9c)
[  217.586059] [<c02067a0>] (SyS_write) from [<c0107740>] (ret_fast_syscall+0x0/0x3c)
[  217.586090] ---[ end trace 78c75240315212f4 ]---

This patch fixes it.

Cc: stable@vger.kernel.org
Fixes: 93a6f9168f2f ("rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag")
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/rtc/rtc-ab8500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 24a0af650a1b..5e9cb4132eb1 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -482,8 +482,6 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-
 	rtc = devm_rtc_device_register(&pdev->dev, "ab8500-rtc",
 				(struct rtc_class_ops *)platid->driver_data,
 				THIS_MODULE);
@@ -500,6 +498,8 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 		return err;
 
 	dev_pm_set_wake_irq(&pdev->dev, irq);
+	device_init_wakeup(&pdev->dev, true);
+
 	platform_set_drvdata(pdev, rtc);
 
 	err = ab8500_sysfs_rtc_register(&pdev->dev);
-- 
2.4.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
