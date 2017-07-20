Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58008 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936121AbdGTXRz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 20 Jul 2017 19:17:55 -0400
Date: Fri, 21 Jul 2017 00:17:45 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/4] Make PL031 interrupt optional
Message-ID: <20170720231745.GE31807@n2100.armlinux.org.uk>
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

This patch series cleans pu the pl031 driver a little, and adds
support for this configuration.

 drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
