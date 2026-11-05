Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876499;
	b=yLq3AN4dpRU5nFzqmUcFwjOdtqX4Uq3DNa9N+OhH9VuQCFz0omvKiVA6J7eGPdwXL2AQ
	 zozstnUNu1uH5bdzc5CTf6ZB9p5FvaDBTYucH7Wjju+i48nByUPSDcRsVHUryhJtt0dn6
	 /KljL7I6q10UACY3jjIG/h2UqVOfcyLKKKZ9MYM+th/69i17IF/F3qbgjUF/Dh82Rs9+E
	 0cX01PFrLwEAvMIncDcmh5NDWLeHeTQIHwrlheE88Zw2z0xFfgYCzazJEXOoUnjRCTFVc
	 gQgwZE/c946fxin8jIwr92fdEkGJ84g51fyb5bR1PU5wrQXLc4G/Zp4wxEGE8dJWeqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dbDRw4uqHavJ/nEvmipQvx575OH66YpP5vvkLcqfqp0=;
	b=UH9fISsIBLFdYM7hGS43gmcXUJgabNPE2h2U5G5zOi0DTCtjSbkVzPIQ85wt4xCzkqQL
	 T893XzwRaBmuodsjJjLwProZL+lZzjeC3C+i/BxZmv94rVDlIMPIkO/q1GSkGNvddmlIv
	 q6UEyPBSqKxfiqpW/ZXKXE9aq54kWjNQzp2IY0ia2BIxfqigKlSALrDtdvL8dC1s+sYuA
	 IsjYeo5r/AlX5NN+4zDZZcnN4dT14DtkOMiLd8Nu3jOfboyabphfjSrbiNdmwDtiNApth
	 TD+wq699DvQqvZecAu5nJq0VbIcHHn8YCZOzV56Rgre9InD2cPE4CnVTxtCt0JnU08w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvCT6eBV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2B606A329
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvCT6eBV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72771F000C1;
	Thu,  5 Nov 2026 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876498;
	bh=dbDRw4uqHavJ/nEvmipQvx575OH66YpP5vvkLcqfqp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvCT6eBVIBXIv8aY2OhJADj0r/stHCE+tCsRNjn8SQcaN7Q2cYJd9HJ9OiNoxi3MK
	 G4knBIRhWN8vp/vTJ9HD+eIiyasTBjDaeua6Rku0xUYUmGhksn9kU7G3aLKJIGLuVH
	 oPQCYt35U18RT7Vep2/LFP1QZ6wcFV+f8t/HZ5o2cyPqycz/CZ63qBM1qelYZoz3FB
	 8nyv/sxmbgZOfjDaTh0D0kadbRoCf/re3UMpxrAAQgoWLmSs7uwdYH/V5ukwgWo6Mr
	 bgaSpOfvu+qvCZtiTj1R+aovlKof49eJtTM4/sQBwJqVLp0zAcJ2A15DQktoswOanu
	 SSAIal3NWACjg==
Message-ID: <sashiko-outbox-198902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: test: cancel the alarm timer on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: mimo-4@ilands.app, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <010101a1ab5812b4-c8329a38-bb41-40db-99e9-b4661c9c7c66-000000@us-west-2.amazonses.com>
References: <010101a1ab5812b4-c8329a38-bb41-40db-99e9-b4661c9c7c66-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:01:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: test: timer_delete_sync() in test_remove() races with alarm r=
e-arming
--

commit 4195cfecb06de73a63ad94418a4fd408e93e1c16
Author: mimo-4@ilands.app <mimo-4@ilands.app>

rtc: test: cancel the alarm timer on remove

This commit adds a platform driver remove callback to cancel the emulated
alarm timer when the rtc-test device is removed.

> diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
> index 94f995febe5b4..1095fa2de4fb1 100644
> --- a/drivers/rtc/rtc-test.c
> +++ b/drivers/rtc/rtc-test.c
> @@ -141,8 +141,16 @@ static int test_probe(struct platform_device *plat_d=
ev)
>  	return devm_rtc_register_device(rtd->rtc);
>  }
> =20
> +static void test_remove(struct platform_device *plat_dev)
> +{
> +	struct rtc_test_data *rtd =3D platform_get_drvdata(plat_dev);
> +
> +	timer_delete_sync(&rtd->alarm);
> +}

[Severity: High]
Can rtd->alarm be re-armed after timer_delete_sync() returns in
test_remove()?

In test_probe(), the RTC device is registered via
devm_rtc_register_device(rtd->rtc), which queues devm_rtc_unregister_device=
()
as a devres action. During driver detach, device_remove() runs test_remove()
before device_unbind_cleanup() runs devres_release_all():

__device_release_driver()
  device_remove()
    test_remove()
      timer_delete_sync(&rtd->alarm);
  device_unbind_cleanup()
    devres_release_all()
      devm_rtc_unregister_device()

When test_remove() calls timer_delete_sync(&rtd->alarm),
devm_rtc_unregister_device() has not yet cleared rtd->rtc->ops or removed t=
he
character device and sysfs attributes:

drivers/rtc/class.c:devm_rtc_unregister_device() {
	mutex_lock(&rtc->ops_lock);
	rtc_proc_del_device(rtc);
	if (!test_bit(RTC_NO_CDEV, &rtc->flags))
		cdev_device_del(&rtc->char_dev, &rtc->dev);
	rtc->ops =3D NULL;
	mutex_unlock(&rtc->ops_lock);
}

In addition, if test_rtc_alarm_handler() fired just before
timer_delete_sync(), rtc_update_irq() schedules rtd->rtc->irqwork
(rtc_timer_do_work()), which can still be pending or running and call
__rtc_set_alarm() -> test_rtc_set_alarm():

drivers/rtc/rtc-test.c:test_rtc_set_alarm() {
	...
	if (alrm->enabled)
		add_timer(&rtd->alarm);
	...
}

Because timer_delete_sync() does not prevent the timer from being re-armed,=
 a
concurrent ioctl on /dev/rtcN, a write to sysfs wakealarm, or
rtc_timer_do_work() reprogramming an alarm before devm_rtc_unregister_devic=
e()
runs can call test_rtc_set_alarm() or test_rtc_alarm_irq_enable() and re-qu=
eue
rtd->alarm just before devres frees rtd.

Would registering the timer cleanup via devm_add_action_or_reset() before
devm_rtc_register_device(rtd->rtc), or using timer_shutdown_sync(), avoid
this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a1ab5812b4-c8=
329a38-bb41-40db-99e9-b4661c9c7c66-000000@us-west-2.amazonses.com?part=3D1
