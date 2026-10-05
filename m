Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F24BA1D8
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232110; cv=none; b=VvWJrwsroj7IEBu6fpwdfKqKR+rDkS0aQ+F6aNzaD4cP8X2qZbY6wW0PPzIKXfq99xZCFY0agWHDeMHTR2/aZzSz6ouuiIM40nIciA7WQVmLtYu2BIZvTuDDSGFlJNEK+PezsSMlTJcoh2ch53iSASTMgLuqssI65+tWGwbIgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232110; c=relaxed/simple;
	bh=t5uHcWG2fEqeLYYeHJcY17uSk+4BZ4G6OSSXFcdnRnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In1w7VQYfSqsNq3Pm9da54m1bZbYF7nZDrSwCENCsdfzctgJzO/IezoE8VFXietplLcf7AI8WfT9xySOZzxpaVu7HivCEkViKM7AsGJY2KOZ1xYsFwy7r1NX3p37VP9rQSjRQgHRv4slCHc45G310FvfaMGC0wP5suWgNdUd/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOxo0BQq; arc=none smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOxo0BQq"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso2835272a12.0
        for <linux-rtc@vger.kernel.org>; Mon, 05 Oct 2026 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791232099; x=1791836899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lAdfxofOjXBbqsp0/iF1q0AKoAn+osrW0QUEeXjGUM=;
        b=oOxo0BQqDtZIVCW6SDp8y+oibA9DEK5ggW6SAT7pGmuwMObyPeLE1rxHxx4guo48iE
         PHgXbfJOY8s8A+3rwUGtOoYVOQG7xkqPEg1PRNZ6WqNsT14ggPrBbxit/9nR4X/fnMLV
         sY7UMvdooJwH5t7ICDPDyDzdVo5LpmTB9WtsljX5ycHQGxwr3RS/8HwXBM7VBVtqH8FE
         BF14XzfFt2gonrvaEzh1Z8tRGleZIcgyr9UPKeYeEHgSB0o27NEGZs9GZmHVuWv+WjyR
         +ZynH/0Du2gi2exiCUApf4waj1JG3NcOsnzfIFOQsvLqOsm/X4P8PXwUHQ0sr4/Fm5ru
         BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791232099; x=1791836899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lAdfxofOjXBbqsp0/iF1q0AKoAn+osrW0QUEeXjGUM=;
        b=so14/TguT0htF3MLyI84+dlS0BWzsGR3GRrNj8xfO0HDUwVKTUhP+MgWZ9pEmsvng6
         zOR7/w0B8SIIVdkusdc+z3jIej9Fdsda55TqX3uzoJZkkXSwrwV4Lq5RmVS9eEzKt4xo
         rbCg17w9SQJ9GEYCTRBOwDharVWwJu9hvtUphq9KDwnL7Uzll//v3Peb5jVTc+QGuMVn
         6P2ybIePZ2bnvrIJjno5hwJvnSuwMBpDvIt6g5cDVX5WnOnCqCEt4Tfv9rg7o8W7AvAA
         /VoQeZU/EpX4D5m4Ud9NVaKr4vKQTJvnoOmJB3ZrFx4o5U91SCZcpmWjAA+ab134iisC
         yQhw==
X-Forwarded-Encrypted: i=1; AKwUvBwxsen9PGRR7jSsnj6XjQNqjZwVJHq3oTzv+m0fcwGFc5wEICk2GFimRXbaz8PN8TQaRJZEKmHcql8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+6EW/lqxEpEBKLvkC70tDTJu9jcLCVVTJxpiYW3jvCW66XCEo
	gFPz3iL8OwAGcuzbd9m04me7EjuCJVfcTN4TwAKK/fAOGEKTdGxsv325quLhkEBfL3wytQ==
X-Gm-Gg: AYBFou2ejlHBtw1pGqOM7WeNHgxl1jgfH1WJ5vNBBinTE/Lgt6VzygHxXBGutcsf3ki
	aC3M7azlMEZjTmDdQazRS9+ztUDDlCoe0fO6NIovukAPRmJ/yPL/PP2EAyWUsGhZV05PGVKyS3W
	7p1DWTQvKNm3OmNeGBHhOfEPZrG3ykGpa2fzzq2h+tt9YaVNvP1QZWRUVkalSjZ0a2Dv68RRBvD
	YS0uwvdpzUBt1wmefRGXQkL2JlMFvUldUo/kwb2iq3qooqpD0QyOgP61akM+ro2wEAVzphOgXnd
	A7D4jdQDIF8QWgx4+9WpxrJdcJ9HLteR+HrKbM7U+YYh4SNOzaKALev6URw5EifZ9SryCEbJWc/
	2GIAz/1Cqo/KkbA8Pb3umiOpx4TRy6XqCyiCl08vlihxw1hZ942x3psbOrRwf4DWAzKnOCI4zjt
	YD/QF7CgE1qWticlvCj5vnzta63Uf+Lj7rRT1Dh2YkHL57ggrDb7jOTlIIIXYAGPLtZ+xVxMwBz
	lpl2ygVjQb5htJihIa2mnzP967QA3REwQ==
X-Received: by 2002:a05:6402:3905:b0:6ac:73f8:2e5a with SMTP id 4fb4d7f45d1cf-6af9e3002b7mr10742942a12.41.1791232099075;
        Mon, 05 Oct 2026 13:28:19 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e572asm3801024a12.13.2026.10.05.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:28:18 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 06/11] rtc: sun6i: add Allwinner B288 compatible
Date: Mon,  5 Oct 2026 21:27:26 +0100
Message-ID: <20261005202731.153971-7-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005202731.153971-1-pmazzini@gmail.com>
References: <20261005202731.153971-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver only uses one alarm interrupt, so no functional change.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7fc60880e409..cd6ac5bb20cd 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -859,6 +859,7 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ .compatible = "allwinner,sun8i-a23-rtc" },
+	{ .compatible = "allwinner,sun8i-b288-rtc" },
 	{ .compatible = "allwinner,sun8i-h3-rtc" },
 	{ .compatible = "allwinner,sun8i-r40-rtc" },
 	{ .compatible = "allwinner,sun8i-v3-rtc" },
-- 
2.52.0

