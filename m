Return-Path: <rtc-linux+bncBDIK5VOGT4GRBRPY3CYAKGQE5X6NIJI@googlegroups.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com. [119.145.14.65])
        by gmr-mx.google.com with ESMTPS id z7si163109igw.0.2015.10.08.02.49.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Oct 2015 02:49:57 -0700 (PDT)
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux
	<rtc-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
        "Tianhong
 Ding" <dingtianhong@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Zhen Lei
	<thunder.leizhen@huawei.com>
Subject: [rtc-linux] [PATCH 1/1] rtc: fix type information of rtc-proc
Date: Thu, 8 Oct 2015 17:47:32 +0800
Message-ID: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Display the whole word of "alarm", make it look more comfortable.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/rtc/rtc-proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index ffa69e1..ef83f34 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -58,7 +58,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)

 	err = rtc_read_alarm(rtc, &alrm);
 	if (err == 0) {
-		seq_printf(seq, "alrm_time\t: ");
+		seq_printf(seq, "alarm_time\t: ");
 		if ((unsigned int)alrm.time.tm_hour <= 24)
 			seq_printf(seq, "%02d:", alrm.time.tm_hour);
 		else
@@ -72,7 +72,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 		else
 			seq_printf(seq, "**\n");

-		seq_printf(seq, "alrm_date\t: ");
+		seq_printf(seq, "alarm_date\t: ");
 		if ((unsigned int)alrm.time.tm_year <= 200)
 			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
 		else
@@ -87,7 +87,7 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 			seq_printf(seq, "**\n");
 		seq_printf(seq, "alarm_IRQ\t: %s\n",
 				alrm.enabled ? "yes" : "no");
-		seq_printf(seq, "alrm_pending\t: %s\n",
+		seq_printf(seq, "alarm_pending\t: %s\n",
 				alrm.pending ? "yes" : "no");
 		seq_printf(seq, "update IRQ enabled\t: %s\n",
 			(rtc->uie_rtctimer.enabled) ? "yes" : "no");
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
