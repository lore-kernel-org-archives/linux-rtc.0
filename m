Return-Path: <rtc-linux+bncBD5O5IWPJMIL52OZVICRUBGH5PZ72@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com. [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id ec7si1412wib.3.2015.05.15.15.35.41
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 15:35:41 -0700 (PDT)
Received: by mail-wg0-x232.google.com with SMTP id v19so67114684wgu.1
        for <rtc-linux@googlegroups.com>; Fri, 15 May 2015 15:35:41 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk,
	a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	rtc-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	fabio.estevam@freescale.com,
	Philippe Reynes <tremyfr@gmail.com>
Subject: [rtc-linux] [PATCH 0/2] add dt support for mxc rtc
Date: Sat, 16 May 2015 00:35:28 +0200
Message-Id: <1431729330-7625-1-git-send-email-tremyfr@gmail.com>
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

This patch set add the device tree support for
the rtc driver on mxc.

Philippe Reynes (2):
  rtc: mxc: add a second clock
  rtc: mxc: add support of device tree

 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   27 ++++++++++++
 arch/arm/mach-imx/clk-imx31.c                     |    3 +-
 drivers/rtc/rtc-mxc.c                             |   48 ++++++++++++++++----
 3 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt

-- 
1.7.4.4

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
