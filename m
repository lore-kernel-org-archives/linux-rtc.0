Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8F476CCA;
	Fri, 21 Aug 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307425; cv=none; b=ezvK5B4hmPYe0Esc7pRO0jnbiNpHeWHy2nv/DbV/u9yT6l0hRlu8b+9Gxz/DYdItYdaE2y2OCBpkqDzfxBo+ENNmh9CwPily9XxLn1I4QiLFFUsMMAdjz7xorHJ2gGuGR5WlRhuun3WAYVUCMt7T/4KqVHCIQjNE8clYtRLXsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307425; c=relaxed/simple;
	bh=DKRXayLpP+jU/vG4d/cxT3/634d04+sC7uDEfldQACk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j4ujHqpCzfLcT6qohIwrgnYzsG8g+mSK3F8+03nM47+NH9x1jCOVP4JdwftBFDQ3zYsDUUb7DVs3uQ6pAbQfxo5Boc9Ac2nCmvAhfoVqUAiR8IRO60wCMsjss/wpW6hDY36YZBX/4I2V4X/s4IlM8kmTVE57A2HwHqyIv0pPnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJZx8H9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJZx8H9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E591F000E9;
	Fri, 21 Aug 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787307415;
	bh=S3X67Gsmco8iToK1+9zpnq9MW7luK9kPCYK6ZvJhTnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJZx8H9m5D4tjV1Yev1vTzsLDBJHLiMrEKekJM2v1MP0RgLYlNZyctXClNFPKLt+y
	 txpb/j7b0J+DwdYa6+QPsrG9GWzQQebdOxLxE1RtdXVyk30ULzzNpwk51ZCmJInFMj
	 7FNpBFvyPWqJT4DitoQeriStfnmWTZSa9EpY3yxi1xCPQMLsXWE7ZJlaPxzJ34mSO/
	 Ns7VXTEzgBQMOJ/RvxjVDKGyaox0itdXUgk6iX+nJLUbIBqGk9C37ftGGQMwNvHZyj
	 ndwAFFHW+yRGYm9Qz2wEeLOZJzExVisSaYuIkX2Ig68I2tMktgSR0/YdExty1Fy3G5
	 b8+mgHiODN5hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] rtc: hym8563: Make sure clk_init_data is fully
 initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-clk@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <657f2b3a871074087aee0b7a70bf527ab0f48da8.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
 <657f2b3a871074087aee0b7a70bf527ab0f48da8.1787241693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:16:54 +0000
Message-Id: <20260821101655.03E591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free and resource leak on driver unbind or probe failure.
- [High] RTC alarm interrupts are acknowledged but not reported to the RTC =
subsystem, breaking alarm functionality.
--

--- Patch [1]: [PATCH 1/5] rtc: hym8563: Make sure clk_init_data is fully i=
nitialized ---
commit 706406627c1866b58ba6ad7ce0c506c6e63d88ad
Author: Geert Uytterhoeven <geert+renesas@glider.be>

rtc: hym8563: Make sure clk_init_data is fully initialized

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock. This
commit ensures all members are fully initialized to avoid subtle issues
with uninitialized stack memory.

> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index 3156aa5f2d9ff..1d52cc3def02e 100644
> --- a/drivers/rtc/rtc-hym8563.c
> +++ b/drivers/rtc/rtc-hym8563.c
> @@ -376,8 +376,8 @@ static struct clk *hym8563_clkout_register_clk(struct=
 hym8563 *hym8563)
>  {
>  	struct i2c_client *client =3D hym8563->client;
>  	struct device_node *node =3D client->dev.of_node;
> +	struct clk_init_data init =3D {};
>  	struct clk *clk;
> -	struct clk_init_data init;
>  	int ret;
> =20
>  	ret =3D i2c_smbus_write_byte_data(client, HYM8563_CLKOUT,

[Severity: High]
This isn't a bug introduced by this patch, but could there be a
use-after-free if devm_rtc_register_device() fails or if the driver is
unbound?

Looking at hym8563_clkout_register_clk(), it registers an unmanaged clock
and an OF clock provider using clk_register() and of_clk_add_provider().
However, the hym8563 structure containing the clkout_hw is allocated via
devm_kzalloc().

If devm_rtc_register_device() fails in hym8563_probe(), or if the driver
is later unbound (there is no .remove callback in hym8563_driver), the
devres framework will free the hym8563 structure. Because the clock is
never unregistered, the clock framework will retain a pointer to the
freed clkout_hw, leading to a crash if the clock is accessed later.

Should this use devm_clk_register() and devm_of_clk_add_hw_provider(), or
provide a .remove callback to clean up the clock and OF provider?

[Severity: High]
This is a pre-existing issue, but does the interrupt handler fail to
notify the RTC core of alarm events?

In hym8563_irq(), the handler reads and clears the hardware alarm flag
(HYM8563_CTL2_AF) to acknowledge the interrupt at the hardware level, but
it then exits like this:

out:
        rtc_unlock(hym8563->rtc);
        return IRQ_HANDLED;
}

It appears to never call rtc_update_irq(). Doesn't this mean rtc->irq_queue
is never woken up, causing any userspace process waiting for the alarm via
select(), poll(), or timerfd to stall indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787241693.gi=
t.geert+renesas@glider.be?part=3D1
