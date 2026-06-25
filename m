Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A73CEBA7;
	Thu, 25 Jun 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381970; cv=none; b=RlhU+cLbQ/Vrmqvav9nUYRfHun8BJta+9yRt3R4qLqAWi7Rq9Z7m5mEqDrHFtFyVbxavnUgpcJhLrgdBAaEyOquy/nvFfmLkld4QamH4kqESf4ktqiJwX7EZgeCfyx6TsF0kzMQiNhToGvdT9DZVcnLufXTdv1QLcmbBYv1nI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381970; c=relaxed/simple;
	bh=8LGe1rI4G5UzGnURE5E4veYi3jJAMdJZbhlhkS6Wl98=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zw0i4H4QWGMvA7fiKRudN2HoaoXLchqVWJwsTWKABkw/DtCrSVi/WAk2X2ud9Oyj45cYsRx6wPok6hKgT/Yc4tr/euLdQoxa1FJIPFzxijtR2/mSjmdWUMRPrXAlYytuJ+anvMRAKq97urzwaohGRBWWZO3vk1DtCgUvbWfSdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVGd2pqJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVGd2pqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782381966; x=1813917966;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8LGe1rI4G5UzGnURE5E4veYi3jJAMdJZbhlhkS6Wl98=;
  b=kVGd2pqJU4GPRKL3gaI+O+8IUh1fapgu6ud/tfHSOgcaAHH7lfTd7AfY
   Ibe3LdCK/OsRxZu74NsBE6KA2gYd4Z7ENGWtvDIVzkVSpYx5u/MBHqK2L
   QqeNQU/vcj1Nn4zCmzdP3IkiPJIeJFH1+qjbethe64ID/bVp/L1KpcO9N
   gSFEmqZKHw6dsGQswQ1lUyap/SBqDa1/dZa2iNhWwDeNbu1SLrFlr2JW4
   9JV+rbK0t8IRdzH1Ex89u6gTSXj9GU2veGW2/LSb6VHynN97sITgo+1Un
   qOQtHIb4QipiER43sRfDyPvrnuaeNPNgDv0NKLOehA03LCu0W4Uctks4y
   g==;
X-CSE-ConnectionGUID: /oUZoorQS1abAPMOqbCcbQ==
X-CSE-MsgGUID: N/M7QCKnTZyiXzHUghJnqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87000498"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="87000498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:06:05 -0700
X-CSE-ConnectionGUID: QNkr2PbeSOekMt+iq2IM0w==
X-CSE-MsgGUID: SxBpMQxaQgGWGKIcgY9cdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250976625"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:06:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jun 2026 13:06:01 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org, 
    Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] platform/x86: amd-pmc: Fix S0i3 wakeup with
 alarmtimer
In-Reply-To: <20260521043714.1022930-3-mario.limonciello@amd.com>
Message-ID: <f023638f-d2fd-5d79-a4be-aefdfd7f645f@linux.intel.com>
References: <20260521043714.1022930-1-mario.limonciello@amd.com> <20260521043714.1022930-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1010219341-1782381921=:1305"
Content-ID: <99a48c78-134d-7304-70d7-9343d4f0bc78@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1010219341-1782381921=:1305
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <af6b76ac-eada-0b0c-9558-716e1a5c80b3@linux.intel.com>

On Wed, 20 May 2026, Mario Limonciello wrote:

> It was reported that suspend-then-hibernate stopped working with modern
> systemd versions on AMD Cezanne systems. The reason for this breakage
> was because systemd switched to using alarmtimer instead of the wakealarm
> sysfs file.
>=20
> On AMD Cezanne systems, amd_pmc_verify_czn_rtc() programs a secondary
> timer with the alarm time. This was introduced by
> commit 59348401ebed ("platform/x86: amd-pmc: Add special handling for
> timer based S0i3 wakeup"). However, this function uses rtc_read_alarm(),
> which only reads the aie_timer, not the next expiring timer from the
> timerqueue.
>=20
> When both alarmtimer and wakealarm are active, the first expiring timer
> might be the alarmtimer, but amd_pmc_verify_czn_rtc() would only see
> the aie_timer, potentially missing the earlier alarm.
>=20
> Switch to rtc_read_next_alarm() to read whichever timer will fire next.
> Also handle -ENOENT (no alarm pending) explicitly as a non-error case.
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3591
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/am=
d/pmc/pmc.c
> index 50f5784f2aa2e..8cd2db0ccaacd 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -595,9 +595,12 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev=
 *pdev, u32 *arg)
>  =09rtc_device =3D rtc_class_open("rtc0");
>  =09if (!rtc_device)
>  =09=09return 0;
> -=09rc =3D rtc_read_alarm(rtc_device, &alarm);
> -=09if (rc)
> -=09=09return rc;
> +=09rc =3D rtc_read_next_alarm(rtc_device, &alarm);
> +=09if (rc) {
> +=09=09if (rc =3D=3D -ENOENT)
> +=09=09=09dev_dbg(pdev->dev, "no alarm pending\n");
> +=09=09return rc =3D=3D -ENOENT ? 0 : rc;
> +=09}
>  =09if (!alarm.enabled) {
>  =09=09dev_dbg(pdev->dev, "alarm not enabled\n");
>  =09=09return 0;

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1010219341-1782381921=:1305--
