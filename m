Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4B4A1DF4;
	Tue, 13 Oct 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885036; cv=none; b=L/7deQqrSwUPHu5emw1kuIEQQ88a9YDPL81zxGeIDQtJh+bGQd/EtNoqADpYbGmo1whtgn9r0SGR8GhB1CdEL9sv8cga8GZNfvm/pJgMK4G/bzvkRmXsVRhN+iuPEP2SZK1XUpuDXXM0I5K4FrnftGwtPhgN+3Ktgb1Z+AKOXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885036; c=relaxed/simple;
	bh=R7lZKT9pR98hse/GhhP15I6fAl4RZ4E9mK5EwIqmyX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfRW2DZR5lPXbNVXgkc7QQ+CcvHSeqnG0qC/+pxuWNarezRKqxJnM0c/qTt1mu9kVb2jQLUh11T+yRwsrXPvqtxgEKhMO6wkPPt2nllyOogX7P/TqU8A5Eay5WTJoWtLbT8OU3K094ivXmyZiKh+xhESwhLijOig6gCXFyxbycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwZd0XFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwZd0XFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5901F00893;
	Tue, 13 Oct 2026 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885035;
	bh=9oKhXpkQe0GmKvW80E+9rV+hgYHqw9cYRKNKHgKdXww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UwZd0XFr9XWv8mu05is4j93q3hmK+lqYFmCJYwtGkmw7lfBpJPsJI6l5m4FYfKjw9
	 upgaUEjSpWowG9f+mNs3k5ha6hK9sRGrVYRnGaAemvbLxUg8oMB796PN/2S3xbuIWY
	 J0H0RBlBO3c9Hh9kOjWNWNI5nIsyJeP2UDXLxFYprN+deBQW3dQAYedXtYfwsGbki0
	 VMfcJygycF7Q+HGOW/HHtj1lmVtoGqoraq6Rqaq0oDMMCrWSDXFALkoHCGxDoYVTom
	 NnfPlUPrio8Ivxid3ThFc1zUbDwiCWxTFchdCEZin+vqmVTFd4akyxzmct/TtYJ+eO
	 UfklQkr8ibNgg==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
Date: Tue, 13 Oct 2026 11:49:28 +0200
Message-ID: <20261013094930.574-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013094930.574-1-kaloz@kernel.org>
References: <20261013094930.574-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ds1685_rtc_poweroff() always sets WIE. The wake-up alarm then compares
the time-of-day and date alarm registers, which hold whatever was last
written to them, and a match powers the machine straight back on.

Set WIE only when AIE is set in Control B, and clear it otherwise.

Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/rtc/rtc-ds1685.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 5fc8e36b1abf..94c89333c5d5 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1367,7 +1367,7 @@ module_platform_driver(ds1685_rtc_driver);
 void __noreturn
 ds1685_rtc_poweroff(struct platform_device *pdev)
 {
-	u8 ctrla, ctrl4a, ctrl4b;
+	u8 ctrla, ctrlb, ctrl4a, ctrl4b;
 	struct ds1685_priv *rtc;
 
 	/* Check for valid RTC data, else, spin forever. */
@@ -1394,6 +1394,8 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		ctrla &= ~(RTC_CTRL_A_DV2);
 		rtc->write(rtc, RTC_CTRL_A, ctrla);
 
+		ctrlb = rtc->read(rtc, RTC_CTRL_B);
+
 		/*
 		 * Read Control 4A and check the status of the auxillary
 		 * battery.  This must be present and working (VRT2 = 1)
@@ -1408,13 +1410,17 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 
 			/*
 			 * The auxillary battery is present and working.
-			 * Enable extended functions (ABE=1), enable
-			 * wake-up (WIE=1), and enable kickstart (KSE=1)
-			 * in Control 4B.
+			 * Enable extended functions (ABE=1) and kickstart
+			 * (KSE=1) in Control 4B.  Enable wake-up (WIE=1) only
+			 * if an alarm is set, else stale alarm registers
+			 * can power the system back on.
 			 */
 			ctrl4b = rtc->read(rtc, RTC_EXT_CTRL_4B);
-			ctrl4b |= (RTC_CTRL_4B_ABE | RTC_CTRL_4B_WIE |
-				   RTC_CTRL_4B_KSE);
+			ctrl4b |= (RTC_CTRL_4B_ABE | RTC_CTRL_4B_KSE);
+			if (ctrlb & RTC_CTRL_B_AIE)
+				ctrl4b |= RTC_CTRL_4B_WIE;
+			else
+				ctrl4b &= ~(RTC_CTRL_4B_WIE);
 			rtc->write(rtc, RTC_EXT_CTRL_4B, ctrl4b);
 		}
 
-- 
2.47.3

