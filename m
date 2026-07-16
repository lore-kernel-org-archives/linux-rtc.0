Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED741E6D3
	for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206308; cv=none; b=cVla/wV7Tnpj2J6Xvury9XIjyGdy8e55jxtAQ+4zK2FXhkqUHQVpZ0oCLkLX/61mMughh8G7YFj83ZvLK8vEzgs4lVBj9+PKs4sLqqIP5d6c+8rRio5qEAVsuS1Q8uiMQknw9JnKE1ULHS4QWBjJy7sZGIZV2pZs3Q8G317zGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206308; c=relaxed/simple;
	bh=PYQ5bjGG2L7IjfLDIJK+d4nOUJObUYwPQYQ5BHZfNAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2CsVwQL0u1db1GRhmb5dyJ16ZaKFAXOO1hx5jGsqzxtTi+Ss9Nc4kpXNNIiaPjhSnulpioyuf9BqPI7xVtXeBEMWFN5lH5JHfu0qnNS4mkf/4qzZSgN66kFooCsCXs6a0zCUx+jvtl9Kq10qVyJXoUFxCACXvjObRGzV+c0LPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjnCY7FL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjnCY7FL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a2c90e383so167807b3a.0
        for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206304; x=1784811104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJSBtRYD4NAhZpeEbBYSFxuI8n6xv+njnojLmu/oONQ=;
        b=GjnCY7FLQn0bwaAID8k3qJP47k76ic5IglDoF4xN2hN2XoB8oROQhTMCeukb+CnbX6
         52LaNG+8IEMrmsgEYRz6RKUFSTphrlKR7CMSPFoyPbQoKdQVwei3dJImtS8WJMv62G4S
         XncgW4xHftfk0SaGOotgmL9qfXdHfd0Unfywy1ugJqu6x8FEpkYc6Wb3fJzv8aeU8ARv
         qg4ZbfsY85odgr4q6JwNdoHPs+unTAbEanvKo2TWOHhfQ1GpYmn2+q2DKQfz+k+3cUIj
         gmrZ238UfRwIzSWfOOeBC82pVgbfMBCszN+nPmLxGx51LOTl9BQjJKuChiMdy3Dbrpwd
         EhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206304; x=1784811104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJSBtRYD4NAhZpeEbBYSFxuI8n6xv+njnojLmu/oONQ=;
        b=ElwLPPlpZN2i33zGA2aSWJzLkutgOmqMifBMk36dRHBFJEHth8aO3M30GKmGf+tndr
         Sg/QgVS7AQr7HW1W3z1QjuGLq1I39AcPgMqs08kZHyBceJGr3HA9eYOVNMQ6ZU/0UDjU
         5QJii7j0VapF2HhciTx2qEbb7TPPcIYR1T+Y8a/wZlRHMnrv6nZ8gfWC9HL+TogmzWop
         ZGH/DH2DLU2W84Wwpo+QRrlboe0pZEl1m9zoHwRm7c7LI4sS6b0YemUeq0AzbzaVavfD
         RmpwhQM4x7lgM5oeAFq6mWvT+BRWjXdUPiMSnxVRU+SNUITMJ0rGH5YgbxFRhlj7bf+N
         k3gw==
X-Gm-Message-State: AOJu0Yx/5NUqn1l6UULHAE0KsU18f8bKjTIjFmTbAQGYbt7n961MlDLs
	TnLy4z5hqZfqm3zu3P0o523eSQ2lqeTvLJxFkBEfkKTjlDoLjpoCTOAH
X-Gm-Gg: AfdE7cmpyMeCwIf6SO105ZPtF3+aojCGP2JtTI9fAQluRpdz5//IbIPPYj7AlLVmkDW
	5FOda3qIOMN+Qqul7zkwvbfWrda08hyGERAoJzbJV8m7ZVd9fhlfe3YOrmuwXmIYv4N5vxXzV+R
	77b42Gp4gurB6+gjmGLerr0oCSpqTntFw5G0s58L149iS6Tymq/eHVf8CooFNj0QJO+56TGJH1R
	5LGylCvJuY91zWlJmQb3822GbG9MA+g6zg0EWbDGf7dszQvY7IUjHmN9qfin006/3Pww6FRbYIa
	rhvXhAyJQ5HSYDasrxi0mjLdZ5aRGNM8XF1g2PFKeF1bVptnJqCsJ6al9ubSa/8aevRSSUz2Ri4
	ew2v64cQTSKtkDjOO5SasLeYsETFRDEgy+8NUQ083nda7ytbHuO2gdAB2el2rReTuAMJpKeGc6g
	tdG7AComn4rByHjDg5x+CTa+IPQF2gOZWFTt7xqTygXX17Foy1RBV/HErC8eA=
X-Received: by 2002:a05:6a00:3993:b0:84a:46ec:3b9c with SMTP id d2e1a72fcca58-84beb43c429mr2671312b3a.31.1784206303974;
        Thu, 16 Jul 2026 05:51:43 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb856dsm1891644a12.6.2026.07.16.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:51:43 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH] rtc: pcf85363: Fix phantom device registration on missing hardware
Date: Thu, 16 Jul 2026 20:51:42 +0800
Message-ID: <20260716125142.1801599-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probe, pcf85363_load_capacitance() writes the oscillator load
capacitance configuration to the device. However, if the device is
not physically present on the bus (returning -ENXIO), the driver
only emits a warning and continues to execute the probe.

This results in the successful registration of a phantom RTC device
via devm_rtc_register_device() and its associated nvmem regions.
Consequently, userspace may attempt to bind to a non-functional
/dev/rtc node.

Propagate the I2C error back to the driver core using dev_err_probe()
to properly abort the probe and prevent phantom device registration.

Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-femtofarads property")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 drivers/rtc/rtc-pcf85363.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 540042b9eec8..5612330aff40 100644
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
-- 
2.43.0

