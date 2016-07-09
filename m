Return-Path: <rtc-linux+bncBAABBRU3QO6AKGQE52YB54A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from kozue.soulik.info (kozue.soulik.info. [108.61.200.231])
        by gmr-mx.google.com with ESMTPS id i135si215606pfe.0.2016.07.09.02.24.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jul 2016 02:24:08 -0700 (PDT)
From: Randy Li <ayaka@soulik.info>
To: k.kozlowski@samsung.com
Cc: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Randy Li <ayaka@soulik.info>
Subject: [rtc-linux] [PATCH 0/3] making rtc cores from s3c6410 and exynos3250
 both work
Date: Sat,  9 Jul 2016 17:23:43 +0800
Message-Id: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The 8792f7772f4f40ffc68bad5f28311205584b734d would just make those
platform using rtc core from exynos3250 work but have a huge 
effect on those platforms using the rtc core from s3c6410.
These patches would fix this problem.

Randy Li (3):
  Revert "drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data"
  rtc: s3c: add device data for samsung,exynos3250-rtc
  ARM: dts: exynos: correct the rtc compatible value for exynos5

 arch/arm/boot/dts/exynos3250.dtsi |  2 +-
 arch/arm/boot/dts/exynos5.dtsi    |  2 +-
 drivers/rtc/rtc-s3c.c             | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
