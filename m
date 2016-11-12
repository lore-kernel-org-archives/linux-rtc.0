Return-Path: <rtc-linux+bncBAABB4GTTPAQKGQEWNEGIHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relay1.mentorg.com (relay1.mentorg.com. [192.94.38.131])
        by gmr-mx.google.com with ESMTPS id g192si4046940pfb.1.2016.11.12.02.07.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2016 02:07:44 -0800 (PST)
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
CC: <rtc-linux@googlegroups.com>, <linux-omap@vger.kernel.org>, Tony Lindgren
	<tony@atomide.com>, Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] [PATCH 0/3] rtc: rtc-twl: cleanup
Date: Sat, 12 Nov 2016 12:07:23 +0200
Message-ID: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is a cleanup and preparation of rtc-twl to reduce the usage of
twl-core exported functions.
The next patch series will further reduce the usage of exported functions
but first it requires some changes in mfd/twl-core.c

Nicolae Rosia (3):
  rtc: rtc-twl: kill static variables
  rtc: rtc-twl: make driver DT only
  rtc: rtc-twl: use irq_of_parse_and_map helper

 drivers/rtc/Kconfig   |   1 +
 drivers/rtc/rtc-twl.c | 191 +++++++++++++++++++++++++++++---------------------
 2 files changed, 114 insertions(+), 78 deletions(-)

-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
