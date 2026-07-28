Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFB222565
	for <linux-rtc@vger.kernel.org>; Tue, 28 Jul 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199533; cv=none; b=SbhJRJqzJTvLwR2MDIMOCU19tVvpXD8FnZUbfznN4WdhN8hyaFRb/L71kIHC0vpBDkEvPMzS+AllOG4NthQNX0++Whk10KIE+SAeMZ9tTcwUC1SGsL7Wf01kfAMSmL0G70NXhvyFnzTVlPoDAqpcra9DhrH10/5ResDGOWT68w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199533; c=relaxed/simple;
	bh=SvbhZ7g6VYtivLQjzAsPrHs5h52lQyOUStytlp9R18o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AJZNn/nTJbV3nIYVbTxV6BpqTYyjPcokTVkSojJztaf8uPINtap0x0kCwJF9Wey1uJ5RRv4mC7n/G7TAbTCWD6Wg9IyjogYp6wpzllBvL/HdjUarKL1J6ZsVb66cLHAW7XG93fti2VyGqKZ4Bt+Vp9n9GZ9gDdLkYYlY0V2+Pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwPi9YiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwPi9YiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5821F000E9;
	Tue, 28 Jul 2026 00:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199531;
	bh=rXnO33V2SdMOI69h15GPvPD5yuuuW1x49iF4h3aMDww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwPi9YiS8v7g4YRms7Yo8af37uGEFJZlFnVAD1e0JeHXLzudHq6KV7cZbdap+LWtt
	 IKK1HWkmiLpww9+z6rNGhH6qgOWXSOuPUFZTez7yjm9tSGCQxfg5Jbs2VDis4HaUel
	 gZMBJINiWEsXsEylHE7tGO2pO7stj2Xv+WglvM0TYoio42PY6ecDxqU9tEDgJ6fq5H
	 afIPEjj2WHOvW8KfW4OMrh5/eCov1jaEGD2AwFiZfzSX2H0JgzIFfOMLv/J1f1GcNZ
	 GysOkmqWR1tteVK7cuNQBtpy4v4/AWQAuW4IrqhvuPKxkj3Uop872Wb3eB5sNQ1pfR
	 GD5CaT7tRkyYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: omap: Add missing kernel-doc for @dev parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260728003545.571399-1-rosenp@gmail.com>
References: <20260728003545.571399-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:45:31 +0000
Message-Id: <20260728004531.9B5821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] omap_rtc_power_off_program() ignores its 'dev' parameter and deref=
erences a potentially NULL global pointer, masking an API inconsistency and=
 risking a kernel panic.
- [High] omap_rtc_power_off_program() reads time registers without waiting =
for the RTC to be un-busy, risking a corrupted time read and system hang.
--

--- Patch [1]: [PATCH] rtc: omap: Add missing kernel-doc for @dev parameter=
 ---
commit 1c4ccb1ef3cb61576a4f7529af03a3fdc744f227
Author: Rosen Penev <rosenp@gmail.com>

rtc: omap: Add missing kernel-doc for @dev parameter

This commit fixes a kernel-doc warning for omap_rtc_power_off_program() by
adding the missing @dev parameter description.

> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0f90065e352cb..39dd91d1bf86a 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -407,6 +407,7 @@ static struct omap_rtc *omap_rtc_power_off_rtc;
>   * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
>   * generates pmic_pwr_enable control, which can be used to control an ex=
ternal
>   * PMIC.
> + * @dev: pointer to RTC device structure

[Severity: High]
This isn't a bug introduced by this patch, but the documentation solidifies=
 a
broken API. Does this documentation hide a type confusion?

Looking at omap_rtc_power_off(), it passes the parent platform device:

drivers/rtc/rtc-omap.c:omap_rtc_power_off() {
    ...
    omap_rtc_power_off_program(rtc->dev.parent);
}

However, am33xx_rtc_only_idle() passes the RTC device pointer:

drivers/soc/ti/pm33xx.c:am33xx_rtc_only_idle() {
    ...
    omap_rtc_power_off_program(&omap_rtc->dev);
}

Inside omap_rtc_power_off_program(), the dev parameter is ignored entirely
and a global variable is unconditionally dereferenced:

drivers/rtc/rtc-omap.c:omap_rtc_power_off_program() {
    struct omap_rtc *rtc =3D omap_rtc_power_off_rtc;
    ...
    rtc->type->unlock(rtc);
}

This global is only populated in omap_rtc_probe() if the
system-power-controller property is present:

drivers/rtc/rtc-omap.c:omap_rtc_probe() {
    if (rtc->is_pmic_controller) {
        if (!pm_power_off) {
            omap_rtc_power_off_rtc =3D rtc;
        }
    }
}

If the property is missing but pm33xx.c triggers this path during suspend,
will this cause a kernel panic due to a NULL pointer dereference of
omap_rtc_power_off_rtc?

>   */
>  int omap_rtc_power_off_program(struct device *dev)
>  {

[Severity: High]
This is a pre-existing issue, but does this function risk a corrupted time
read by not waiting for the RTC to be un-busy?

The function calls omap_rtc_read_time_raw() without first synchronizing via
rtc_wait_not_busy():

drivers/rtc/rtc-omap.c:omap_rtc_power_off_program() {
    ...
    /* set alarm one second from now */
    omap_rtc_read_time_raw(rtc, &tm);
    seconds =3D tm.tm_sec;
    ...
}

If the RTC is actively updating time registers, could we read transitional
garbage data (e.g. seconds updated to 0, but minutes still at 59 instead of
0)?

The rollover check further down only verifies the seconds register:

drivers/rtc/rtc-omap.c:omap_rtc_power_off_program() {
    ...
    /* Retry in case roll over happened before alarm was armed. */
    if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) !=3D seconds) {
        ...
    }
}

If the seconds register was read correctly but others were corrupted, will
the check falsely succeed and arm the alarm with the corrupted time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728003545.5713=
99-1-rosenp@gmail.com?part=3D1
