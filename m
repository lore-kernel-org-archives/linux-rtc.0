Return-Path: <SRS0=DqQs=WI=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D26CC433FF
	for <linux-rtc@archiver.kernel.org>; Mon, 12 Aug 2019 23:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D416F2070C
	for <linux-rtc@archiver.kernel.org>; Mon, 12 Aug 2019 23:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565652536;
	bh=o501tcSZ8iwEdK+K1S+CV9iMf5gZNuQYUaXGpk1a0Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YcyXW31s0gwRGFZmFdiiu0CVCr3dwz7XxHb6OfIgTR5tZkDeHegx6Zvor+mqheXHi
	 Wh8JDWZE6pcj0gnm7SXsasmT9jxZTRgdAgYRn2JXGi2CZ7boK4sps4ppDxhWRSkiXI
	 SXWJ5YxqlRvHmqHgqH2ZevszIWZGTFhCtrlZY+L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHLX24 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfHLX24 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 12 Aug 2019 19:28:56 -0400
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net [71.197.186.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4246220665;
        Mon, 12 Aug 2019 23:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565652535;
        bh=o501tcSZ8iwEdK+K1S+CV9iMf5gZNuQYUaXGpk1a0Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhcs+cU9QcwB87J3Vj953PKrW2TYjyRygJOYfxP1LOzTzRG9HBIrZ1QRbnREbUjW9
         4PyFx6h+i2MgDMscGpwWA+R5bQk8fpjTv6kEzSW4yh6iP3DLx2NJ705vBuTDjYeZB/
         wN6Zefwp4c0kpOMEg9Cql01iPmbuivK+OrXF/2bQ=
From:   Kevin Hilman <khilman@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: rtc: new binding for Amlogic VRTC
Date:   Mon, 12 Aug 2019 16:28:49 -0700
Message-Id: <20190812232850.8016-2-khilman@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812232850.8016-1-khilman@kernel.org>
References: <20190812232850.8016-1-khilman@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

Add binding fo the new VRTC driver for Amlogic SoCs.  The 64-bit
family of SoCs only has an RTC managed by firmware, and this VRTC
driver provides the simple, one-register firmware interface.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../bindings/rtc/rtc-meson-vrtc.txt           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt b/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
new file mode 100644
index 000000000000..c014f54a9853
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
@@ -0,0 +1,22 @@
+* Amlogic Virtual RTC (VRTC)
+
+This is a Linux interface to an RTC managed by firmware, hence it's
+virtual from a Linux perspective.  The interface is 1 register where
+an alarm time (in seconds) is to be written.
+
+Required properties:
+- compatible: should be "amlogic,meson-vrtc"
+- reg: physical address for the alarm register
+
+The alarm register is a simple scratch register shared between the
+application processors (AP) and the secure co-processor (SCP.)  When
+the AP suspends, the SCP will use the value of this register to
+program an always-on timer before going sleep. When the timer expires,
+the SCP will wake up and will then wake the AP.
+
+Example:
+
+	vrtc: rtc@0a8 {
+		compatible = "amlogic,meson-vrtc";
+		reg = <0x0 0x000a8 0x0 0x4>;
+	};
-- 
2.22.0

