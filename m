Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195953;
	b=OULHxp7v3Eyr46N+8ZGxD3iTQSJR86A3MDp1RfnEeIDhNtDNveSzMWbsGhm+tL5OzeS0
	 s/AlEhYN/WtscKlXp67jc67H0s3fiPzWZw6UVj7k7fu7HqHA5DfaXValDnJ2yts8IyOx1
	 LDUxmj7lrRPVML3o1ngWIC7v9qCKF95BrSrsEkBxrwZCAhN51+AULs3sBJdyk+FqqRy0E
	 Qlu4GaWDRXFRwP5APYbkvCSHVAvccO+AgNzLbrdFKYzlbwTX0SrKJpBqfmFQl+/OCLxXC
	 SOW3T70HH+wfPkEgb8mnlC8Cyb4ED+Dy54ljpSQOO7xqSCbQqcUrRAspsdibLepo/QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195953;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Iz4Qp7XjPDXjbSBT/keNOWn8pux5m+Fdx0Qh4Yd13qg=;
	b=qgCVCIBVNvKmfornEyRBCrSj9V7d0Ui1Vbi5lRmJFouzrqDife7f4AWadvQEfTa+Csrz
	 88ZcKy+jVQBUdnShmNnkHwJIuwQRdCsAoelJE5juEMq1CRNdberN4e1OGNTnu60sOjXWu
	 d8vAA76Y+QwhloXTwCgaZshEPmzV8K4M/u96XFLHu77eNqWv6yHVJkwD4keDsBoKraawf
	 esBmYFYQlZdX9W/GaZfH5hCq9ciePSdXLvV6JNkYt7vc+sQJpmnqZRbjKJKaoCs6djISN
	 nAZYxV0gPEHHo0cUNn0Ymya7MMDYhUV4tNLEQ94155UH/W++zdNQJs77StyfAK11Rag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P63z8p1j;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6659606A31C;
	Mon,  9 Nov 2026 03:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6659606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P63z8p1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=P63z8p1j8NBCDmiGnvfNt4rY9xGpTPl3L3YOFMiF0mkJMkhMgXpr1o0e51eCwVau1uhk4HoqetFtS
	 NfdoP/I4iJ3arkzS8ucKqP4CdC96Fjh7IvBoH246t+m/3maXrGVkXcsuh77uxZEWC86EPGFyIpyCk3
	 dpFHWOtcUZ05yWCY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af141eda52-c5cd9;
	Mon, 09 Nov 2026 11:45:50 +0800 (CST)
X-RM-TRANSID:2ee96af141eda52-c5cd9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af141eb4eb-7fedd;
	Mon, 09 Nov 2026 11:45:50 +0800 (CST)
X-RM-TRANSID:2ee86af141eb4eb-7fedd
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: linux-rtc@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtc: ab-eoz9: fix negative temperature readings
Date: Mon, 09 Nov 2026 11:50:00 +0800
Message-ID: <20261109-rtc-ab-eoz9-neg-temp-v2-1-yuehongwu@cmss.chinamobile.com>
In-Reply-To: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
References: <20261109-rtc-ab-eoz9-neg-temp-1-yuehongwu@cmss.chinamobile.com>
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

The temperature register is coded with an offset of ABEOZ953_TEMP_MIN
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
v2: no code change; restore the first line of the commit message, which
was lost when v1 was converted to plain text.

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


