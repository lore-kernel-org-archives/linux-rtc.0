Return-Path: <rtc-linux+bncBD747RFBYUPBBEEF5G5QKGQEWJBND4A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id ph9si357026pac.1.2016.07.04.04.03.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jul 2016 04:03:44 -0700 (PDT)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9S00IPVEQ6X570@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Mon, 04 Jul 2016 20:03:42 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc: alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
 javier@osg.samsung.com, pankaj.dubey@samsung.com, alim.akhtar@samsung.com
Subject: [rtc-linux] [RFC PATCH 2/2] rtc: s3c: Add s3c_rtc_{enable/disable}_clk
 in s3c_rtc_setfreq()
Date: Mon, 04 Jul 2016 16:33:14 +0530
Message-id: <1467630195-6929-2-git-send-email-alim.akhtar@samsung.com>
In-reply-to: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
References: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

As per code flow it is possible that s3c_rtc_setfreq() might get called
with rtc clock disabled and in set_freq we perform h/w registers read/write,
which might results in a kernel crash while probing rtc driver.
Below is one such case:
s3c_rtc_probe()
    clk_prepare_enable(info->rtc_clk) // rtc clock enabled
      s3c_rtc_gettime() // will enable clk if not done, and disable it upon exit
        s3c_rtc_setfreq() //then this will be called with clk disabled

This patch take cares of such issue by adding s3c_rtc_{enable/disable}_clk in
s3c_rtc_setfreq().

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/rtc/rtc-s3c.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index b083840..1168814 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -149,12 +149,14 @@ static int s3c_rtc_setfreq(struct s3c_rtc *info, int freq)
 	if (!is_power_of_2(freq))
 		return -EINVAL;
 
+	s3c_rtc_enable_clk(info);
 	spin_lock_irq(&info->pie_lock);
 
 	if (info->data->set_freq)
 		info->data->set_freq(info, freq);
 
 	spin_unlock_irq(&info->pie_lock);
+	s3c_rtc_disable_clk(info);
 
 	return 0;
 }
-- 
1.7.10.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
