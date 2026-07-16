Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE5414A1F
	for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206812; cv=none; b=plT030fKBJRxQA1WnaX70jSE8CVVCCQ6qYRnyk61WE5nq7QpYjxv7KbGNd+eVSobAhMKWLOcIOwMyJ4WGcyhT4L/xoTGfaSbxZBXMT+zeIRfuWtqYSzTqGHLB+eY9ElShhASy/vS2yQu5PMEvKWD2FRJ7iTruHR0n8P4OookXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206812; c=relaxed/simple;
	bh=HbH6JXU5BdCZwLeEhk7WdbdqPjZRA9yLpHXpv9FF6fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qw+NIc5el791L3Ig/CaJQSbq8bjKUD5vguC4nXZRrDmIdNNmH5rfbKpcREg4ZtJzUV2B8Opj9x4bFGWsRZJnz4xFWLLnfF1G/DrqWDFkB/PQE0db8CUjJ6dFP2L36NtiSvfmwL9AxYuwKD11LxmJa1T+cYklZ0u4HI/VSF3TcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWx6Egyr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWx6Egyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BB61F000E9;
	Thu, 16 Jul 2026 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784206811;
	bh=YhwDXXPCDt6mCJSyHf4sYs1K6iKP0eoDDObYkAlec/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWx6EgyrWegc09Ra07uw778UVVZrYRbd7BHcjmRlPV2hAL9L2TjM4tboeihxcVLp+
	 XIdj5ZH4onUqRU247Vr/ukHta8NXXmHLhOL06A1AqwmVKc1CrToFPLKKa0CbTHbNjl
	 RyUbPeEfKLIAR1cqY69NIT+9wp7wX7LwkQg9B//pwlMbftyi15FF/hzpTMZ+rCsKWJ
	 rxtMiIaTqNGSZKB772K5dOlwGaC3rgoNEYqywRUGWK0HAjeTI8uyz03RdRLIiIPrIu
	 AAauTcggomG9eKScCAX1lUlv+mPVBFuZPX5yxw3N+ilJscEWWsqsKZcix4F3e8W1Nm
	 lOLct+V4SQc/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf85363: Fix phantom device registration on
 missing hardware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cosmo Chou" <chou.cosmo@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260716125142.1801599-1-chou.cosmo@gmail.com>
References: <20260716125142.1801599-1-chou.cosmo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:00:10 +0000
Message-Id: <20260716130011.66BB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `nvmem_cfg` =
array in `pcf85363_probe()` is declared `static`, causing all instances of =
the device to share the same configuration. Because its `.id` field is not =
explicitly initialized, it defaults to 0 rather than `NVMEM_DEVID_AUTO`. Th=
e NVMEM core will assign ID 0 for the first instance (e.g., "pcf85x63-0"), =
but any subsequent PCF85363 device on the same system will cause a sysfs du=
plicate name collision and fail to register. Furthermore, the driver mutate=
s this shared static structure during probe by assigning `nvmem_cfg[i].priv=
 =3D pcf85363`, and the `devm_rtc_nvmem_register()` helper further mutates =
it by assigning `nvmem_config->dev =3D dev`. If two PCF85363 devices are pr=
obed concurrently, a data race occurs where one thread may overwrite the `p=
riv` or `dev` pointers of the other before registration completes, causing =
NVMEM operations to access the wrong I2C device.
--

--- Patch [1]: [PATCH] rtc: pcf85363: Fix phantom device registration on mi=
ssing hardware ---
commit ad427522054996520ae92d70a7e73f66bf7ac5a8
Author: Cosmo Chou <chou.cosmo@gmail.com>

rtc: pcf85363: Fix phantom device registration on missing hardware

This patch prevents phantom RTC device registration if the PCF85363 device
is missing. It propagates the error back to the driver core using
dev_err_probe() to properly abort the probe instead of continuing.

> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -382,21 +382,21 @@ static int pcf85363_probe(struct i2c_client *client)
>  {
>  	struct pcf85363 *pcf85363;
>  	const struct pcf85x63_config *config =3D &pcf_85363_config;
>  	const void *data =3D of_device_get_match_data(&client->dev);
>  	static struct nvmem_config nvmem_cfg[] =3D {

[Severity: High]
This is a pre-existing issue, but since nvmem_cfg is declared static, all
instances of the device share this configuration.

Because its .id field is not explicitly initialized, it defaults to 0
rather than NVMEM_DEVID_AUTO. Doesn't this cause sysfs duplicate name
collisions if multiple PCF85363 devices are present on the system?

Furthermore, doesn't this shared static array cause a data race during
concurrent probes? The driver mutates this array later in pcf85363_probe():

drivers/rtc/rtc-pcf85363.c:pcf85363_probe() {
    ...
    for (i =3D 0; i < config->num_nvram; i++) {
        nvmem_cfg[i].priv =3D pcf85363;
        devm_rtc_nvmem_register(pcf85363->rtc, &nvmem_cfg[i]);
    ...
}

And devm_rtc_nvmem_register() further mutates it by assigning
nvmem_config->dev =3D dev.

If two PCF85363 devices are probed concurrently, could one thread overwrite
the priv or dev pointers of the other before registration completes, causing
NVMEM operations to access the wrong I2C device? Should this configuration
be dynamically allocated or copied per-device instead of being static?

>  		{
>  			.name =3D "pcf85x63-",
>  			.word_size =3D 1,
>  			.stride =3D 1,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716125142.1801=
599-1-chou.cosmo@gmail.com?part=3D1
