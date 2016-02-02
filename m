Return-Path: <rtc-linux+bncBDQJZJXU2UMBB2ETYS2QKGQESVBDKYY@googlegroups.com>
MIME-Version: 1.0
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id w10si16516wmw.3.2016.02.02.11.56.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 11:56:24 -0800 (PST)
From: Oleksij Rempel <linux@rempel-privat.de>
To: devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] [PATCH v2 0/2] add Alphascale asm9260 RTC driver
Date: Tue,  2 Feb 2016 20:56:09 +0100
Message-Id: <1454442971-25225-1-git-send-email-linux@rempel-privat.de>
In-Reply-To: <20160202102804.GT20165@piout.net>
References: <20160202102804.GT20165@piout.net>
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

This patch set provide support for RTC controller found on Alphascale
ASM9260 SoC.

v2:
- change license to GPLv2 and later
- remove HW_RTC_AUX and HW_RTC_AUXEN. Thay was taken from reference driver.
  Documentation do not provide any info about it. According to my tests
  this regs are not available on asm9260.
- remove calibration from DT. It will be beter to set it over sysfs.

Oleksij Rempel (2):
  rtc: add rtc-asm9260 driver
  doc: dt: add documentation for alphascale,asm9260-rtc

 .../bindings/rtc/alphascale,asm9260-rtc.txt        |  19 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-asm9260.c                          | 355 +++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/alphascale,asm9260-rtc.txt
 create mode 100644 drivers/rtc/rtc-asm9260.c

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
