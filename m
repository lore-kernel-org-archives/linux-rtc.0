Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CE30DD2F
	for <linux-rtc@vger.kernel.org>; Wed, 29 Jul 2026 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292133; cv=none; b=dhWG2n++9AyUX9yPwqir9zDO/MdOMFmtMNQiISYooOFx9+5cnOUpvK3AS9pi6FshBsCgLKwUyKIstVp5fTZbi55+i83BpyK+lU7Hy8iJ3vPxFWb2T1q3ZCaXND9+K9n57n4Iq/Bt+FHk1uvC0UYYfEoMMmhEsrNLZolzVkM7/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292133; c=relaxed/simple;
	bh=2FhegKt47ICFEH1UXGpSVoGOuDutm/aPEb5p6xrPP3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2aODEJcLEuQHpRF/itvO+clCUjeUvU5xCOrrceXdk2G78r4AWLmVeulKD9U652XkBQsrc+X70Sk87uS89c+Y0Qoa/k3mzTn6kW/CDOGsANIRlYBG2t5ImtaDvFeQFydzKRNaoDruQAd/VxZAGsnWP+M3Jn0wG7g0RcGV4CrpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsvwacDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsvwacDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0961F000E9;
	Wed, 29 Jul 2026 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292130;
	bh=rCvV/DAEbMtAjBn6ahreFyZZjKZKwyXOdwVpV4s94s0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsvwacDrvLhKT5g5S3rFDx/M+1aZKqoQ56jNlIi+USu52ihf1sjlycMh2OwJzgcA1
	 l83wgbVXTELOU4c0VIDnlr8e2uzvlCgs0mWT59JTDiAuwmEUVkRLYb3MdIWs6wZ+U5
	 7FBAI60IcXzZP4cFdIIHas1qRf6zvwRcMGQ3O476+0R9nAQW82seyWfv40KWtIwaVJ
	 A2drwtCUx3WK+Selp0wyLMhZC2OgrrZHoV1831Vjjx8jorb+htszWhTZ13xpTxJNON
	 vcxvzCqyjwLcevnGRmqPnbRbgYA0rATg3TfsbUZ2UI7pfnXw6+iWCd+/c7tC2zwdTW
	 5YLBJX3FUtWbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: m41t80: clean up watchdog on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260729021812.49868-1-mhun512@gmail.com>
References: <20260729021812.49868-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:28:49 +0000
Message-Id: <20260729022850.3C0961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The clock provider registered by `m41t80_sqw_register_clk()` is ne=
ver unregistered on probe failure or device removal, leaving a dangling poi=
nter in the Common Clock Framework.
- [High] Probing multiple M41T80 devices overwrites the global `save_client=
` pointer before verifying watchdog registration success, leading to a NULL=
 pointer dereference.
- [High] Registering the watchdog misc device before probe completes allows=
 user-space to open the device, and the lack of VFS file descriptor revocat=
ion coupled with a dangling `save_client` leads to a NULL pointer dereferen=
ce.
--

--- Patch [1]: [PATCH] rtc: m41t80: clean up watchdog on registration failu=
re ---
commit 7f474c7e546e109c3aad769a8ec54e1bdf1316d0
Author: Myeonghun Pak <mhun512@gmail.com>

rtc: m41t80: clean up watchdog on registration failure

This commit unregisters the watchdog miscdevice and reboot notifier if the
RTC device registration fails during probe. This prevents leaving callbacks
tied to a device whose driver failed to bind.

> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 3c8c379392c14..3cb3f5e94f861 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -1008,8 +1008,15 @@ static int m41t80_probe(struct i2c_client *client)
>  #endif
> =20
>  	rc =3D devm_rtc_register_device(m41t80_data->rtc);
> -	if (rc)
> +	if (rc) {

[Severity: High]
This isn't a bug introduced by this patch, but does the probe error path al=
so
need to unregister the clock provider?

If devm_rtc_register_device() fails, the driver frees the devres-managed
m41t80_data. However, m41t80_sqw_register_clk() registers the clock using
non-devm functions (clk_register and of_clk_add_provider):

drivers/rtc/rtc-m41t80.c:m41t80_sqw_register_clk() {
    ...
    clk =3D clk_register(&client->dev, &m41t80->sqw);
    if (!IS_ERR(clk))
        of_clk_add_provider(node, of_clk_src_simple_get, clk);
    ...
}

Since neither this error path nor m41t80_remove() unregisters the clock,
could subsequent accesses to the clock tree (like reading
/sys/kernel/debug/clk/clk_summary) dereference the freed clk_hw and
cause a use-after-free?

[Severity: High]
This is another pre-existing issue, but is it safe to unconditionally
overwrite the global save_client pointer earlier in the probe function?

Earlier in m41t80_probe(), save_client is set before misc_register() is
confirmed to succeed:

drivers/rtc/rtc-m41t80.c:m41t80_probe() {
    ...
    save_client =3D client;
    rc =3D misc_register(&wdt_dev);
    if (rc)
        return rc;
    ...
}

If multiple M41T80 devices exist, the second probe will overwrite save_clie=
nt
but fail at misc_register() because the watchdog minor is already taken.
The driver core then clears drvdata for the failed device.

If a user-space process sends a keepalive to the working watchdog, wdt_ping=
()
will use the corrupted save_client pointing to the unbound device, fetching
a NULL clientdata. Could this cause a NULL pointer dereference in wdt_ping(=
)?

> +#ifdef CONFIG_RTC_DRV_M41T80_WDT
> +		if (m41t80_data->features & M41T80_FEATURE_HT) {
> +			unregister_reboot_notifier(&wdt_notifier);
> +			misc_deregister(&wdt_dev);

[Severity: High]
This is a pre-existing issue, but should save_client be cleared to NULL
when deregistering the watchdog?

When misc_deregister() is called here (and in m41t80_remove()), it removes
the device node but does not revoke existing open file descriptors. If
user-space has already opened /dev/watchdog before the probe fails, the
global save_client pointer is left dangling.

If user-space later writes to the open file descriptor, wdt_ping() will use
save_client to fetch clientdata:

drivers/rtc/rtc-m41t80.c:wdt_ping() {
    ...
    struct m41t80_data *clientdata =3D i2c_get_clientdata(save_client);
    ...
    if (clientdata->features & M41T80_FEATURE_WD)
    ...
}

Since the driver core clears drvdata on probe failure, clientdata will be
NULL. Does this lead to a NULL pointer dereference?

> +		}
> +#endif
>  		return rc;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729021812.4986=
8-1-mhun512@gmail.com?part=3D1
