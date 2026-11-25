Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591985;
	b=k66l9GWhnv9ZXfChkMXC7A66SUyoA1EK4F5wUUC3Q2gPb7RCDMIxv937poPmVUeCNw6Q
	 4gLlp4i8XVbfp0eIZ93N4CWnJ4OooOrsklL/DZbH5kIfQHXHFStOqCw2MQOL0V7pJ2rao
	 EL2PxAAVY97CQctjOxocODBr9Ucc+PiPvDV31Z1xMCfd+061zgYYjDeRaWhZBCQxmfU+L
	 aOs6YPHap5BCt8f8rH35RvXZQXPzZDFyAH9VvLFaEPyACHIRTWZRjWdmAnn5YzPaAeO61
	 2wfo5tWkDBecD9Vpb2Od2r9cno7U+HA4EOue3TqgcVsl1h3si+nCbZCRXzmxRUCsrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=26MK0GGaMn5NhSQLqDIyXTkkrXtqjFVjBJeX7YJ0BPw=;
	b=mm6ZMb5aMiMngyf6iz+W7NChrKUYEEXzt1h5dNFgRhDC40lC0JI5ks+owepVJCFuQ70D
	 rJ9FNgX4COuE0k53D9EYyUxUluSpwg5lAxXrRdce1ikZjAJhSucOLR2lmPws9T1e08nye
	 BqDEwau5k/9VxaV86hPZK+luxvDLWoIPZ6VHGbY+BXffpyt3Gn7so3kCfauXX7Uqh5VS7
	 qPywvsBr2RwGQ5A7/GPXo+EiyNimFd+NvhHdByh0hQ29ncG7GW4UIQuGBtUjNbKj7BoX4
	 QXiuINP1WdZE/d7GfsKk76g7TbfVSzEQJW7ZRvRjlF90wQ4e9X/VX4dMzmqeiKpPPtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgxOzxEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB88606A336;
	Wed, 25 Nov 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgxOzxEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939C31F000EB;
	Wed, 25 Nov 2026 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591984;
	bh=26MK0GGaMn5NhSQLqDIyXTkkrXtqjFVjBJeX7YJ0BPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgxOzxEQcMMEh4T4Rs3SpSQzeQy7RDS+wM4+lsnx+luAFVAtIkYXcql8ZBXijyOJl
	 oQasXZzpszuQskhBKAwZII0Xmkesk9VigMsXDB4t72rMTcFl5HBiWDEgBkXbt7f5qE
	 JRHjON07GQMi4Yp/8ckPjYXO4n0PXE7q/MmAaKvQmKow3AXMEZV08E8ADjuUBtp471
	 3+/wIGjhHxYYtk+sgevHoKADQIQnTjkDPjE2kRaKn5KB2O8zbR090NBvyhUHuPbjf8
	 io27fyn2GhQT5AG5yiH15udW7qPUrjQ01L5Km3rMoSRzg/anl7vq1AkOXAFE3JMSD/
	 ItpeRvrE7fgBA==
Message-ID: <sashiko-outbox-232810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] rtc: pcf8523: clear the wake IRQ on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prasanth R" <ragaprasanth@gmail.com>, linux-rtc@vger.kernel.org
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125072026.2997493-11-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-11-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:33:04 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rtc: pcf8523: redundant devm wake cleanup in pcf8523_probe()
  on i2c_bus_type
--

commit 5ba5c98fa87e67c51600bf8ba44e25608c7b2cde
Author: Prasanth R <ragaprasanth@gmail.com>

rtc: pcf8523: clear the wake IRQ on unbind

This commit switches pcf8523_probe() from dev_pm_set_wake_irq() and
device_init_wakeup() to their devm-managed variants so that the wake IRQ
and wakeup source are cleared on driver unbind.

> diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
> index bbd42358a4c24..df70a374ef0ff 100644
> --- a/drivers/rtc/rtc-pcf8523.c
> +++ b/drivers/rtc/rtc-pcf8523.c
> @@ -484,12 +484,12 @@ static int pcf8523_probe(struct i2c_client *client)
>  		if (err)
>  			return err;
> =20
> -		dev_pm_set_wake_irq(&client->dev, client->irq);
> +		devm_pm_set_wake_irq(&client->dev, client->irq);
>  	}
> =20
>  	wakeup_source =3D of_property_read_bool(client->dev.of_node, "wakeup-so=
urce");
>  	if (client->irq > 0 || wakeup_source)
> -		device_init_wakeup(&client->dev, true);
> +		devm_device_init_wakeup(&client->dev);
> =20
>  	return devm_rtc_register_device(rtc);
>  }

[Severity: Medium]
Can an i2c_driver without a .remove callback actually leak its wake IRQ
or wakeup source on unbind?

On unbind, device_remove() invokes i2c_bus_type.remove
(i2c_device_remove()) even when driver->remove is NULL, and
i2c_device_remove() already clears both unconditionally:

drivers/i2c/i2c-core-base.c:i2c_device_remove() {
    ...
	devres_release_group(&client->dev, client->devres_group_id);

	dev_pm_clear_wake_irq(&client->dev);
	device_init_wakeup(&client->dev, false);
    ...
}

i2c_device_probe() performs the same cleanup at err_clear_wakeup_irq when
driver->probe() fails.  Switching to devm_pm_set_wake_irq() and
devm_device_init_wakeup() here only adds redundant devres actions right
before the I2C core repeats the same teardown.  Note also that when
"wakeup-source" is set in DT (setting I2C_CLIENT_WAKE) and
client->irq > 0, i2c_device_probe() already calls dev_pm_set_wake_irq()
before invoking pcf8523_probe(), so the "wake irq already initialized"
warning and -EEXIST happen during the initial probe rather than on
rebind.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125072026.2997=
493-1-prasanth.r@lineo.co.jp?part=3D10
