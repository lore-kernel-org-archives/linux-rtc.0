Return-Path: <rtc-linux+bncBCSJ7B6JQALRB3HRYO4AKGQEAYDQDNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id w74si3007353ywd.0.2016.04.15.07.21.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2016 07:21:32 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joshua Kinard <kumba@gentoo.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: ds1685: actually spin forever in poweroff
 path, part 2
Date: Fri, 15 Apr 2016 09:21:10 -0500
Message-Id: <97e46f7b50b413d01be4189159c0611515ef7502.1460729962.git.jpoimboe@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

objtool reports the following warning:

  drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_poweroff() falls through to next function ds1685_rtc_work_queue()

Similar to commit 361c6ed6b153 ("rtc: ds1685: actually spin forever in
poweroff error path"), there's another unreachable() annotation which is
actually reachable, which we missed the first time.

Actually spin forever to be consistent with the comment and to make the
unreachable() annotation guaranteed to be unreachable.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 drivers/rtc/rtc-ds1685.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 1e6cfc8..0255808 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -2213,6 +2213,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 			   (ctrl4a | RTC_CTRL_4A_PAB));
 
 		/* Spin ... we do not switch back to bank0. */
+		while(1);
 		unreachable();
 	}
 }
-- 
2.4.11

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
