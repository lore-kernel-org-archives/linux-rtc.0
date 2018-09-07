Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44246 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHASH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Sep 2018 20:18:07 -0400
From: Sam Ravnborg <sam@ravnborg.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 0/5] add quartz load support to NXP rtc drivers
Date: Fri,  7 Sep 2018 21:35:03 +0200
Message-Id: <20180907193508.24974-1-sam@ravnborg.org>
In-Reply-To: <20180822183555.GA24084@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

The current rtc drivers for NXP pcf8523 and pcf85063
have different configuration of the quartz load.

pcf8523 hardcode the quartz load to 12.5 Pf
pcf85063 uses the reset default of 7 pF

Introduce a new property to the bindings for the two
rtc devices to specify if the quartz load is 12.5 pF.

Update all in-kernel DT files using the pcf8523 to specify this property.
And finally update the drivers to support the property.

NOTE:
This has the side-effect that any users of the
pcf8523 driver using out-of-tree DTS files needs to
add the new property to get the same behaviour as before.

	Sam

Søren Andersen (5):
      dt-binding: rtci-pcf8523: add binding with quartz_load property
      dt-binding: rtc-pcf85063: add binding with quartz load property
      dts: add nxp,quartz_load_12.5pf to all pcf8523 nodes
      rtc: pcf8523: add quartz load configuration from DT
      rtc: pcf85063: add quartz load configuration from DT

 .../devicetree/bindings/rtc/nxp,pcf85063.txt       | 19 +++++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8523.txt        | 19 +++++++++++++
 .../devicetree/bindings/trivial-devices.txt        |  2 --
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       |  1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |  1 +
 arch/arm/boot/dts/imx6q-h100.dts                   |  1 +
 arch/arm/boot/dts/imx6q-novena.dts                 |  1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |  1 +
 drivers/rtc/rtc-pcf85063.c                         | 31 ++++++++++++++++++++++
 drivers/rtc/rtc-pcf8523.c                          |  6 ++---
 12 files changed, 79 insertions(+), 5 deletions(-)
