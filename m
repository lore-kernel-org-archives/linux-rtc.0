Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278143;
	b=cRLgJ1MuvGBt53l0B4sNePh2lByy51O2oZk9O2z2BGozHN5QALdzwCdpzooIsSntx/p/
	 YSZmD6Nz077ZPgUpGv0yK4S4DXK/2UClj1RbknqKPwYnonANo4HlGf62kJ+L9EsP+mBLd
	 wyt1YMuDYIL9HPWEUTTlSVD+kFKp5VY5rH9nBsnaGj8u9ZslDMmTGOEhiBF9Itz/hWJNa
	 t+auiatsxceGE+tmcsQYoJs2e2RXZ8Y4dDU6n227mFLHtsYQotXAPt9X8IhPu/jaVgG8c
	 fS6c6Hzk1vowltIqiX5PqrYuJ6FSL9AAGsFlGkSq2wdPS0TYE4GeN6f+Qw9+NnIUV2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
	b=KH6G7YcBzRXAuqFHm/UW0vN6y9ukM/YDnU/zsamq0Bf3T60Tf7FErX+zh+jvI9jd6ioD
	 uTMJEZ8VaCrH64WBj/y3qJH8QAtUMJfiOnqZZxWxAs1QhBMc5FiMDU1lJaiPxSkJyF1BD
	 pceXK72JOnDzZIrHS/uF3fFzf+ZJ/dv0Z+ARvNCAbRnwJ6MT34LpJ/lTsRFjClcw1+EHN
	 abxHHb5CbkAFEbMY8xDvcGIuBuokiS/YDOKC8MfyOGf/wqKEglGHrFPdSggT3Q34buYiZ
	 urasKHA3DlRd9Zlb8WGuIETC4ftRTlrKnEOUiNHUE0yBJp3K0WoRppnR2MM3pokA4jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZJa/DLkb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F0606A32A
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 02:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJa/DLkb
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4697404c2bso209616566b.2
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 18:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794278141; cv=none;
        d=google.com; s=arc-20260327;
        b=dCcXkqJgio0nIPvOOzMcc/Mpf2yCriPGMXpIM+Fuv5lFFG0fT7IghdpuHj2fSqb0NH
         jmC3ktJ5hmdkCxMAvrpmjg/A4g4S914nX9Lxuo7rv4L1cT9qkxTwR4IycBb6izfLIRZo
         MTlbpL6tejG9xcK1qSjevZWFlgLDfIuQRG6s7WrK+UBrvGl5cekzDcQ6Ua//Sh4TtPLP
         IlCwXJ7zyCivh48AxPS0/Max3H3IPSL2cQ63LsF8sdyqBBkGE7IPrmOfVqATEU1QYg+V
         aBxi5CKH9cUV0PRIUVCshUvEJGT9ClYMI/szfAcnULY8inUz9gEA29JHOBL4tXwAoQi+
         JwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        fh=9wBMbZ2TMY88aEITK3Hspy0MgdPdwv5rdHcAbVOYzew=;
        b=tCfdJwnOiZybMO6aZvtJ8ExfXAQ+QUcMa3/OtpMUXPQsCDOlHhC4tmF6eWmMkj9KPS
         9r4N6tZ18dlTAcy2tMXDSQuIDEHVYyhFkGdhMtQ1ThG7X+T1thzrn75aHnaHeDb33fw1
         2qdKiSQpVctCouBwHoOS7GGjl7YDDJjs+srgcDgLmNV8BOUwq0GV9jkxT2v4sZFEi6hA
         TMt7bGiKgjftP8wlqh/cWmXgbwF8AgjZ2WG5gn7AP7w5X0GMecgTcwnO6vBNmBR+24TW
         OnwKX41aq/0RE4zCGPyoWc5fofqpjxpLFU2brMG+vi2ssO4ZBl1chd69kQTkPZrnWU0I
         XkXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278141; x=1794882941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        b=ZJa/DLkbwFK13GYxif9rrBk9ZFMepmH7kYdlzvkEiIJhXqMFFQEbBTJOa2BkwztIem
         X1tAX5wYK/JV07jx3lDJonCdEFnL0fAlA+FfEm76mlqR5zB8k/FvXPQ9OnKhfXh2gJuX
         dgWJ1jVuYiRXaOL4T6zNpkJN5SWltL/abyNxbghyyvg8/15mNS4WiLQZn0T1eWLVs/T5
         +uXmdJDZgOnwBFpuK/P6vNLzxZ9EDrhRPYN9XpJpPEU/lHdQUnH7L8MyUQ1pAKTsYAD+
         XWvnGYdcjCBiL5vf7xcaDBVnYonKkyGDkSYytToSziNyJ59kFqvXYKcjc83pSAAP23Fp
         DgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278141; x=1794882941;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        b=Vl+2df1rRzkYWCY5l07hL3FWT94I6k6ankfjtemPChuPHHnS99a22z7T6q6m0T3xw9
         rdy58qV3YOJJSx+7B2G4N69vcOi2aAvnmaIZi+sWL+XTnWCXyLdssSp91gteuS9/Qtjr
         7SI6zUBwDqnW9Fxz44Aca4Az/aypHkrSt3cOjQiYL3GdqNrR1jgbeTlArvPFV5s5RECT
         iGhycTcN5LjjjKKLnKgJA2TZDVp12LBja2HEvzCBJC2dLBHJ6fkjbb/aHHHWPbr0JnbM
         UrRmGmpeCAo+GleoR3uLTak5Bm2LgbAZyGbpHvBNf86hEgkgveHx8yATAJG83ArwvSnQ
         GSRA==
