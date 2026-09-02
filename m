Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251D4949F1
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353585; cv=none; b=pAm5l1XSVU+rzTXtfEwJANiF5QdJgo8NdUhHCE5m5U2stSfkSqNPm3UUIZpxLhhZZBuNmeHRsBSahF2v94QUdcP+ERI5t7Kwo3B3K9QQkqIae/4t0Iu33NlB2xv80nVxUZdMe/UMQqoDei/7pSeZNOqNnFixmwxHjV5dX5lm5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353585; c=relaxed/simple;
	bh=bycekPtl5Yv5sfnZvp7QGmwQ9kv0yG5u09D9Dw1haJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkYTPexh03nyv0+EJkTx3ep4XJ/6Sok/T9PLkskXaL8KCVu2NyC6+7lgt6LNfHDwT9Z6+71nXMJEGQ60218qKY3OnvmR2TGCUvulNQwVpcFJJ4feKxyajh3t8Lk3xC8N7r0zspdCaeE3smHwJp0Tkb828yLuCqY5UcAL1MXBbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgFOYM4V; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgFOYM4V"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc328b43a56so716958a12.2
        for <linux-rtc@vger.kernel.org>; Wed, 02 Sep 2026 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788353584; x=1788958384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XmX6sFpdUAlYRd9J5eKdhxq0FmddY0lx44K8Gkw8ysA=;
        b=BgFOYM4V1O29GEGUEsxHEXyEqqoxgPWYFcOI1922D1nGHQDK+PTVGFhHn4DzCovsHj
         cJ9WAeCUm0WwqDjonrZDsygDU+3RHSHlCvcVlqPORMHkwSgrvaGP+ibhuEGIekhwQh7l
         s66S7nhLHxxtUEAdyBklP4G7Wb9Xj2SQN5ynjrerMBchru02xwp4eGH/v0lRDl+KCEz5
         yK4qxZBjLvrrmQ91OQzrZiun/lF2lGIDIYpWdIXRaqjWunvPN7zSLkm4UBqgaJ2jSSu/
         3vzlOz6A/Tvhd/MUZ2R/If8EcssxqpIPgqIV0bIIGmR9ScUK6+DyIi0NXdU2F0uDU6Ov
         E9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353584; x=1788958384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XmX6sFpdUAlYRd9J5eKdhxq0FmddY0lx44K8Gkw8ysA=;
        b=DVtbBI7L0RwzzajD3ubfZQqJJbawvjiQ93yblFnpf+nPzZQgoBSU/HVdbWZm/SM6Mj
         hKqnFKg9VmktU4CPAZuwtvM2OMS+nqKZjj5pI6ECPx+Plwx5zwgEA1zSKe2xVleqiFb8
         gjFoJdKzi/W3O+FtViMTuEhc557fwQ2Zt3jmuHquI7mgvsVOAmJtn0tzkdy4UKgGpVvj
         VBZ8CiHLIVc69w2uBRYCbDpeE/9wvIByhNZygk809QKXs4dSufcFx8MFBaPGkgTeA7i+
         m1vED/Gq9Ct57SJl0HwF/sPmZgLTKSCXIW9xtG5sFQptjN8J9arnD+4lhbL0UVR8WJrM
         vvZw==
X-Gm-Message-State: AFuF++lUH+WJCXx3928SQReZXzj4YodafjKRiT44DetIjctgLNBmzeA1
	GZwk5n4aE4Tzi8+TB9p+IFsguMGgo4jn2qk9bLBz4nAHtvP1lH61m8xb
X-Gm-Gg: AYBFou1RUbIsybJ+Hjw0TangdfxUhHoK+Kwbmb5SNgLrA0aEayNgZ5rFAYBEEl9bc/s
	nQFZ46vQi6+R3cp9wyWNE2giKHoqEIO3jlRMoyoIiQH95DtmwperU9nzKZatQZB2xGduIlgVtGk
	qU9KPonD5X5VUGRamQIDIUfpCP1zU/FUS83WXK3ywABpmESi+qwdn75tUvLrmZvQJIvqGQpfKnC
	AMZopS7mhjJkvD0RRbjskMKyeGKeXytdpJkuuREE7e+XVCYPKpg/oizoqg4gnkdp19+iGm4mZBT
	VZC8BXzouRN2oHAtmJphUdj9m3YYwiN5n/eXeDuDTBv82cfCsgYVBJZ0h4ROild7BembnNudmO0
	hBPHxRfRPON60WeKrO19Fz3sWkSY31xAhlj/qtlNdVDzdiuf9vzF5/Nx7IzRMH2s1xEWQBiuXU+
	PnCiYtGC9B/6JhEn+JhnQP/9sqSKwLz+keOckMddW884QiBK7Av7TRsf6d4309A015Lzy+F5zhG
	dWxZi0ginAtb0RJzO5bgXo+QdGdlmbVp+cP
X-Received: by 2002:a17:90a:cf88:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39aee9b4d19mr5123439a91.4.1788353583502;
        Wed, 02 Sep 2026 05:53:03 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a802:ffb2:9cb4:2d4:75ee:cd63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07beb704sm7099975eec.30.2026.09.02.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:53:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	seanga2@gmail.com,
	Sean Anderson <sean.anderson@seco.com>,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH RESEND v4] rtc: abx80x: Don't warn about oscillator failure after POR
Date: Wed,  2 Sep 2026 09:52:57 -0300
Message-ID: <20260902125257.9882-1-festevam@gmail.com>
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
