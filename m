Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A23D8916
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886504; cv=none; b=RGZHeQDcXaKDT3nGfMqoMnrF8YZZFFRXmMSwRb362U8S41lh5BxwE6Ves5uupTLdU09/siaYyRsi4WWMWPzY7LbQSFiBbBKyXgecrwWIKxFJYXkVJrktYV7e4NafBuA9nu0myHZjyEcR9meHwXR3du4W6Zjal0FHfLlfGVB8T70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886504; c=relaxed/simple;
	bh=9AVHA1VGIlP+i6yAoFAUmwTo4Z05lGCNrUKHVrsMLDw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=myNtXBMux4vYEPjLn4GKd00ix4N5HZLS1iK8XVyhZOELRX44WirTqrw6JX1mQS5OgKtxtex9Df5b43d/z21MHPLBcKV1YJiXV3IoYYyHPosLWo86Tl/OfdcibM+77OpziUuDopCNTO/WPzfvVnroVmt50AImZgB/NxNoWoEi2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPcLkJ07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPcLkJ07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5BA1F00893;
	Tue, 13 Oct 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791886503;
	bh=mGOjL2loZ0HJaSYen1+Hp+Dvm6k/ivO64a3d8ecpR+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPcLkJ07RBv/zC9ZniHlethr21oX7HP9h1eNbO6PDjHxwSaGvymcJKBISWuUb+RRg
	 rTlez8c83TYJSG0jw/SRrF6yNVcth9eyS9ffb9cFGi9HtHTBV412fwPcXEu6Ny+CTq
	 dZ955Z7RAj8uYk5J0WJbheh0qBvh4Q9+McIFR0ZEr1psGDOZPbLpEDPfpHlTzC2WjY
	 ZHfKte7fLw4Up+wPGuebDok+lt9cgpDVmBw7YA3gkcLKQI3XjLTDnSlM8WROSQsTY+
	 6lRgxqtFSHm1GN6QtaCaMVNYiQx+JEZEVXUi1tiLMA5Iw8K8AOIikkPxQpLjNmZhj1
	 3RQnujUFY/Z3Q==
Message-ID: <sashiko-outbox-169477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] rtc: ds1685: keep setting PAB until power is
 removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261013094930.574-3-kaloz@kernel.org>
References: <20261013094930.574-1-kaloz@kernel.org>
 <20261013094930.574-3-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:15:02 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: ds1685: sleep in atomic/poweroff context causes deadlock
--

commit 4f1dff5106d71cbe4c516d23f941007e8e8aa503
Author: Imre Kaloz <kaloz@kernel.org>

rtc: ds1685: keep setting PAB until power is removed

This commit alters the ds1685_rtc_poweroff function to continuously clear
event flags and set the PAB bit until power is gone, replacing the previous
busy spin.

> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 94c89333c5d5c..a7828f0d6c09e 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -1424,15 +1424,21 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>  			rtc->write(rtc, RTC_EXT_CTRL_4B, ctrl4b);
>  		}
> =20
> -		/* Set PAB to 1 in Control 4A to power the system down. */
> +		/*
> +		 * Set PAB to 1 in Control 4A to power the system down.  PAB
> +		 * is cleared again while KF and KSE, or WF and WIE, are set,
> +		 * so keep clearing the flags and setting PAB until power is
> +		 * gone.  We do not switch back to bank0.
> +		 */
>  		dev_warn(&pdev->dev, "Powerdown.\n");
>  		msleep(20);

[Severity: High]
This problem wasn't introduced by this patch, but ds1685_rtc_poweroff() is
used as a system power-off handler which executes at the end of the shutdown
sequence, often with preemption or local interrupts disabled.

Does this msleep() trigger a scheduling while atomic bug by delegating to
schedule_timeout_uninterruptible() in this context?

If local interrupts are disabled, could this also block indefinitely without
making progress because the scheduler timer tick will not be serviced?

> -		rtc->write(rtc, RTC_EXT_CTRL_4A,
> -			   (ctrl4a | RTC_CTRL_4A_PAB));
> -
> -		/* Spin ... we do not switch back to bank0. */
> -		while(1);
> -		unreachable();
> +		while (1) {
> +			ctrl4a =3D rtc->read(rtc, RTC_EXT_CTRL_4A);
> +			rtc->write(rtc, RTC_EXT_CTRL_4A,
> +				   (ctrl4a & ~RTC_CTRL_4A_RWK_MASK) |
> +				   RTC_CTRL_4A_PAB);
> +			msleep(100);

[Severity: High]
This patch changes the original busy-spin loop into an infinite loop that
calls msleep(100).

Since this is executing in an atomic power-off context, won't this trigger
the same scheduling while atomic issue or system deadlock as mentioned
above?

Hardware power-off routines typically require busy-waits like mdelay()
instead of msleep() to avoid yielding the CPU while interrupts are disabled.

> +		}
>  	}
>  }
>  EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013094930.574-=
1-kaloz@kernel.org?part=3D2
