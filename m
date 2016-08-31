Return-Path: <rtc-linux+bncBDA7X7F2WUEBB3VETO7AKGQEW4JWW2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id w64si1149973wmf.3.2016.08.31.05.49.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 05:49:50 -0700 (PDT)
Received: by mail-wm0-x233.google.com with SMTP id c133so29004418wmd.1
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 05:49:50 -0700 (PDT)
Date: Wed, 31 Aug 2016 13:51:37 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Subject: [rtc-linux] [GIT PULL] Immutable branch between MFD, Regulator and
 RTC due for the v4.9 merge window
Message-ID: <20160831125137.GI9415@dell>
References: <1472468881-15337-1-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1472468881-15337-1-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Enjoy!

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d=
:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulato=
r-rtc-v4.9-1

for you to fetch changes up to 5d2fd5c79e169547fcd4bf363f96cc544fd3489e:

  rtc: Kconfig: Name RK818 in Kconfig for RTC_DRV_RK808 (2016-08-31 13:48:5=
7 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Regulator and RTC due for the v4.9 merge wind=
ow

----------------------------------------------------------------
Wadim Egorov (4):
      mfd: rk808: Add RK818 support
      regulator: rk808: Add regulator driver for RK818
      mfd: dt-bindings: Add RK818 device tree bindings document
      rtc: Kconfig: Name RK818 in Kconfig for RTC_DRV_RK808

 Documentation/devicetree/bindings/mfd/rk808.txt |  37 +++-
 drivers/mfd/Kconfig                             |   4 +-
 drivers/mfd/rk808.c                             | 226 ++++++++++++++++++++=
----
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 143 ++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 include/linux/mfd/rk808.h                       | 154 +++++++++++++++-
 7 files changed, 516 insertions(+), 56 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
