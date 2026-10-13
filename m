Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB84B1297;
	Tue, 13 Oct 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885038; cv=none; b=CIyGekTwxgDPkxXBd+6bH7Hgz3nHXfBBXisoqLCUO5KQbPjGmx9seF5pDPM616DNqEKHZCqnwx4It9hBIdC+M7KvTT518vzgIVpU78kax0HDWUq+Bs1V2eKdrpGo9DP3LZ13FZSw7F1iUCXjgJW3xMe3DeDDcTFN01WB2iwZa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885038; c=relaxed/simple;
	bh=Kbo30ucdK1TSH3lSC8ewL3p3RrkzYSbLnRD5bR9ACBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiygGqzIe7AAKeK1sqD5RsDT8bNWUFYiLjOfnw+S7c/QoD0QOc4wtNaRGgLb/Y64EUhnKKusN8XXkeihphDZkmVAiDyFC4OoUlHvUW2EOEaEY/brKl50mxblzK38QNk6fmVIMo0QBAPDnfxv8ZNyp2V+Cd+a+WgeMGBqKs77EYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw5DX4PR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw5DX4PR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A0B1F000FF;
	Tue, 13 Oct 2026 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885037;
	bh=6vt2627+NIptEA174vhh7X2hEW152UliZ9PbPyuWuTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hw5DX4PR8AXOzvOwC5AXksWVaTx3LgsWSFmGVp95HUNi+PxPUO2CAMn4Lft/emtE/
	 PBVbxZlSLsn/YcSZ76PWG7G7NY//wc1HuMepJFhtWFIL25d9OJyW3YIbcmVkuKnJWj
	 HuHv6L1uXcFaMnyvnxzZSoE15zhsd/Q8pmoWcT2RCMZFRpt8vntDUdauhy5NmTTZYK
	 9pOc6lRvqkO8ZZjCBERWAGSsU4NiNwa66bQTPjE4+yhNsc6aU6cMPqD0iw5UjppkLv
	 rCVnn+J/zF2sNtQnIV7iHE6NyrOLVzKKIvc+KfaPkSepvpznGV+5DlHep/n62d0SHM
	 FyHEOAyKT6w2w==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: ds1685: keep setting PAB until power is removed
Date: Tue, 13 Oct 2026 11:49:29 +0200
Message-ID: <20261013094930.574-3-kaloz@kernel.org>
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

A kickstart or wake-up flag set while its interrupt is enabled (KF with
KSE, WF with WIE) clears PAB, and the system stays powered. Clear the
event flags together with setting PAB, and repeat the write until power
is gone.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/rtc/rtc-ds1685.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 94c89333c5d5..a7828f0d6c09 100644
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
 		msleep(20);
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
+			msleep(100);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
-- 
2.47.3

