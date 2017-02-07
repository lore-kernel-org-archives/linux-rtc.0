Return-Path: <rtc-linux+bncBCNJ5VGR4ANRBG4I47CAKGQERHYBZRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com. [192.185.66.3])
        by gmr-mx.google.com with ESMTPS id a17si98916itd.1.2017.02.07.04.56.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 04:56:58 -0800 (PST)
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
	by gateway20.websitewelcome.com (Postfix) with ESMTP id 6FC2F400D60AB
	for <rtc-linux@googlegroups.com>; Tue,  7 Feb 2017 06:56:58 -0600 (CST)
From: Guy Shapiro <guy.shapiro@mobi-wize.com>
To: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH 0/2] imx: Fix power-up on RTC alarm
Date: Tue,  7 Feb 2017 14:54:12 +0200
Message-Id: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Currently, the syscon-poweroff driver cleans the alarm enable bit during power
off. This behaviour makes it impossible to wake up the device using the RTC.

The first patch adds a mask option to the syscon-poweroff driver. It uses the
method suggested by Sebastian Reichel [0] to maintain compatibility with the
old binding.

The second patch update the device trees for the snvs component users.
Although I believe this should work on all the modified devices, I had only
imx6ul to test with.

Making the wake-up alarm work may require applying another patch [1], already
accepted to the rtc-snvs driver. 

Thanks,
Guy.

[0] http://www.spinics.net/lists/devicetree/msg161527.html
[1] https://patchwork.ozlabs.org/patch/721155/

Guy Shapiro (2):
  power: reset: syscon-poweroff: add a mask property
  ARM: dts: imx: update snvs-poweroff mask

 .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi                        |  1 +
 arch/arm/boot/dts/imx6sl.dtsi                         |  1 +
 arch/arm/boot/dts/imx6sx.dtsi                         |  1 +
 arch/arm/boot/dts/imx6ul.dtsi                         |  1 +
 arch/arm/boot/dts/imx7s.dtsi                          |  1 +
 drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
 7 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
