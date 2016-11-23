Return-Path: <rtc-linux+bncBAABBK5T2XAQKGQEJPRVTCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from relay1.mentorg.com (relay1.mentorg.com. [192.94.38.131])
        by gmr-mx.google.com with ESMTPS id n18si597450pfb.2.2016.11.23.00.56.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2016 00:56:11 -0800 (PST)
From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Alessandro Zummo <a.zummo@towertech.it>, <rtc-linux@googlegroups.com>,
	<linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nicolae Rosia
	<Nicolae_Rosia@mentor.com>
Subject: [rtc-linux] [PATCH v2 0/2] rtc: rtc-twl: cleanup
Date: Wed, 23 Nov 2016 10:55:55 +0200
Message-ID: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
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

v2:
- dropped patch "rtc: rtc-twl: use irq_of_parse_and_map helper"
- fixed style problems
- retained old logic of checking TWL class by introducing an enum
- dropped of_match_ptr since we depend on OF

v1 was Tested-by: Tony Lindgren <tony@atomide.com>
I did not add it in new version of patches because of the changes.
If you consider that the changes are not big, you could add Tony's Tested-by.

Nicolae Rosia (2):
  rtc: rtc-twl: kill static variables
  rtc: rtc-twl: make driver DT only

 drivers/rtc/Kconfig   |   1 +
 drivers/rtc/rtc-twl.c | 202 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 122 insertions(+), 81 deletions(-)

-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
