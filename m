Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597820;
	b=RfNDxfmDJ/MVgHfP5xT0rwcyx+XvMu4AhwBn/kldxDnh5QMEmTG/+6DDCtJfKd8tB9yA
	 N/qfbrAK72tq1TlHtzyiJ2vTYEWgDc3DaSDh25eGdSuPdEen7jN0yz/PNR4Q78aZy+2zu
	 L2O4RkeIzLyO0rg11+RzLphfpQVCjoRSNWFCHNAuaS6p23Cu5PZZ1Q8NaodmvaaVBZ5iR
	 nH063W7VwueRWa/o+PPDHpE0fLuMjJgTDQ3oPfo01KPff0DG8NBVbWez30d5FN5xvtRTx
	 XWI+wtjBlMnilX4rOjug3uW3NpWcBJqqbGhUR5siuehJONvWWEwrzq+3DkhJJDNa3sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
	b=xWYhZKcV3VhZmLrMtafIJrL60qO4rDItSRTLIFJCbBD/sH5OghsRQ4xszFAAhFzOK8Cb
	 /khnrldUfZvIlvx0geb7fR/sS2i2PGL6lkfyQPtFLdU/y9nraEegWmpyBiUelfHdzaRmU
	 xk8mAPZLH0M6DhjGERqLaQOnwl+Dqf/hJyUMaMUHzPAVJu5GzXttIbqFor6PTg7U6aMqg
	 IwGceBrui/N4vEic02iUeatsmnp2rKgngt7lB2b+uMUp9mdLrDtOR87pOGBapLKP90fDR
	 Yk/EuVtBXm201ZLdTXBJibCj8/sgRKlBfoniQYnpxpFHBJleWO7XAzfWPDhNQSzwYJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9mhLm99;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F90606A323
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 09:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F90606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9mhLm99
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so2887784b3a.2
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795597819; x=1796202619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
        b=u9mhLm99dVc1rA1P6PDjbILqTqzAD7xN4ouRsDyOT03MrVA/AeyoA6KunG2NYM0gDT
         ll8knTQjsI9aOc9VlsZnhh3cg9lHkXvChnNxrnyRK5zI1DDuH7JBv8QYUzo4/8k2QVNv
         eDqld6wz9XfyWcZHCFnn0s5yGRd2VLRXCumHRaz9TjUsQfEdTjYbp490bjRRfQjHZOdZ
         faM7S+oTWv8CCOXtvHVVBNWtaqth/JQq22kFIRNWVIt4IVCrmtjY59/60tLaHWnJ7D0f
         9gY51/ZgwFKDIKBZrjZ8N45haYmPiV5yivy381EDWPlQ4g7F4X3yS0o+b0Ld7W6ESz1W
         6UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597819; x=1796202619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7Jp81/YwhVY4mwNzcGG+yudpq87Dczt69r71yvv/Ao=;
        b=w7yQ3lMTwn/s7WLdp/iK1S5+itaLFJqGc0ifkCgMnJDLwR1nwIa0U78du5dXExt05i
         jAo3YFKuRpfFAJ0KZhKGDVBwW6pP95iVgpkju6pAIrgHYQOw1nwEEZW/fnn5HZb7P16d
         FQlDSLIdaxmF5mI4gBg//HOxQT3OUZxTLruGqwiAWxUUnBrbJZpEPhITrHjAdTbkUz7s
         M1KyTjMIgBzWXDnq64VoKv4LqNs5iB9NTJ4Y4R8Z2mgISysr3wYDmrDzw9f2GN3NWyuQ
         nAY2Ji5PWR6A1usrxWb0oNSlNZCxtPes1r15cIo7J56e3BLK4Yoiz+Ita/th8iWCem1T
         6WuQ==
X-Forwarded-Encrypted: i=1; AL+hErHbHDyVB3Zm5N+xoeEBE1Z6+Kh9arGfKl9kHI2Vtm07HAAG9uQzpQJLyjo6patE34x/e2VDLx3EpBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mj/wjzQeDYePuGPruzl5/AfST+5tRlX6irfyk73Yols7oJNyk
	I6jiwWLJ/x2bLHIYCmo2SREam+02g9DrI4YfIrTCHZMdFRn0s6QiODE=
