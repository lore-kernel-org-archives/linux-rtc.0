Return-Path: <rtc-linux+bncBCMNZUWXYYORB6GMUOVQKGQEMSAUBBQ@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com. [209.85.192.174])
        by gmr-mx.google.com with ESMTPS id xz5si733492pac.1.2015.05.29.15.21.43
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2015 15:21:43 -0700 (PDT)
Received: by pdbqa5 with SMTP id qa5so62989784pdb.0
        for <rtc-linux@googlegroups.com>; Fri, 29 May 2015 15:21:43 -0700 (PDT)
From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	sameo@linux.intel.com,
	lee.jones@linaro.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [rtc-linux] [PATCH 0/4] Add Device tree support for 88PM800 mfd and
 rtc driver
Date: Sat, 30 May 2015 03:49:18 +0530
Message-Id: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

This patch-series adds support for Device tree to 88PM800 mfd and rtc driver.
It also creates the DT binding for 88pm800 driver.

Testing::
 - Boot tested on PXA1928 based platform.
 - probe of mfd, rtc and regulator function passing.


Attempt has been made to push some of the patches to the list sometime
back in 2013.

Link to previous patch submission:
        https://lkml.org/lkml/2013/8/14/86


Vaibhav Hiremath (4):
  mfd: 88pm800: add device tree support
  mfd: 88pm800: use irq_mode to configure interrupt status reg clear
    method
  rtc: 88pm80x: add device tree support
  mfd: 88pm800: allocate pdata->rtc if not allocated earlier

 Documentation/devicetree/bindings/mfd/88pm800.txt | 57 +++++++++++++++++++++
 drivers/mfd/88pm800.c                             | 62 ++++++++++++++++++++++-
 drivers/rtc/rtc-88pm80x.c                         | 28 ++++++----
 include/linux/mfd/88pm80x.h                       |  2 +
 4 files changed, 137 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt

-- 
1.9.1

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
