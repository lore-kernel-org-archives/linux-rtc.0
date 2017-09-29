Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43396 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdI2KV0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 29 Sep 2017 06:21:26 -0400
Date: Fri, 29 Sep 2017 11:21:16 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] Make PL031 interrupt optional
Message-ID: <20170929102116.GX20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

There are some boards out there which have a PL031 RTC, but its
interrupt is not wired up.  To support these, we need the PL031
to support the primecell without interrupts.

When no interrupt is present, there's little point exposing the
RTC's alarm capabilities, so we omit the alarm-related function
calls - the RTC merely becomes a source of time-of-day.

This patch series cleans up the pl031 driver a little, and adds
support for this configuration.

 drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

v2: update patch 2 & 3 for review comment on v1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
