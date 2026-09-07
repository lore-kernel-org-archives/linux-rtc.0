Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4130ACE3;
	Mon,  7 Sep 2026 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813996; cv=none; b=kF8gbk370WrB0zRxgr59J31x4wBdIIXpuaz0n0+XcFVlkOz2Saidw9AmkWHinT4szvWBd4PqkU1ZdJqzWqiJNcwAoKu4HfvToSqrbeopflFKk7yHGH30yznyXBwKQWn+4CDjb3gd/Kdwyvab/s/BhVZgXFlYgrEHinOnmJdDRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813996; c=relaxed/simple;
	bh=AjzKRQgMj9wrWmjVYIds5dWKw4zTN6BxTudHVoVQ3+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKtq0MQA0elOfE6xRYch8e3qe5A3P29MRWz18MFqFhnn8/pMmP0vQvbGrcvd68dZMCQ8Rrol6B5W1YXeCFHvanKHGTSSOokdOX8iNcMzJttT3aJHZmtXaLCuILkjlIs1oj9IDijQrSXMZyJDtRsy5ildlDlFXBG+WZjFTweKgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVoD618C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVoD618C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7C11F00A3A;
	Mon,  7 Sep 2026 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813994;
	bh=7Vc6p29OXZqfyqEO6Py/MR/NEOHrMxTC7fsS0iiob7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dVoD618CCRn4Acd8LtAoAGhCSDNwUl1q5iE5UOTf6d2OF+l2AtH3PbMGKF6EwdUQd
	 mWbTWiDPGi2AQaaZXMNMyddDsPWC/4KDOD75qAe69nHhENIrPMem3YmXLqQSQaGrtW
	 FcF8e35LRXac+IOBqW0umc6yMUiagetuhQ0pP/nKwWBvkRUqPHjbI/plz9/tGZmqMR
	 kqCg6MVAhJyo7f192Jjk1OlzJMz2Dz/1hgNZGR6qs1/KV2oKRG1LRipxzl/q802Noy
	 s898UU8axsbNsm7A6cJyCaVXza3HHmWaW/yM+fbfDVkTvd+5Q7NrP/lSZrswhk2RD7
	 mRNCE0IxsPcyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] rtc: abx80x: add mutex protection for register
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907203216.53192-4-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:46:33 +0000
Message-Id: <20260907204634.2A7C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete mutex protection allows concurrent I2C reads to break c=
onfiguration key sequences.
--

commit c33d071aef97a2d9a731cf3e557a1cf0fbf7c50c
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add mutex protection for register writes

The ABX80X RTC driver performs multi-step register operations such as
NVMEM transfers or register writes preceded by a configuration key
write. Add a mutex to serialize all the register writes to protect
these sequences against race conditions.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index e4fd7b5d4b110..44de234efecf7 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -445,6 +458,7 @@ static ssize_t oscillator_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev->parent);
> +	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	int retval, flags, rc_mode =3D 0;
> =20
>  	if (strncmp(buf, "rc", 2) =3D=3D 0) {
> @@ -456,6 +470,8 @@ static ssize_t oscillator_store(struct device *dev,
>  		return -EINVAL;
>  	}
> =20
> +	guard(mutex)(&priv->lock);
> +

[Severity: High]
This isn't a bug introduced by this patch, but since this commit aims to
protect configuration key sequences from race conditions, does this leave a
similar race open for concurrent I2C reads?

If Thread A executes a protected write sequence (like oscillator_store), and
Thread B executes an RTC read operation, can Thread B's I2C read interleave
and reset the configuration key?

For example, abx80x_rtc_read_time() does not take priv->lock while reading
the ABX8XX_REG_HTH registers.

Similarly, abx80x_is_rc_mode() (called from sysfs and read_time) performs an
unlocked read of the ABX8XX_REG_OSS register.

The ABX8XX chip specification dictates that any intervening I2C read resets
the configuration key. This would leave the register locked, causing Thread
A's subsequent protected register write to silently fail without returning
an error to userspace.

Should priv->lock be taken during these read paths as well to fully prevent
I2C interleaving from aborting configuration key writes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D3
