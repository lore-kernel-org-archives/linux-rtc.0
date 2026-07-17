Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A038B149
	for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317028; cv=none; b=GCAt/LoJgMVND85ldmW/I9R6nnD7OPZwluY9PisQMrQsqvIqbAGKQoNm86s3BLHAkkjpKcCn5ismBCjc00BDjAZytXybDDfknCxUBOKCsXK70t10TnzDnoDMYJtbRQA8aNvdd9NcfBf/V7BETd5118yD0j9xXcw0gdw6/CCZTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317028; c=relaxed/simple;
	bh=pnhc3sWheq94n70n4phC94fuiXNKcS7Dzo5ZMbl2qmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8FWKegYJiCSmmqqG99cly2VxMqKB61nJigCKBjdtmiFCR7dw0FbgJGmSe1SaJ3MPvzMZe7JEGYv3R0Aql8fDxybZoaIelq0ENPE6bOUWPtSRpX2Bmqdwp+hINOw/Ti4fIMLWoQ0hHOKzxZPvR4h8ZY0k9yn8zcA/dB6Tia44JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu7mgsQb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu7mgsQb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f236418so4098868b3a.1
        for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784317027; x=1784921827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KfbsteVL+Zy8Qu/9J2ISTz+z/YyDIIAgzykHz1aYy2E=;
        b=mu7mgsQb5Mt/zGPVTjv2bQsmrIucy3W5YFF+QZs4S+RqllGdZ8oj2wrAgG5lOcAPSl
         jNxzodCjq4qwQAx9wGD7od699KzQ90v6W8PvBWsgrubLPqYbp2p9KAh8WM+fHy9rjwfN
         uhKVh909faRRuzAUrULU/7RDox/PEhDi7vw2TLtSB0OTo/XDGQxqdaS+3y/aHRUZLGQP
         zzBbHcPUMrjvObIU7lw+lAJEVzLmxxtvQdY9+FCPyVoi7a2lzxP7Xcbfipi72+YI57al
         3llf64tEPcxsEpMKxPB2WJuvCQZ8Vuv2gP5A8VHaScRUcnpjHjSVMDn5yTv7LzwjTxAR
         buog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317027; x=1784921827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfbsteVL+Zy8Qu/9J2ISTz+z/YyDIIAgzykHz1aYy2E=;
        b=R+apZbSQQRSfK3iyxnhv1blHib9T8NpxPOMeuukoXz9fQLkfvOOH/BNI4hzt5S1Xzq
         aECcvtCNSYhqkkH8x+gE4dJHSdo4MUIHaf1mPf5/ySBEc7KIM5wWDDg4G1qEllInR0jm
         mCarBlRbl7XLATNTs2mNMrDnfr2uaf2abQS6mkbbGyRFtmN1FyvsDo33Cra38JF3Y3gL
         RhohYfm8Tuvdg42LA4OMvk1ZrNBfTRpoz8eMWuJxqNOJSD9XHtNV8TSpM2v7T0l4mWDF
         giZHuZbdN7iRdxvVX6Pfad/qgBpWHZrWdUQyrA4QC6p/7OvH5cQP6j7HlnFW5BB/Bnf/
         Z5dg==
X-Gm-Message-State: AOJu0YxQB52Eyu9Om0LgvhyHTfpLekHevOAyojzeYFmg0h1Iv6JJ19g9
	2CrjEiYg7DM3GBma4xq8qIHglpRVDzdX6I//4BEAQhSR0xClNT1lmx0f
X-Gm-Gg: AfdE7cmA9n+MHgrB7b4GnlLLgogkX4KGQDcsQR9Cfw0MvCPgBiVEeqQTYsbyGrb0OLx
	cMNzONtDAmFiOqqlpgaeQ4r/WG3npUln9obOcmjM7fifczJ7P83HlL+13gzuxRXgoFuLia5eMUK
	wgXs0IVZ71saDRoxR/IEwfz7dr2zhP4fr0dvviDGlH/Vp/TTb5+NEqKq3/PsPEvgeS4uu9cM+ON
	Q69Ms94/tKsoJc6pjxU/Iv3ILqq+X9CW+pwPsV3sR7k/SVuZLweSM8oUB11jLAuvu70jZ/4AjH8
	uldMLI5NtHZZEwxgXf9uIar4f0pKzRBoaMEzg1OWqOVnL5aoZDKiNDxoAVgT8TQgUSf8XI9pvw/
	FYG0MAMzKgY1qsP5PssNZfx80un3OsvjzOXnthdsvQBvET6CooxkKzXOa/j9mhbybiXmS9atqqm
	ODJAhUZUI1WKl6695bkd4hKpt6Pk/fjEVCh5z4Vxv3rKqoYxp3
X-Received: by 2002:a05:6a00:4c95:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-84c2926485emr3997220b3a.3.1784317026580;
        Fri, 17 Jul 2026 12:37:06 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb51a2c2a13sm1286746a12.31.2026.07.17.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:37:06 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2] rtc: pcf85363: Add error checking to regmap calls in probe()
Date: Sat, 18 Jul 2026 03:37:05 +0800
Message-ID: <20260717193705.2003175-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe() function ignores errors returned by regmap operations.
If an I2C transport error occurs (e.g., -ENXIO), the driver continues
probing and may register a non-functional RTC device.

Propagate errors from all unchecked regmap calls in probe() using
dev_err_probe().

Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-femtofarads property")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
Changes in v2 [1]:
- Update commit message to reflect the new scope of the fix
- Add error checking to all remaining regmap calls in probe()
  (regmap_write to CTRL_FLAGS and regmap_update_bits to CTRL_PIN_IO)

[1] https://lore.kernel.org/linux-rtc/20260716125142.1801599-1-chou.cosmo@gmail.com/

 drivers/rtc/rtc-pcf85363.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 540042b9eec8..ccc7834e5759 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client)
 
 	err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);
 	if (err < 0)
-		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
-			 err);
+		return dev_err_probe(&client->dev, err,
+				     "failed to set xtal load capacitance\n");
 
 	pcf85363->rtc->ops = &rtc_ops;
 	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
@@ -436,9 +436,16 @@ static int pcf85363_probe(struct i2c_client *client)
 	wakeup_source = device_property_read_bool(&client->dev,
 						  "wakeup-source");
 	if (client->irq > 0 || wakeup_source) {
-		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
-		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
+		err = regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+		if (err)
+			return dev_err_probe(&client->dev, err,
+					     "failed to clear flags\n");
+
+		err = regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+					 PIN_IO_INTAPM, PIN_IO_INTA_OUT);
+		if (err)
+			return dev_err_probe(&client->dev, err,
+					     "failed to set interrupt pin mode\n");
 	}
 
 	if (client->irq > 0) {
-- 
2.43.0