X-Gm-Gg: AZFdTZd7ad1sL7fgvBkxcbFabCu9RX7LEpbMaaqwc1Un5Zb3rrknFDBcJBOgWwEymWj
	VyRU6D9T/QiA7ACB4u81zHmzTG2dQzCQYyo6ssVC9AR97pjNoPbs6qso214zxf78QPUD4mZ+Hil
	jA5yXAQABDnfh6lK2AbeHP/1NHYCmEqdF6WS3cJRXVj9Nakj1tDgCIK2To4sngR/QQrv0KX/yZE
	yJ8pqPAjf1KihzYltvmkAhXLVnkxp3DCoHdQZ4lOe9funwzU2ZmIBdHfb7p0RrRURvpmc7BKuhS
	m7ZajoM6iCIkkokmfMlADhTLWqg4YUSVLlzF3dhEZMQMHXC2o8wCNZHRnrBdWuavWdc+eizJq8z
	h0pUzJxfaExXFkTkjzYr7l3hQUa0+Hgk03JGh9ULfDWRFKTHRZxpjivHhQHdMO/SAa/SimrBRpd
	ZvR04+YxGtYDcfGQbu3iADXC9M1pRRzYtsNMj6yyITCQ6B5gEotCwnnnT1K7C0JENvSF/bT8xlh
	Ull8ZEOpRu63/nHz3+f4MQu2ik911c2HeCE1KdBe975/XTGKgknlRCj4JpcC/+Y3t5x9+m7xdsp
	LpJIzcV2tCf7PTVHVe3SeZp2v0NTjc/lP3m3dtHFVpUX65yayn7lpWRZT6Hk6qjQN+ul
X-Received: by 2002:a05:6a21:4d8e:b0:3fa:10b3:c8f1 with SMTP id adf61e73a8af0-4014d25ddfbmr15219804637.41.1795597818828;
        Wed, 25 Nov 2026 01:10:18 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:44a2:4377:d176:9ad1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc613csm8456765a12.5.2026.11.25.01.10.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:10:18 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rtc: isl12026: Fix EEPROM dummy client leak on probe failure
Date: Wed, 25 Nov 2026 17:10:00 +0800
Message-ID: <rc-b1-20261110-vc-22-300211a8c5a0@gmail.com>
X-Mailer: git-send-email 2.50.1
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

isl12026_probe() registers a dummy i2c client for the EEPROM at 0x57
with i2c_new_dummy_device(), but only isl12026_remove() unregisters it.
If devm_rtc_allocate_device(), devm_rtc_nvmem_register() or
devm_rtc_register_device() fails, probe returns with the dummy client
still registered. Every later probe attempt then fails with -EBUSY in
i2c_new_dummy_device(), because 0x57 is still taken by the leaked
client.

Use devm_i2c_new_dummy_device() and drop isl12026_remove(). The dummy
client is now unregistered on probe failure, and on unbind it is
unregistered after the devm-managed RTC and nvmem devices that use it.

Fixes: 4731a43169b7 ("rtc: isl12026: new driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_RTC_DRV_ISL12026=m, CONFIG_RTC_NVMEM=y, CONFIG_COMPILE_TEST=y (object only; no new warnings).
Runtime-tested in QEMU (arm64 virt, KASAN) with this driver on a test I2C adapter module: with fault injection failing probe after the EEPROM client exists, the next probe fails with -EBUSY on 0x57 before the patch and binds after it; unbind/rebind and module reload are clean. No hardware test.
AI assistance was used for analysis and patch preparation.
Needs a probe error after the dummy client is created (allocation failure, or an nvmem or RTC registration error); no in-tree DT uses isil,isl12026.

 drivers/rtc/rtc-isl12026.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
index 2aa3694c4de7..cb12a6366fc3 100644
--- a/drivers/rtc/rtc-isl12026.c
+++ b/drivers/rtc/rtc-isl12026.c
@@ -453,7 +453,8 @@ static int isl12026_probe(struct i2c_client *client)
 
 	isl12026_force_power_modes(client);
 
-	priv->nvm_client = i2c_new_dummy_device(client->adapter, ISL12026_EEPROM_ADDR);
+	priv->nvm_client = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						     ISL12026_EEPROM_ADDR);
 	if (IS_ERR(priv->nvm_client))
 		return PTR_ERR(priv->nvm_client);
 
@@ -471,13 +472,6 @@ static int isl12026_probe(struct i2c_client *client)
 	return devm_rtc_register_device(priv->rtc);
 }
 
-static void isl12026_remove(struct i2c_client *client)
-{
-	struct isl12026 *priv = i2c_get_clientdata(client);
-
-	i2c_unregister_device(priv->nvm_client);
-}
-
 static const struct of_device_id isl12026_dt_match[] = {
 	{ .compatible = "isil,isl12026" },
 	{ }
@@ -496,7 +490,6 @@ static struct i2c_driver isl12026_driver = {
 		.of_match_table = isl12026_dt_match,
 	},
 	.probe		= isl12026_probe,
-	.remove		= isl12026_remove,
 	.id_table	= isl12026_id,
 };
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
