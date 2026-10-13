Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53369509F03;
	Tue, 13 Oct 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892997; cv=none; b=HoOu3cFJceBnj3Xz5JgDFD7gHopXzOsQpHcQ5EHqPHRkGCEIKE6R8Dm6xNjUt2aUovXdFLKQJiDFDKs6AdECw+tq4FUf8U+ffK+C6k/mA6KD8fXpRm5gfAXDDiM7Dddcxu+cCRobk4fEy+/WZkfgf47en6TPCO1m+fHLLFD/830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892997; c=relaxed/simple;
	bh=3tMYBc29SxHiknF2EnUE3+LfUNExQP/CLr/SrNIsjc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itKCgMK3dgnpyLkQV4Zohb58OhZZFnLmnTVoH5vS8bGID6xdYjgq5hZr3KDrYEWlAmgla9dWGqdxg2/UQsozw6PMqBUMVWmhVVchwCzFGgbXYl4aC+0V5t35ASlVHMaxepuuEnJsgfaFa3umhzmoNQ9vvLlPqc7R8NxJqwvd2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfsWHCm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfsWHCm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A2E1F000FF;
	Tue, 13 Oct 2026 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892996;
	bh=6tytrVB3lZ+/GahqdkLavhHkGFrQMltH4pUZON4Qzes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfsWHCm1ubhABOMQpOHdgPiK6aMSNR8DC0qE13LUMRyqyYn/kKe2WW2VmxMjKrELh
	 DHhbofL3n43q432AQYsj1DSVU3BLLoNKCz/ZNdqC2CQ6b8mHwUzc22EBkedHrSaMwq
	 6ISVDlrtf0RcW5jIwjuctxz24At+bOjCp+CCzjWBb8qn7SGwxad90lyzf+9EpT/gXQ
	 1mf7TjPt/oQSN46704gJD/FCwgnkCS7x6stSmGVA24L+6FJRD+kDOtiP9z7B2W4yF8
	 L5SnGsQ0Nmel9onsc+LPr5GAxgfphYWXHrs4zKigwXsFmZS9i4vv2iTNWgf/0ti4TZ
	 P8YQK23OG+gAQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] rtc: ds1685: keep setting PAB until power is removed
Date: Tue, 13 Oct 2026 14:02:08 +0200
Message-ID: <20261013120208.11268-4-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013120208.11268-1-kaloz@kernel.org>
References: <20261013120208.11268-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kickstart or wake-up flag set while its interrupt is enabled (KF with
KSE, WF with WIE) clears PAB, and the system stays powered. Clear the
event flags together with setting PAB, and repeat the write until power
is gone.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/rtc/rtc-ds1685.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 123ab9fc9c8d..421936e3bd74 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1424,15 +1424,21 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 			rtc->write(rtc, RTC_EXT_CTRL_4B, ctrl4b);
 		}
 
-		/* Set PAB to 1 in Control 4A to power the system down. */
+		/*
+		 * Set PAB to 1 in Control 4A to power the system down.  PAB
+		 * is cleared again while KF and KSE, or WF and WIE, are set,
+		 * so keep clearing the flags and setting PAB until power is
+		 * gone.  We do not switch back to bank0.
+		 */
 		dev_warn(&pdev->dev, "Powerdown.\n");
 		mdelay(20);
-		rtc->write(rtc, RTC_EXT_CTRL_4A,
-			   (ctrl4a | RTC_CTRL_4A_PAB));
-
-		/* Spin ... we do not switch back to bank0. */
-		while(1);
-		unreachable();
+		while (1) {
+			ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
+			rtc->write(rtc, RTC_EXT_CTRL_4A,
+				   (ctrl4a & ~RTC_CTRL_4A_RWK_MASK) |
+				   RTC_CTRL_4A_PAB);
+			mdelay(100);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
-- 
2.47.3

