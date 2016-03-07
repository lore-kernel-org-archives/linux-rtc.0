Return-Path: <rtc-linux+bncBCSJ7B6JQALRBR5Q623AKGQEJGU3AWQ@googlegroups.com>
MIME-Version: 1.0
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id i133si999195ywe.7.2016.03.07.07.03.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2016 07:03:35 -0800 (PST)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joshua Kinard <kumba@gentoo.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [rtc-linux] [PATCH] rtc: ds1685: actually spin forever in poweroff
 error path
Date: Mon,  7 Mar 2016 09:03:02 -0600
Message-Id: <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
In-Reply-To: <201603060005.PHCyifJr%fengguang.wu@intel.com>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
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

objtool reports the following warnings:

  drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: duplicate frame pointer save
  drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x3: duplicate frame pointer setup
  drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: frame pointer state mismatch

The warning message needs to be improved, but what it really means in
this case is that ds1685_rtc_poweroff() has a possible code path where
it can actually fall through to the next function in the object code,
ds1685_rtc_work_queue().

The bug is caused by the use of the unreachable() macro in a place which
is actually reachable.  That causes gcc to assume that the printk()
immediately before the unreachable() macro never returns, when in fact
it does.  So gcc places the printk() at the very end of the function's
object code.  When the printk() returns, the next function starts
executing.

The surrounding comment and printk message state that the code should
spin forever, which explains the unreachable() statement.  However the
actual spin code is missing.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 drivers/rtc/rtc-ds1685.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 08e0ff8..1e6cfc8 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -2161,6 +2161,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 	/* Check for valid RTC data, else, spin forever. */
 	if (unlikely(!pdev)) {
 		pr_emerg("platform device data not available, spinning forever ...\n");
+		while(1);
 		unreachable();
 	} else {
 		/* Get the rtc data. */
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
