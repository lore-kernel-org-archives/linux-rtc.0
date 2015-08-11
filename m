Return-Path: <rtc-linux+bncBDEZ72H55YIBBR5YU6XAKGQEZL27RZY@googlegroups.com>
Received: from mailout3.samsung.com (mailout3.samsung.com. [203.254.224.33])
        by gmr-mx.google.com with ESMTPS id fy14si160714pdb.2.2015.08.11.04.28.07
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 04:28:07 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSX018EB16SXT10@mailout3.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 11 Aug 2015 20:28:04 +0900 (KST)
Message-id: <55C9DC45.4090102@samsung.com>
Date: Tue, 11 Aug 2015 20:28:05 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
To: rtc-linux@googlegroups.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com,
 =?UTF-8?B?Iuy1nOywrOyasC9TL1cgUGxhdGZvcm0gTGFiKERNQ+yXsCkvUzQo7ISg7J6EKS8=?=
 =?UTF-8?B?7IK87ISx7KCE7J6QIg==?= <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [rtc-linux] [PATCH 0/4] modify clock codes of rtc-s3c driver
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

This patchset modifies clock codes of rtc-s3c driver. Main change is to
fix the problem that alarm interrupt can't happen. Also there are some
fixes incluing cleanup.

Thanks.

----------------------------------------------------------------
Joonyoung Shim (4):
      rtc: s3c: add missing clk control
      rtc: s3c: remove unnecessary NULL assignment
      rtc: s3c: use unified functions for enable/disable of clk
      rtc: s3c: enable/disable clocks for alarm

 drivers/rtc/rtc-s3c.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

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
