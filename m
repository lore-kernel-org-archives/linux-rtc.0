Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB53ABD80;
	Sat, 29 Aug 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013940; cv=none; b=nyZrplHrtL/jymjAjom0FA2zG4baf2ikVt8e2Xg/oODc9JFxQC78OqfRguPvIzN9mFNU+25Lc6ZCdr47kduQTSh9gey5Qh69HOEjl91dK57oIoT3PQSLAykNffelkc0utt8lll0eHq2H/MggmerExaG8GQEZZyUvKWgdTjaMfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013940; c=relaxed/simple;
	bh=qjjEDy4ITR3035lHjKds+INeoiX8UIMAGC2B4Bwjvvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PK1/jhttKa26/kGd5UsbFKHPhHgnV258SzNJOFabn1p4cCQptL14yz2M61GvyvNPakoHVw0I8sHYLPipH51zGDScQFxLGf+XzULWX2CXZLwCBn39bWY6MwxYmWbUB3CHgs5Zmon/3Oo5kXYe4rPsBAhK7AO6r3km9xUDbwPmu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8urLXSc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8urLXSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC11F00A3D;
	Sat, 29 Aug 2026 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788013937;
	bh=GPGk9ZXQQTGsIDscmLvAorN0XqWaRLlg7zuFO/W0Qbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8urLXScoMZ/Befol4Q1BPvpp2BQsZ98yhLcb9badfydpJxdrZOzVJFDnJcMviENC
	 hjUqmcej/0QxeXXCwK/08q/adnk1QtUsU2OpWU/BLZPsk7TTnUlfV3Zd5gv34tem59
	 nIYVN4cLPfntrjAmw6ZHMbgmsXm8+dwuMCny/falpl6XMzCGw1XJV3ce6yoJ/gEv53
	 aSvFhqfbVFhLhu9jn+PXoYgmqukMGQdb+PW64PAXfowXVJcAJshbOKgzcLJDJM9vok
	 g1+xh2hIihXLePVdNqYKQ66Ko434cWlkdKje4B4/Dtr4PgjCfj2iOep7wypq3szWGq
	 N/7wAXUMv2Rnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260829-rtc_s35390a_int1-v7-2-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-2-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:32:16 +0000
Message-Id: <20260829143217.55DC11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RTC_VL_READ ioctl clears low-voltage hardware flags without cachin=
g them, silently masking time corruption for subsequent reads.
--

commit d2afec77b76a14e1c30b1da14673de2795a5f488
Author: Markus Probst <markus.probst@posteo.de>

rtc: s35390a: Add missing newline to dev_err

This commit adds a missing newline character to a dev_err() message
in the probe function of the s35390a RTC driver.

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index b72eef4fb0997..4cfe7034c5165 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -494,7 +494,7 @@ static int s35390a_probe(struct i2c_client *client)
>  		buf =3D 0;
>  		err =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &buf, 1);
>  		if (err < 0) {
> -			dev_err(dev, "error disabling alarm");
> +			dev_err(dev, "error disabling alarm\n");
>  			return err;
>  		}
>  	} else {

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file,
I noticed a potential issue with how power-loss events are handled.

Does the RTC_VL_READ ioctl clear the low-voltage hardware flags without cac=
hing
them?

Looking at s35390a_rtc_ioctl() in drivers/rtc/rtc-s35390a.c:

	case RTC_VL_READ:
		/* s35390a_reset set lowvoltage flag and init RTC if needed */
		err =3D s35390a_read_status(s35390a, &sts);
		if (err < 0)
			return err;
		if (copy_to_user((void __user *)arg, &err, sizeof(int)))

It appears s35390a_read_status() reads the hardware status register, which=
=20
automatically clears the low voltage flags in the hardware upon reading.

Because the driver does not cache this state or reinitialize the chip to a =
known
state, the hardware permanently forgets that a power loss occurred.

Will a subsequent call to read the time via s35390a_rtc_read_time() read
the status register, receive no error, and silently return corrupted or=20
uninitialized time data to userspace instead of returning an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D2