X-Forwarded-Encrypted: i=1; AL+hErGWdiATGadJILKvZt/eHMi+JsfDiHFUdn1ylZZPh8ZCnINix6Ml4/nyEsmig1fJQRobv+rlmY/o2dU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xEMqj4rRWk+H7BY7O9vmhVUfK9lXhOyvq+gpZCo7M8qucrruw
	VTQhaAhxufBmDtZdo4TO2rYiyFfJ60TshxcCXj1jLkOHWJNh+f+pIYjf2W8f4ecPN0b+tJ8Ooow
	G8teaMYcuFir6IWNmRDlbnA5RVlCCHw==
X-Gm-Gg: AYBFou0rhZPgGnUxbdPNf2D194cxVwOh2Q5QpeVRqQMTzgRUXbc/6hoW6wjTI3KdTZG
	XxL92C9bKkJNbIeWSgbAv2pMJ+VltvEX17mawjMvR+Ni6hFodstbmg5srtL5jn2pDCvpDNAaXcn
	mNI/qE1/ivLGR8Sv9WFLXE+sKwSXLrivii+bjwX8QLjsXfUxi3L33No4YF0GGy5M7jb9Qv7ougT
	/XFYIbBfxzvOGKox93XTGs6EfQqbvkAyhO7WjY/vxAhQiPoOQOEw+ZCqxmwuA3A14s356gFHQ+A
	API0Qgd9t0E1m24nRtCLgnp4jcIYcj6+Sq88pFPVMeWztNCZ5q6fr2EVrnU6MWt3NqDZxzPdUwU
	Jyo8ZkfPXtJlBev2PdbHnnsFSEx0BRtOqNXGmy+xOr6Jv4aSok7Sjict/rJIWKYzBQr1HnZeB7s
	RxiNhgk1IoVjfo/UU/vhzaC3+FK3If2X1Q5tljLO++1zWG
X-Received: by 2002:a17:906:ef01:b0:c31:8c48:e18b with SMTP id
 a640c23a62f3a-c50494b5468mr87905566b.14.1794278141251; Mon, 09 Nov 2026
 18:35:41 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:35:39 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
In-Reply-To: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Date: Tue, 10 Nov 2026 02:35:39 +0000
X-Gm-Features: AclHuK8a2vf6Kdy8AdU3IyQjeInaPjr1EXSZeWDCZfS69AY6Gnq0Va-6HMxz_ls
Message-ID: <CAGEsz8FyKXrsy2GFmBO16mTN+d0KteHk-e7QoO3VsfHdeHs79g@mail.gmail.com>
Subject: [PATCH v2 2/2] mfd: wm831x: Align child IRQ resources and lifetime
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Onkey removal and battery IRQ error cleanup free unmapped platform IRQs
instead of the requested Linux IRQs. This can leave handlers registered
after their data is freed.

Pass the IRQ domain to MFD and use mapped resources in the children.
Manage onkey IRQ/work cleanup and unwind consumers before disposing IRQ
mappings on initialization failure. Retain polling for key release.

This issue was found by our static analysis tool under development.

