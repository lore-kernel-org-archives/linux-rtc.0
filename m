Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46830EF97
	for <linux-rtc@vger.kernel.org>; Sat, 25 Jul 2026 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939019; cv=none; b=UAWXWzoGlfKqzrA+89DhZyzeaswgQXcUSz5rr6Go26REWP0BXeLgp8xs8Rp++w8GWKpMOaJmF3lZ43zthFfgIdjVmrUSuNigR+mDHfii9Qf5AqnVcok2obAsShb3RjsLZ0QC0d81kkDocOMb5CFcfb88UGpk1GmMmbD+ILFqoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939019; c=relaxed/simple;
	bh=bycekPtl5Yv5sfnZvp7QGmwQ9kv0yG5u09D9Dw1haJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUGMaixShOQdPh8/SiMeQ3k8Jn6Spddr3AisxVlzv+Xm2Mrc+GbKq8SZe3oa2OVE16IJWo756D6KHHrVvrMNQ8UUbqvuTHA9nymeAHhgoSwkZ3S6+X5npwIFnWxG1w/NQx7UGK8LMkh1UU1g9zKm5BSaMFHDMJZR0lGtl5JBtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH9vTWR7; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH9vTWR7"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-74ac0efb654so506350137.2
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784939015; x=1785543815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XmX6sFpdUAlYRd9J5eKdhxq0FmddY0lx44K8Gkw8ysA=;
        b=dH9vTWR7SjaFP71RQUPNOovsd8PmBo2+gtDqcuAc86t1gC1XxA/JmchzSZOUZgHFT2
         B5R103np7WTg0E4hgf/FP5nxReHF2iTCrq+97MoGwWYSE3PtrG/wd9OwyvHRQXzKTtrb
         PZ9A1/1rsAnE1wOcDsWzwOamRxpWvG3BHEMDkVF8SNe/RZpsW837xrXl7rPE7HZrVueU
         fd0hiWkZc9SXEYzypEOn24i2mNcS3JSjVEchP7j2mt+pPylGq1TmevT9BK9AXEpAv0UQ
         Y8VHViJTxb0MaMMDXyv17VXUSkn6KybKZsVYH/xnxPqhlc91WF1qyw2mir9Jzk+fBtN+
         h4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784939015; x=1785543815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XmX6sFpdUAlYRd9J5eKdhxq0FmddY0lx44K8Gkw8ysA=;
        b=BhP6A2ff9AoPQg3HFqeZSI10TAK6Vom3LfnFBSifOB13OZhhHcN8S8Cwr9rwrJbiV9
         Cae1XJLgcYzl6uj33vum6YPt4xHkAItphVzEAPm0EIT1XZyirf2rEB+qn00v5hlwbEjG
         NFqJotoIHuymiSnlnWvgM4Zb7ccNrRrdI4IVN1WGS8s1MszcBgLLR0e3G7x1og9zLNtc
         FCL35vaecH0YqFakg8zzGuTqMUafaY2EHyiQ/geRA7M0Z71opJmj2VU0bUMiq7gBdclq
         JSmctHpDwG4erLWlc5/QQrNuYl41msq/N6FTOtbuMRl1cC7FzzSHeeL8BoPNMMBVo32d
         yF0Q==
X-Gm-Message-State: AOJu0Yx1ZUIEmOSzKOTAx7FrIY5EcnEWA0dn/YmxoK267QJlCFrQ7C8i
	ckxKlNaKRQmQIXb4vqCs9DxcSC9fd2Naygos3pMhPJN91NPWMhUIJF3B
X-Gm-Gg: AR+sD11j3E2oH+I/OtUNwRs/QJ/SjEhcxT72RkenbnJgW2UQyEvbra4a+DyUo51xNX0
	e+hwTSHPy3cmI94ODFFRXVTP2ZFe9c66N6IlmTrgF+3rLjQCPbBf2HrAEP6t7uO9//XE6eYWXMt
	WXRmunWelsbhlot54/8D7KGl3yY2WWsop+lHmKAoiVXg0WdTYF9X31EGSOsScixe0jZfzV2hm1r
	NkF2wgZ91ngKP9uev5eSXf1Rj4hlFU4Ga/NoF+Eaj+QFFagBF1MP7bVTcu9sYbK5P7ytbC1HHWz
	3h7k7TWzZCs4bkLQLHgzDqcjKpTEQkbZngvuZzb+b83r2fOxvQ8SXN/E0JOUDFmMPql46xDeAMv
	tXphTwUKtons3CzPPBm0jwZxnf+N+MtRxZ5Gngep2z5P7DHZ7Bzec/e8C1NuU8PmokEdBCzLyUM
	KnLLzl3MyOpuLEGQgTvlGzhL9p3owLaobHcDNHzlQWEfjavQjCKTI=
X-Received: by 2002:a05:6102:4bcc:b0:745:6b08:c338 with SMTP id ada2fe7eead31-7503e971a77mr718669137.10.1784939014857;
        Fri, 24 Jul 2026 17:23:34 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:60b4:ddf8:a4ba:150b:5c93])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c901f5sm1002836241.6.2026.07.24.17.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:23:33 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	seanga2@gmail.com,
	Sean Anderson <sean.anderson@seco.com>,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v4] rtc: abx80x: Don't warn about oscillator failure after POR
Date: Fri, 24 Jul 2026 21:23:20 -0300
Message-ID: <20260725002320.96660-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Anderson <sean.anderson@seco.com>

According to the datasheet, the "oscillator failure" bit is set

  ...on a power on reset, when both the system and battery voltages have
  dropped below acceptable levels. It is also set if an Oscillator Failure
  occurs....

From testing, this bit is also set if a software reset is initiated.

This bit has a confusing name; it really tells us whether the time data
is valid. We clear it when writing the time. If it is still set, that
means there is a persistent issue, such as an oscillator failure,
instead of a transient one, such as power loss.

Because there are several other reasons which might cause this bit to be
set, including booting for the first time or a battery failure, do not
warn about oscillator failures unconditionally. This may cause system
integrators to waste time investigating the wrong issue.

Continue printing a message about invalid time data before the time has
been set. Only report an oscillator failure after the driver has
successfully written the time and cleared the flag.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v3:
- Rebase onto current mainline.
- Fix commit message wording and typos.

 drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..2525ecb7fb6b 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -127,6 +127,7 @@ struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
 	struct watchdog_device wdog;
+	bool wrote_time;
 };
 
 static int abx80x_write_config_key(struct i2c_client *client, u8 key)
@@ -179,6 +180,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
 static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags, rc_mode = 0;
 
@@ -193,7 +195,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 			return flags;
 
 		if (flags & ABX8XX_OSS_OF) {
-			dev_err(dev, "Oscillator failure, data is invalid.\n");
+			/*
+			 * The OF bit can be set either because of a reset
+			 * (POR/Software reset) or because of an oscillator
+			 * failure. Effectively, it indicates that the stored
+			 * time is invalid. When we write the time, we clear
+			 * this bit. If it stays set, then this indicates an
+			 * oscillator failure.
+			 */
+			if (priv->wrote_time)
+				dev_err(dev, "Oscillator failure\n");
+			else
+				dev_info(dev, "Time data invalid\n");
 			return -EINVAL;
 		}
 	}
@@ -219,6 +232,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
 	unsigned char buf[8];
 	int err, flags;
 
@@ -252,6 +266,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		dev_err(&client->dev, "Unable to write oscillator status register\n");
 		return err;
 	}
+	priv->wrote_time = true;
 
 	return 0;
 }
-- 
2.43.0
