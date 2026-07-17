Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCB33AD88
	for <linux-rtc@vger.kernel.org>; Fri, 17 Jul 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317474; cv=none; b=CPT2PRIn7HRLXPKvhN1xQyAd3zBw8WfotNITzbEJx7p7ub08fp0iZ9wxZvP/iJVYCpRNNjJsqbC2FeqV//vB2MrOGxgORDutY6E5eCVXGJ6Qxs6ChetuEjD2pP8/mlirJ74eAdJ9UkbwzqCi5kmTN+EzLCerW6XJQ/Wd0aOy650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317474; c=relaxed/simple;
	bh=XvuBbQvXp5gH6G4gF1EMct2HhVaGvsVnqck6vX6SNm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTYPPsfM5zZdel+OMaaBVnnMUwV44cTHsFWyCKvQzL0AN+bKbOGg2dTfOt90zsd8IwlVSfaS6IFLV8Ec15IqpHSZ+fhP0BwUjn1menG+N/1mUc9gp2SUQvANCXYn3QwJiC9JmgEkw5ADsCLRfNnFP7jiSuYVvE9L39r0Jsof0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHdNyvVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHdNyvVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF211F000E9;
	Fri, 17 Jul 2026 19:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784317473;
	bh=Q9lkKv5rqCNZZgsxcpJGe5mhMQUEGFriQIzwVUHm10w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHdNyvVi+hCaG9/dxXiOEcxtm9ur/GOUCbltO+dkNSM45ptp9+9BuqhaD7i4ZxCr4
	 cYMOwWbTPWYZQz+V21K0WWVpvbETeILC7UWQ0/Vtc9oKYLN5B1mDcUIn4yQsxKMtAi
	 iZDpRhjFOdz90fvBsCFVIb0N5Tjppw2D/9lR6Z5/i6n7CB46nkeIXhZaLOduPUMkWA
	 CB338EUKkZVmcWgQousMHrPWfuNdOU7ydX6jkMNHOfE8TLpojpi+07JHR2RMeKaW4/
	 QIbw8HRgs9uxBZJ569Nwvy+B+vkwbEgq+aD57TeIJDfpwIwFXSVpFDliltp8Q8mDrh
	 a6dWTszqetldg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: pcf85363: Add error checking to regmap calls in
 probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cosmo Chou" <chou.cosmo@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260717193705.2003175-1-chou.cosmo@gmail.com>
References: <20260717193705.2003175-1-chou.cosmo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:44:32 +0000
Message-Id: <20260717194433.0DF211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent probes modify a shared static nvmem_config array withou=
t synchronization, which can lead to memory corruption or use-after-free vu=
lnerabilities.
--

--- Patch [1]: [PATCH v2] rtc: pcf85363: Add error checking to regmap calls=
 in probe() ---
commit 5bd0f6fb9671f5eeb0aea5f9e2154781ed668ff5
Author: Cosmo Chou <chou.cosmo@gmail.com>

rtc: pcf85363: Add error checking to regmap calls in probe()

This commit propagates errors from unchecked regmap operations in the
probe() function using dev_err_probe() to prevent registering a
non-functional RTC device on I2C transport errors.

Link: https://lore.kernel.org/linux-rtc/20260716125142.1801599-1-chou.cosmo=
@gmail.com/

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 540042b9eec8f..ccc7834e57599 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client)
=20
 	err =3D pcf85363_load_capacitance(pcf85363, client->dev.of_node);
 	if (err < 0)
-		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
-			 err);
+		return dev_err_probe(&client->dev, err,
+				     "failed to set xtal load capacitance\n");

[Severity: High]
This is a pre-existing issue, but since you are modifying the probe functio=
n,
could we look at a potential data race with the nvmem configuration?

In drivers/rtc/rtc-pcf85363.c:pcf85363_probe(), the nvmem_cfg array is
declared as static:

static int pcf85363_probe(struct i2c_client *client)
{
        ...
        static struct nvmem_config nvmem_cfg[] =3D {
                {
                        .name =3D "pcf85x63-",
                        ...
                },
        };

Later in the function, this globally shared array is mutated to set a=20
per-instance priv pointer:

        for (i =3D 0; i < config->num_nvram; i++) {
                nvmem_cfg[i].priv =3D pcf85363;
                devm_rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
        }

If multiple instances of this device probe concurrently, can one instance
overwrite the priv and dev pointers of another instance? This might result
in one NVMEM device silently using the regmap and parent device of the
other instance, potentially leading to use-after-free and memory corruption
if the other device is unbound.

> =20
>  	pcf85363->rtc->ops =3D &rtc_ops;
>  	pcf85363->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717193705.2003=
175-1-chou.cosmo@gmail.com?part=3D1
