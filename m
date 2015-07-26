Return-Path: <rtc-linux+bncBD5O5IWPJMILZJWVVUCRUBBEWYCMC@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id ec7si262327wib.3.2015.07.26.14.38.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:38:03 -0700 (PDT)
Received: by wicmv11 with SMTP id mv11so117146085wic.0
        for <rtc-linux@googlegroups.com>; Sun, 26 Jul 2015 14:38:03 -0700 (PDT)
From: Philippe Reynes <tremyfr@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	shawn.guo@linaro.org,
	kernel@pengutronix.de,
	linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Philippe Reynes <tremyfr@gmail.com>
Subject: [rtc-linux] [PATCH v5 0/6] add device tree support for mxc rtc
Date: Sun, 26 Jul 2015 23:37:47 +0200
Message-Id: <1437946673-7402-1-git-send-email-tremyfr@gmail.com>
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

This serie add the device tree support for the mxc rtc driver.
To do this, three steps are required :
- define two rtc clocks for imx31 and imx35
- enhance mxc rtc driver to use two clocks (ref and ipg)
- add device tree support to mxc rtc driver

Changelog:
v5: (thanks Shawn Guo, Rob Herring and Alexandre Belloni)
- rename rtc clock to ref
- fix typo in binding documentation
- enable rtc by default on imx27
v4: (thanks Alexandre Belloni)
- add prepare_clock for rtc clock
- split apf27: dt: enable support in two patches
v3: (thanks Fabio Estevam)
- fix typo in imx35 clock comment
v2: (thanks Shawn Guo and Alexandre Belloni)
- add a second clock to imx35
- split the add of clock in a separate patches
- split the dt documentation in a separate patch

Philippe Reynes (6):
  imx31: add a second rtc clock
  imx35: define two clocks for rtc
  rtc: mxc: use a second rtc clock
  dt-binding: document the binding for mxc rtc
  rtc: mxc: add support of device tree
  imx27: dt: add support of internal rtc

 Documentation/devicetree/bindings/rtc/rtc-mxc.txt |   26 +++++++++
 arch/arm/boot/dts/imx27.dtsi                      |    9 +++
 drivers/clk/imx/clk-imx31.c                       |    3 +-
 drivers/clk/imx/clk-imx35.c                       |    6 ++-
 drivers/rtc/rtc-mxc.c                             |   60 ++++++++++++++++-----
 5 files changed, 88 insertions(+), 16 deletions(-)
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