Fixes: cd99758ba3bd ("mfd: Convert wm831x to irq_domain")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
No hardware testing.

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 891f498ea..f8e49ac27 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 #include <linux/mfd/wm831x/core.h>

 struct wm831x_on {
@@ -72,9 +73,12 @@ static int wm831x_on_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_on *wm831x_on;
-	int irq = wm831x_irq(wm831x, platform_get_irq(pdev, 0));
+	int irq = platform_get_irq(pdev, 0);
 	int ret;

+	if (irq < 0)
+		return irq;
+
 	wm831x_on = devm_kzalloc_obj(&pdev->dev, struct wm831x_on);
 	if (!wm831x_on) {
 		dev_err(&pdev->dev, "Can't allocate data\n");
@@ -82,13 +86,11 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	}

 	wm831x_on->wm831x = wm831x;
-	INIT_DELAYED_WORK(&wm831x_on->work, wm831x_poll_on);

 	wm831x_on->dev = devm_input_allocate_device(&pdev->dev);
 	if (!wm831x_on->dev) {
 		dev_err(&pdev->dev, "Can't allocate input dev\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}

 	wm831x_on->dev->evbit[0] = BIT_MASK(EV_KEY);
@@ -96,43 +98,28 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	wm831x_on->dev->name = "wm831x_on";
 	wm831x_on->dev->phys = "wm831x_on/input0";

-	ret = request_threaded_irq(irq, NULL, wm831x_on_irq,
-				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				   "wm831x_on",
-				   wm831x_on);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
-		goto err_input_dev;
-	}
 	ret = input_register_device(wm831x_on->dev);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Can't register input device: %d\n", ret);
-		goto err_irq;
+		return ret;
 	}

-	platform_set_drvdata(pdev, wm831x_on);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &wm831x_on->work,
+					   wm831x_poll_on);
+	if (ret)
+		return ret;

-	return 0;
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, wm831x_on_irq,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"wm831x_on", wm831x_on);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Unable to request IRQ\n");

-err_irq:
-	free_irq(irq, wm831x_on);
-err_input_dev:
-err:
-	return ret;
-}
-
-static void wm831x_on_remove(struct platform_device *pdev)
-{
-	struct wm831x_on *wm831x_on = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-
-	free_irq(irq, wm831x_on);
-	cancel_delayed_work_sync(&wm831x_on->work);
+	return 0;
 }

 static struct platform_driver wm831x_on_driver = {
 	.probe		= wm831x_on_probe,
-	.remove		= wm831x_on_remove,
 	.driver		= {
 		.name	= "wm831x-on",
 	},
diff --git a/drivers/input/touchscreen/wm831x-ts.c
b/drivers/input/touchscreen/wm831x-ts.c
index 32b03889a..3651c2cd4 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -255,14 +255,11 @@ static int wm831x_ts_probe(struct platform_device *pdev)
 	 * If we have a direct IRQ use it, otherwise use the interrupt
 	 * from the WM831x IRQ controller.
 	 */
-	wm831x_ts->data_irq = wm831x_irq(wm831x,
-					 platform_get_irq_byname(pdev,
-								 "TCHDATA"));
+	wm831x_ts->data_irq = platform_get_irq_byname(pdev, "TCHDATA");
 	if (pdata && pdata->data_irq)
 		wm831x_ts->data_irq = pdata->data_irq;

-	wm831x_ts->pd_irq = wm831x_irq(wm831x,
-				       platform_get_irq_byname(pdev, "TCHPD"));
+	wm831x_ts->pd_irq = platform_get_irq_byname(pdev, "TCHPD");
 	if (pdata && pdata->pd_irq)
 		wm831x_ts->pd_irq = pdata->pd_irq;

diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
index 6280d4f38..e3357918b 100644
--- a/drivers/mfd/wm831x-auxadc.c
+++ b/drivers/mfd/wm831x-auxadc.c
@@ -285,3 +285,10 @@ void wm831x_auxadc_init(struct wm831x *wm831x)
 	if (!wm831x->auxadc_read)
 		wm831x->auxadc_read = wm831x_auxadc_read_polled;
 }
+
+void wm831x_auxadc_exit(struct wm831x *wm831x)
+{
+	if (wm831x->auxadc_read == wm831x_auxadc_read_irq)
+		free_irq(irq_find_mapping(wm831x->irq_domain,
+					  WM831X_IRQ_AUXADC_DATA), wm831x);
+}
diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index df8e76e00..008e19f33 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -662,14 +662,6 @@ static const struct resource
wm8320_dcdc4_buck_resources[] = {
 	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC4, "UV"),
 };

