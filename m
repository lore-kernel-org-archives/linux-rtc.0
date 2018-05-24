Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030648AbeEXJ6j (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 24 May 2018 05:58:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 165/165] rtc: goldfish: Add missing MODULE_LICENSE
Date: Thu, 24 May 2018 11:39:31 +0200
Message-Id: <20180524093628.757071922@linuxfoundation.org>
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 82d632b85eb89f97051530f556cb49ee1c04bde7 ]

Fix the following warning in MIPS allmodconfig by adding a
MODULE_LICENSE() at the end of rtc-goldfish.c, based on the file header
comment which says GNU General Public License version 2:

WARNING: modpost: missing MODULE_LICENSE() in drivers/rtc/rtc-goldfish.o

Fixes: f22d9cdcb5eb ("rtc: goldfish: Add RTC driver for Android emulator")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-goldfish.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/rtc/rtc-goldfish.c
+++ b/drivers/rtc/rtc-goldfish.c
@@ -235,3 +235,5 @@ static struct platform_driver goldfish_r
 };
 
 module_platform_driver(goldfish_rtc);
+
+MODULE_LICENSE("GPL v2");
