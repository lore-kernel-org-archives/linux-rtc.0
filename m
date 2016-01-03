Return-Path: <rtc-linux+bncBCOML4NU3EDRBMV6UO2AKGQEY5WIRXQ@googlegroups.com>
Received: from mout.web.de (mout.web.de. [212.227.17.12])
        by gmr-mx.google.com with ESMTPS id s132si994097wmd.1.2016.01.03.00.43.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 00:43:30 -0800 (PST)
Subject: [rtc-linux] [PATCH 0/8] rtc-ab-b5ze-s3: Fine-tuning for some function implementations
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
To: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688DF2D.6090204@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:43:25 +0100
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 09:37:34 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (8):
  Better exception handling in abb5zes3_probe()
  Delete an unnecessary variable in abb5zes3_rtc_set_alarm()
  Delete an unnecessary variable initialisation in _abb5zes3_rtc_set_timer()
  Replace a variable initialisation by an assignment in _abb5zes3_rtc_set_alarm()
  Replace a variable initialisation by an assignment in _abb5zes3_rtc_read_alarm()
  Delete an unnecessary variable in _abb5zes3_rtc_read_timer()
  Delete an unnecessary variable in _abb5zes3_rtc_interrupt()
  Delete an unnecessary variable in _abb5zes3_rtc_set_timer()

 drivers/rtc/rtc-ab-b5ze-s3.c | 59 ++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

-- 
2.6.3

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
