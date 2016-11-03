Return-Path: <rtc-linux+bncBDAYD2P3QYGRBS4T5XAAKGQEMKJO5JA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id g142si2832038wmd.2.2016.11.03.07.29.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2016 07:29:30 -0700 (PDT)
Received: by mail-wm0-x230.google.com with SMTP id n67so104738282wme.1
        for <rtc-linux@googlegroups.com>; Thu, 03 Nov 2016 07:29:30 -0700 (PDT)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com,
	carlo@caione.org,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	rtc-linux@googlegroups.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for system suspend
Date: Thu,  3 Nov 2016 15:29:22 +0100
Message-Id: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Thie patchset is a very experiment patchset to support the System Suspend
feature of the Amlogic Meson GX SoCs.

These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
parameter to enter system suspend.
A small driver is added to properly fill the platform_suspend_ops and make
to correct SMC call.

In order to wake up from an alarm, these SoCs have a special memory mapped
register where an alarm time delay in seconds is stored.
In order to reuse the RTC wakealarm feature, implement a fake RTC device
that uses the system time to calculate a delay to write to the register.

Note that this RFC is here to seek a better way to handle these platform
specific features.

Neil Armstrong (3):
  ARM64: meson: Add Amlogic Meson GX PM Suspend
  rtc: Add Amlogic Virtual Wake RTC
  ARM64: dts: meson-gxbb: Add support for PM and Virtual RTC

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   9 ++
 drivers/firmware/meson/Kconfig              |   6 +
 drivers/firmware/meson/Makefile             |   1 +
 drivers/firmware/meson/meson_gx_pm.c        |  86 +++++++++++++++
 drivers/rtc/Kconfig                         |  10 ++
 drivers/rtc/Makefile                        |   1 +
 drivers/rtc/rtc-meson-vrtc.c                | 164 ++++++++++++++++++++++++++++
 7 files changed, 277 insertions(+)
 create mode 100644 drivers/firmware/meson/meson_gx_pm.c
 create mode 100644 drivers/rtc/rtc-meson-vrtc.c

-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
