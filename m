Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194462;
	b=oejz5PjgIncFbu+7xqkIvIH4z3mtC9jauD0a6ZtCNRy2PXSprtVkWDxaFvejHpQeeJ9J
	 lCh+UHjeNBe6FrTpRwXwKYX7+0LQUvjSv8VRK8MmbgiL4bNLa2YkDwtnGF2GK3tlFiduJ
	 hCIsdpIal/7CFfb9xTpEBvozOkun4plwI15cWSvPtI9eb5yWhTMR/FL97YH6/wDpXJ2FI
	 TBfjVYxWjo6TdMc3Sk0Mze6+mKuNyP1LNoJ7ERT8mFcWN/tRHVuWEt1l6xxyvpMPWCKhy
	 QUzIRwmd0eDOM2IwFS7btfi5MszNgVoz5vPHyRJl/fwW0v0d9kS2APe0q8YDSu4Re/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194462;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w3nIMT4lGIeybYISQRLMNlP/QKxip1YYnlHFsiRaLFI=;
	b=DNxlOmjP5xAhuFhRoxv0a3UViKwtclJ1qPWaV7ATyiDPmtaWvTofN0EiJMFF2GPBTvLh
	 tiWRIgJmxGcINYpDkFma/kgfY6S78m6gSBe2CqQzmgBDHCdoPqFVXc9FEgQD40efhK0EC
	 sXCkdRZVj07Ka+h8RMW7gngzJEp//qnE9aTR/21Fp5XeNHJhco3aVQ5FPSwtk2yLU8Sqy
	 iKnb9uRxrp+WCv3mktBb+LG4Cml3vxpYurJg2BrDnfF7HX3/Bz3WyCY5vWRg2wN9Cxp61
	 k9knWeHla1rs6OBWWxLBqdWenOf9Fc13u2Wa/LFXQvY8wYWkfzhmORsMHffDY7o+AkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YLbsyhGJ;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE82B606A322;
	Mon,  9 Nov 2026 03:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE82B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YLbsyhGJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YLbsyhGJa7eypJ5epPiWq5ZS0tvIZ0qTyv3WyZPHlGo99gmzBTVz6g9HD81Ee9+TqaA5OoUaBPuig
	 MGwgDn235F30aDW/6sYifU7z/ME8V5bU9vhOLcy6x/WW696PDHTIzgomU+Wc5s1gwlv+jtCdVhl2VO
	 eW6CshYzSpqEtqzk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af13c18406-c568d;
	Mon, 09 Nov 2026 11:20:59 +0800 (CST)
X-RM-TRANSID:2ee96af13c18406-c568d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af13c19da5-7f7f5;
	Mon, 09 Nov 2026 11:20:59 +0800 (CST)
X-RM-TRANSID:2ee96af13c19da5-7f7f5
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: ab-eoz9: fix negative temperature readings
Date: Mon, 09 Nov 2026 11:45:00 +0800
Message-ID: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

(-60 degrees C), so the driver computes "raw + ABEOZ953_TEMP_MIN".
regmap_read() hands the raw value back in an unsigned int, which makes
that addition - and the multiplication by 1000 that follows - unsigned as
well: -60 becomes 0xffffffc4 and 1000 * (raw - 60) wraps around for every
raw value below 60.

On 64-bit systems the wrapped unsigned int is then zero-extended into the
long hwmon attribute, so every temperature below 0 degrees C is reported
as a huge positive value: raw 0 (the -60 degrees C code) becomes
4294907296 instead of -60000, raw 30 (-30 degrees C) becomes 4294937296
instead of -30000.  This also contradicts temp1_min, which the same
driver reports as -60000, and consumers that only look for negative
values (thermal governors, monitoring daemons) do not discard the bogus
value.

Perform the arithmetic on a signed value.

Fixes: 67075b63cce2 ("rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
The two expressions were checked with a small user space model of the
same types: raw 0 gives 4294907296 with the old expression and -60000
with this fix, raw 30 gives 4294937296 and -30000.

Compile-tested with gcc and W=1 (CONFIG_RTC_DRV_ABEOZ9=m); there is no
AB-RTCMC-32.768kHz-EOZ9 hardware here, so this was not exercised on a
device.

 drivers/rtc/rtc-ab-eoz9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -399,7 +399,7 @@ static int abeoz9z3_temp_read(struct device *dev,
 		ret = regmap_read(regmap, ABEOZ9_REG_REG_TEMP, &val);
 		if (ret < 0)
 			return ret;
-		*temp = 1000 * (val + ABEOZ953_TEMP_MIN);
+		*temp = 1000 * ((int)val + ABEOZ953_TEMP_MIN);
 		return 0;
 	case hwmon_temp_max:
 		*temp = 1000 * ABEOZ953_TEMP_MAX;



