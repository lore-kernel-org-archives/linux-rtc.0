Return-Path: <rtc-linux+bncBD747RFBYUPBBTPPXOZAKGQEUFXYQUA@googlegroups.com>
MIME-Version: 1.0
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id 70si39781pfr.1.2015.11.20.02.37.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 20 Nov 2015 02:37:01 -0800 (PST)
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NY401OIO05MQGD0@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 20 Nov 2015 19:36:58 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: lee.jones@linaro.org, broonie@kernel.org
Cc: k.kozlowski@samsung.com, alexandre.belloni@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, alim.akhtar@samsung.com
Subject: [rtc-linux] [RESEND PATCH v5 0/3] mfd: sec: add S2MPS15 PMIC support
Date: Fri, 20 Nov 2015 16:07:50 +0530
Message-id: <1448015873-8743-1-git-send-email-alim.akhtar@samsung.com>
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

Hi Lee/Mark,

This a resend of series [0] that adds s2mps15 pmic support.
These patches have no changes, just collected some Reviewed-by and Acked-by tags.
[0] -> https://lkml.org/lkml/2015/10/30/44

Mark,
Can I have you acked-by for patch# 2/3? so that these can go in via MFD tree.

Alim Akhtar (1):
  drivers/rtc/rtc-s5m.c: add support for S2MPS15 RTC

Thomas Abraham (2):
  mfd: sec: Add support for S2MPS15 PMIC
  regulator: s2mps11: add support for S2MPS15 regulators

 drivers/mfd/sec-core.c              |   31 +++++++
 drivers/mfd/sec-irq.c               |    8 ++
 drivers/regulator/Kconfig           |    4 +-
 drivers/regulator/s2mps11.c         |  135 +++++++++++++++++++++++++++++-
 drivers/rtc/rtc-s5m.c               |   37 +++++++-
 include/linux/mfd/samsung/core.h    |    1 +
 include/linux/mfd/samsung/rtc.h     |    2 +
 include/linux/mfd/samsung/s2mps15.h |  158 +++++++++++++++++++++++++++++++++++
 8 files changed, 369 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/mfd/samsung/s2mps15.h

-- 
1.7.10.4


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