-static const struct resource wm831x_gpio_resources[] = {
-	{
-		.start = WM831X_IRQ_GPIO_1,
-		.end   = WM831X_IRQ_GPIO_16,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
 static const struct resource wm831x_isink1_resources[] = {
 	{
 		.start = WM831X_CURRENT_SINK_1,
@@ -876,8 +868,6 @@ static const struct mfd_cell wm8310_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1030,8 +1020,6 @@ static const struct mfd_cell wm8311_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1160,8 +1148,6 @@ static const struct mfd_cell wm8312_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1306,8 +1292,6 @@ static const struct mfd_cell wm8320_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1622,27 +1606,27 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	case WM8310:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8310_devs, ARRAY_SIZE(wm8310_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8311:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8311_devs, ARRAY_SIZE(wm8311_devs),
-				      NULL, 0, NULL);
-		if (!pdata->disable_touch)
-			mfd_add_devices(wm831x->dev, wm831x_num,
-					touch_devs, ARRAY_SIZE(touch_devs),
-					NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
+		if (!ret && !pdata->disable_touch)
+			ret = mfd_add_devices(wm831x->dev, wm831x_num,
+					      touch_devs, ARRAY_SIZE(touch_devs),
+					      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8312:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8312_devs, ARRAY_SIZE(wm8312_devs),
-				      NULL, 0, NULL);
-		if (!pdata->disable_touch)
-			mfd_add_devices(wm831x->dev, wm831x_num,
-					touch_devs, ARRAY_SIZE(touch_devs),
-					NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
+		if (!ret && !pdata->disable_touch)
+			ret = mfd_add_devices(wm831x->dev, wm831x_num,
+					      touch_devs, ARRAY_SIZE(touch_devs),
+					      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8320:
@@ -1651,7 +1635,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	case WM8326:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8320_devs, ARRAY_SIZE(wm8320_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		break;

 	default:
@@ -1676,7 +1660,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	if (ret & WM831X_XTAL_ENA) {
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      rtc_devs, ARRAY_SIZE(rtc_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		if (ret != 0) {
 			dev_err(wm831x->dev, "Failed to add RTC: %d\n", ret);
 			goto err_irq;
@@ -1689,7 +1673,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 		/* Treat errors as non-critical */
 		ret = mfd_add_devices(wm831x->dev, wm831x_num, backlight_devs,
 				      ARRAY_SIZE(backlight_devs), NULL,
-				      0, NULL);
+				      0, wm831x->irq_domain);
 		if (ret < 0)
 			dev_err(wm831x->dev, "Failed to add backlight: %d\n",
 				ret);
@@ -1708,7 +1692,10 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	return 0;

 err_irq:
+	mfd_remove_devices(wm831x->dev);
+	wm831x_auxadc_exit(wm831x);
 	wm831x_irq_exit(wm831x);
+	return ret;
 err:
 	mfd_remove_devices(wm831x->dev);
 	return ret;
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index defd5f173..200802612 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -595,6 +595,8 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)

 	if (!domain) {
 		dev_warn(wm831x->dev, "Failed to allocate IRQ domain\n");
+		if (irq_base)
+			irq_free_descs(irq_base, WM831X_NUM_IRQS);
 		return -EINVAL;
 	}

@@ -606,10 +608,20 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 	wm831x_set_bits(wm831x, WM831X_IRQ_CONFIG,
 			WM831X_IRQ_OD, i);

-	wm831x->irq = irq;
 	wm831x->irq_domain = domain;

 	if (irq) {
+		ret = request_threaded_irq(irq, NULL, wm831x_irq_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   "wm831x", wm831x);
+		if (ret != 0) {
+			dev_err(wm831x->dev, "Failed to request IRQ %d: %d\n",
+				irq, ret);
+			wm831x_irq_exit(wm831x);
+			return ret;
+		}
+		wm831x->irq = irq;
+
 		/* Try to flag /IRQ as a wake source; there are a number of
 		 * unconditional wake sources in the PMIC so this isn't
 		 * conditional but we don't actually care *too* much if it
@@ -620,15 +632,8 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 			dev_warn(wm831x->dev,
 				 "Can't enable IRQ as wake source: %d\n",
 				 ret);
-		}
-
-		ret = request_threaded_irq(irq, NULL, wm831x_irq_thread,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   "wm831x", wm831x);
-		if (ret != 0) {
-			dev_err(wm831x->dev, "Failed to request IRQ %d: %d\n",
-				irq, ret);
-			return ret;
+		} else {
+			wm831x->irq_wake = true;
 		}
 	} else {
 		dev_warn(wm831x->dev,
@@ -643,6 +648,15 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)

 void wm831x_irq_exit(struct wm831x *wm831x)
 {
-	if (wm831x->irq)
+	int i;
+
+	if (wm831x->irq) {
+		if (wm831x->irq_wake)
+			disable_irq_wake(wm831x->irq);
 		free_irq(wm831x->irq, wm831x);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm831x_irqs); i++)
+		irq_dispose_mapping(irq_find_mapping(wm831x->irq_domain, i));
+	irq_domain_remove(wm831x->irq_domain);
 }
diff --git a/drivers/power/supply/wm831x_power.c
b/drivers/power/supply/wm831x_power.c
index d4e85c233..c5914f13d 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -616,7 +616,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		}
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	ret = request_threaded_irq(irq, NULL, wm831x_syslo_irq,
 				   IRQF_TRIGGER_RISING | IRQF_ONESHOT, "System power low",
 				   power);
@@ -626,7 +626,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		goto err_battery;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	ret = request_threaded_irq(irq, NULL, wm831x_pwr_src_irq,
 				   IRQF_TRIGGER_RISING | IRQF_ONESHOT, "Power source",
 				   power);
@@ -637,9 +637,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	}

 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
-		irq = wm831x_irq(wm831x,
-				 platform_get_irq_byname(pdev,
-							 wm831x_bat_irqs[i]));
+		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		ret = request_threaded_irq(irq, NULL, wm831x_bat_irq,
 					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					   wm831x_bat_irqs[i],
@@ -686,10 +684,10 @@ static int wm831x_power_probe(struct
platform_device *pdev)
 		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		free_irq(irq, power);
 	}
-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	free_irq(irq, power);
 err_syslo:
-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	free_irq(irq, power);
 err_battery:
 err_usb:
@@ -701,7 +699,6 @@ static int wm831x_power_probe(struct platform_device *pdev)
 static void wm831x_power_remove(struct platform_device *pdev)
 {
 	struct wm831x_power *wm831x_power = platform_get_drvdata(pdev);
-	struct wm831x *wm831x = wm831x_power->wm831x;
 	int irq, i;

 	if (wm831x_power->usb_phy) {
@@ -710,16 +707,14 @@ static void wm831x_power_remove(struct
platform_device *pdev)
 	}

 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
-		irq = wm831x_irq(wm831x,
-				 platform_get_irq_byname(pdev,
-							 wm831x_bat_irqs[i]));
+		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		free_irq(irq, wm831x_power);
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	free_irq(irq, wm831x_power);

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	free_irq(irq, wm831x_power);
 }

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 2036735f0..5ce7cbb36 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -470,7 +470,7 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -481,7 +481,7 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "HC"));
+	irq = platform_get_irq_byname(pdev, "HC");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_oc_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -608,7 +608,7 @@ static int wm831x_buckp_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -726,7 +726,7 @@ static int wm831x_boostp_probe(struct platform_device *pdev)
 		return ret;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 5afd3094b..5c1cbaf66 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -160,7 +160,7 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq(pdev, 0));
+	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_isink_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index 34a6d6cf7..7c91edb3f 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -279,7 +279,7 @@ static int wm831x_gp_ldo_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_ldo_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -490,7 +490,7 @@ static int wm831x_aldo_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_ldo_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 1943cb1eb..35b09747d 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -402,7 +402,7 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_rtc *wm831x_rtc;
-	int alm_irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "ALM"));
+	int alm_irq = platform_get_irq_byname(pdev, "ALM");
 	int ret = 0;

 	wm831x_rtc = devm_kzalloc_obj(&pdev->dev, *wm831x_rtc);
diff --git a/include/linux/mfd/wm831x/core.h b/include/linux/mfd/wm831x/core.h
index 511bcad87..0e34a39b6 100644
--- a/include/linux/mfd/wm831x/core.h
+++ b/include/linux/mfd/wm831x/core.h
@@ -368,6 +368,7 @@ struct wm831x {
 	enum wm831x_parent type;

 	int irq;  /* Our chip IRQ */
+	bool irq_wake;
 	struct mutex irq_lock;
 	struct irq_domain *irq_domain;
 	int irq_masks_cur[WM831X_NUM_IRQ_REGS];   /* Currently active value */
@@ -418,6 +419,7 @@ void wm831x_device_shutdown(struct wm831x *wm831x);
 int wm831x_irq_init(struct wm831x *wm831x, int irq);
 void wm831x_irq_exit(struct wm831x *wm831x);
 void wm831x_auxadc_init(struct wm831x *wm831x);
+void wm831x_auxadc_exit(struct wm831x *wm831x);

 static inline int wm831x_irq(struct wm831x *wm831x, int irq)
 {


On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> Hi Lee and Dmitry,
>
> This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> The provider and consumers are converted together to keep their IRQ
> resources consistent.
>
> Changes since v1:
> - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> - Move IRQ mapping into MFD and update all platform consumers.
> - Reject failed mappings and unwind consumers before removing the domain.
> - Retain polling for release detection; the chip only interrupts on assertion.
> - Drop the previous Reviewed-by tag because the implementation changed
>   substantially.
>
> Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> No hardware testing.
>
> Previous discussion:
> https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
>
> Thanks,
> Myeonghun
