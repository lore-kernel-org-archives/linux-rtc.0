Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXGEZSZAKGQEO43YOMA@googlegroups.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id r194si518650wmb.0.2015.11.23.06.27.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2015 06:27:40 -0800 (PST)
Received: by mail-wm0-x233.google.com with SMTP id c201so160118640wme.0
        for <rtc-linux@googlegroups.com>; Mon, 23 Nov 2015 06:27:40 -0800 (PST)
Date: Mon, 23 Nov 2015 14:27:37 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: broonie@kernel.org, k.kozlowski@samsung.com,
	alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND PATCH v5 0/3] mfd: sec: add S2MPS15 PMIC support
Message-ID: <20151123142737.GK3098@x1>
References: <1448015873-8743-1-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448015873-8743-1-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Mark, Alexandre,

Enjoy!

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4=
:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-reg=
ulator-rtc-v4.5

for you to fetch changes up to a65e5efa7c5faa8c320fe56cc351d47fcd006749:

  rtc: s5m.c: Add support for S2MPS15 RTC (2015-11-23 10:34:38 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and RTC for the v4.5 merge window

----------------------------------------------------------------
Alim Akhtar (1):
      rtc: s5m.c: Add support for S2MPS15 RTC

Thomas Abraham (2):
      mfd: sec: Add support for S2MPS15 PMIC
      regulator: s2mps11: Add support for S2MPS15 regulators

 drivers/mfd/sec-core.c              |  31 +++++
 drivers/mfd/sec-irq.c               |   8 ++
 drivers/regulator/Kconfig           |   4 +-
 drivers/regulator/s2mps11.c         | 135 +++++++++++++++++-
 drivers/rtc/rtc-s5m.c               |  37 ++++-
 include/linux/mfd/samsung/core.h    |   1 +
 include/linux/mfd/samsung/rtc.h     |   2 +
 include/linux/mfd/samsung/s2mps15.h | 158 ++++++++++++++++++++++
 8 files changed, 369 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/mfd/samsung/s2mps15.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
