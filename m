Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444741;
	b=N4T4Ilq1xjz+NpV4QvpacmE3PEsIAwd7svy5wwfN8SgR1UZQzQYKuXSAAMDxQ2Y8ROZZ
	 z9z8q683wMPKjKur0yrMavx7MyueRqAiIrKYPCmuoqg427cm6Knc9psR6zVvDmuFWjkH+
	 D3zQI6zQ0GoOBiGM0w9ZK3fMHqyDe/umLLKtWJ88g5awZZYij35RA5o6kzr3GGsQYnX8D
	 WneLYk8IcIxTJNOYHamNXNL+ktyFC8iSl10SouCIUhprBDYXIqWubDZTntdyfPS44ROnJ
	 oQoyzc760NbTQZvvHeAD528cJ7z9RPDhI/WLLBHu5fQ+05DNmvp35f9WFRMUVJxn9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444741;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=r/4Vz70AHBEzgvP5ZrxXGqOcrtSUda3iU9Kf5mhVU0k=;
	b=PapBt+vyBbUFAFgy8/PoBTRIvPBDZWAhtNTKnohhvSDTUCOlvHq7HLSRLlKDsnRDpOdP
	 RdLbWAY84Va6GTXnyDyIDzjIX4Ui3iMus+nITkNRfLficajR3WiQsklL+IqHeGHnGXp10
	 SdX4Wq3OUNuADNNxfRiF9vYgVLEE6oGr7WjSlDBvHjBK6aBou6AdO1h25VcQOaJQtVE3u
	 itOY0dyWkl72UdFrNl3xAZxyZyIoOAuleQicALCWwbrk+dBYgY/pM5hJMPwCykQuzXbjB
	 h0oW+C3Uy1lkrptXtq896QcA3NhUmiKrOldsGuL0JZD96xnq4zNut2+S033FtIa4c5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ak5L1Hm4;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAD606A31A;
	Mon, 19 Oct 2026 21:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBAD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ak5L1Hm4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 889BE1A1246;
	Mon, 19 Oct 2026 21:18:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E4B860582;
	Mon, 19 Oct 2026 21:18:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89D9910328D6E;
	Mon, 19 Oct 2026 23:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792444734; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=r/4Vz70AHBEzgvP5ZrxXGqOcrtSUda3iU9Kf5mhVU0k=;
	b=ak5L1Hm4lGD2qptIEQNq/+a64fhiDtI+N1jhZzEIrQnyx56/opZrJi17bYpcFjTS/O3TWq
	f0iVhAZ8r9Pys2s7JWao2/gPGbvacSwYNlozCv0XzkCrKyhVoXQc2sUMmojjA5aDOrptNV
	3VmjVAN4Ygg1aDslWx6pvNsrD6zK+ygNPdNMkX/53duVAwQ4I56pdMMitIE+W/ap6dtvjm
	98sw9xWlHPdEfc8q9zXkp0T/MQ3EE0KG/KZCpRhpcdBTQsvN73/U7APaxrNZeU2L1sySzy
	7tmK3qLTcPsiLLyJToX4oV708efSARg4HsCTFzMteNhidxOaQ0vofqu7Dsh4IQ==
From: alexandre.belloni@bootlin.com
To: CL Wang <cl634@andestech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] rtc: atcrtc100: use guard
Date: Mon, 19 Oct 2026 23:18:05 +0200
Message-ID: <20261019211827.126262-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Use guard() to simplify locking

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-atcrtc100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-atcrtc100.c b/drivers/rtc/rtc-atcrtc100.c
index 9808fc2c5a49..2433df386c40 100644
--- a/drivers/rtc/rtc-atcrtc100.c
+++ b/drivers/rtc/rtc-atcrtc100.c
@@ -147,7 +147,7 @@ static void atcrtc_alarm_clear(struct work_struct *work)
 		container_of(work, struct atcrtc_dev, rtc_work);
 	int ret;
 
-	rtc_lock(rtc->rtc_dev);
+	guard(rtc_ops)(rtc->rtc_dev);
 
 	if (!rtc->alarm_en) {
 		ret = atcrtc_check_write_done(rtc);
@@ -159,7 +159,6 @@ static void atcrtc_alarm_clear(struct work_struct *work)
 			regmap_update_bits(rtc->regmap, RTC_CR,
 					   ALARM_WAKEUP | ALARM_INT, 0);
 	}
-	rtc_unlock(rtc->rtc_dev);
 }
 
 static int atcrtc_read_time(struct device *dev, struct rtc_time *tm)
-- 
2.56.0

