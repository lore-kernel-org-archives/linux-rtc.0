Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215F50391D;
	Tue, 13 Oct 2026 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892994; cv=none; b=Ziw49e/qD8KTEvtW6YdS+N7jwbSxliFWKdx48v3hIiL0a7/e5WyWZcCk+klTIk+dmv/XJ2ss7bioqRUnM21rmb9XKq1RDpncCDT0eddW6pHg7pZ6ift4My9uTm90Ov4VivDpD8098yMdKvg9aHNLaPWu2qPw5k1vbbuXh3XbMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892994; c=relaxed/simple;
	bh=R7lZKT9pR98hse/GhhP15I6fAl4RZ4E9mK5EwIqmyX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh/uV0J5bcCyTA2JxpPGN1/blaHkicrXrXnFsju6VR4hW7/7rnzc1isT5ORByIX3IWCumv3A68SRuyz5VvSRMSpR768Sd6tcPkgQTfd+gedDvA0dOgH67pcnQx5CphL12pAJFa1gOKNWrvpsvQa1fv9QgIpLfHxCSDOaOuCdCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYUM2mom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYUM2mom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909661F000FF;
	Tue, 13 Oct 2026 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791892992;
	bh=9oKhXpkQe0GmKvW80E+9rV+hgYHqw9cYRKNKHgKdXww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYUM2momJsQxMvALHzlosL4QFnkhKokL1STVrIuqhWLd3SFuQAZwRYQB9+CKPyVti
	 YiYcQ/Zk8r9y1Q0rVCRhmHK+wKgyXZaJzlob3yIfSvp/dt7bVdHcHrl9GTxoFrfAqc
	 QVzwF/7LE2psuj04J08fhMHj7/sujacV2WbSnBqYPrnxl39NRPfHmp1M4KSbgNzxIB
	 m7WCNd7Ii1KjL3sxn4uxB9dfJivqQld/wFkFNDXJcdZzL0/0f4tZQxmZER6I7Wh5zD
	 DiV1aVRxKQ1OV+bWXcHXbY8r51BVgrjUq5JoTkUfFy8LAdf4dcxSnywpQDB+UMVzUX
	 Iv5u19LYH7NHQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Kinard <linux@kumba.dev>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
Date: Tue, 13 Oct 2026 14:02:06 +0200
Message-ID: <20261013120208.11268-2-kaloz@kernel.org>
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

