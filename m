Return-Path: <rtc-linux+bncBD747RFBYUPBBVGOY2YQKGQEK7XJJGQ@googlegroups.com>
MIME-Version: 1.0
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id iz5si428773pbc.2.2015.10.28.21.57.56
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 21:57:56 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWY015ZHTSIU240@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 29 Oct 2015 13:57:54 +0900 (KST)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: lee.jones@linaro.org, broonie@kernel.org
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH v4 0/4] mfd: sec: add S2MPS15 PMIC support
Date: Thu, 29 Oct 2015 10:28:37 +0530
Message-id: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
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

Samsung's S2MPS15 PMIC is targetted to be used with Samsung's Exynos7 SoC.
The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It contains
27 LDO and 10 Buck regulators, RTC, three 32.768 KHz clock outputs and allows
programming these blocks via a I2C interface. This patch series adds initial
support for LDO/Buck regulators of S2MPS15 PMIC.

Changes since v3:
* Changes regulator driver name from s2mps15-pmic -> s2mps15-regulator as disscussed here [2]
* Re-use the exsisting compatible/names for s2mps15 clock block.

Changes since v2:
* Addressed Lee Jones review comments.

Changes since v1:
* Added suggestion from Krzysztof [1].
* Added s2mps15's 32.768 clocks support.
* Added s2mps15's rtc support.

V1 of these patches (with a lesser features) were posted a year back,
since then there is not much progress on this, this is my attempt to
move things forward.

[1]-> https://lkml.org/lkml/2014/10/14/67
[2]-> https://lkml.org/lkml/2015/10/28/417

This series is based on linux-next-20151022.
This is tested on exynos7-espresso board.


Alim Akhtar (1):
  drivers/rtc/rtc-s5m.c: add support for S2MPS15 RTC

Thomas Abraham (3):
  dt-bindings: mfd: s2mps11: add documentation for s2mps15 PMIC
  mfd: sec: Add support for S2MPS15 PMIC
  regulator: s2mps11: add support for S2MPS15 regulators

 Documentation/devicetree/bindings/mfd/s2mps11.txt |   23 +--
 drivers/mfd/sec-core.c                            |   31 ++++
 drivers/mfd/sec-irq.c                             |    8 ++
 drivers/regulator/Kconfig                         |    4 +-
 drivers/regulator/s2mps11.c                       |  135 +++++++++++++++++-
 drivers/rtc/rtc-s5m.c                             |   20 ++-
 include/linux/mfd/samsung/core.h                  |    1 +
 include/linux/mfd/samsung/rtc.h                   |    4 +
 include/linux/mfd/samsung/s2mps15.h               |  158 +++++++++++++++++++++
 9 files changed, 371 insertions(+), 13 deletions(-)
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
