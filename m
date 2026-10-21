Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565174;
	b=v9RDh4wCxWHmNb4dYBWB7XKVmIfLN/yioe+xuVegYOunBFC9aYt1ZdAUKkigu1H10mlC
	 84K2Vio4VJxE+ADJSOYFVgFkpUkuOApCyyPADtMNkdAfr0rqHluc4m2qIGYuJ1Asm2+Gq
	 nzP1xIOnXf8HHE+JWzBNEhNItp32qrf/TougfA6Bn19j4LAAEUFOOxo/tEqzmftq23xYU
	 od3LEBVOrt6gPp3xEOQ/zVu101mg74uXQdyIO+G+heZyWSSAFeWT/42cWy8CThPHNM1Ji
	 0wJWDfPO23dkfggXLIwBD5mW/jtATyKm80HLyuXR2kCwb7qbHYNmUJ1SxaNZBeBVv8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
	b=FscI1cKctS6OCZOIwHcPD9kf5H1XQ9Xzf6ql9YWhSC5/QobUADZtSkyLIAQi7Cx+CoJe
	 GRWmZghnR8mUqMIu6BHv435yJKdMaqcEqnnB4vm9FomFKXXXjEASJAh5unbKR33a2e2OC
	 aAhfmrLu6W59+oy5udRP1TiDn2jE8VQnOEZrq7KFjPSPtEpF0J0r12yVi5LDUKq/DPURX
	 Y56zyu7B4BWDglrgC3j8c6FomCJlXOBZ0Zr8dhL7ZvSQ2JSQuULHHwKYeFTy3AojMrR/H
	 OBbdRNZcTfuCVRzV83PThcDwbTfHi2P05crzvXo+fBE09VZF+GyXRKmWAWg/xx7myAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC6606A31D
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 06:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8BC6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917bab38b14so4663226d6.3
        for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 23:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565173; cv=none;
        d=google.com; s=arc-20260327;
        b=mSUWU5r1ojds/0A6Q6rccyIurYoWXBc3mThEIoqHa1Uz4yI+/ki7HOE1NhPWwVdUs5
         4t2JNo4w5xj+IxuCXwx9ObnMhxYnJbm7NTpsuaoXp/aKfgxclANbAsEuZGkHG1GFa+e5
         UM+dZaoKs5n6tNTRhRj/s+dEPWMzRAFjA2dtpRWFYOW9gbn95xNQ5SHAIuztcrk5F1Ga
         QIqcETdxyyRh0Y9lP3adycFVuj9uFauCmUOrJ2zgRjGTGc38Mm/K8nnbWaFJVqDBZGdl
         UO5aDPEIKPHAYVU0sR+84jAbPGry9EVtaSq91Q/07rf0RpUOQMkGMP4Hcux6dVBipU2F
         P/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        fh=YX0Ewv4nVkCmmg+ySyoeH1siMrnYbUldGu5L1C+hmlg=;
        b=XJsYIaETLklYn8FQV5oasC3RsHAPrSVDXZ5oggyzT9y7a+JN8VcZgOb/RCNex0EPSs
         nQE4P2eRxgZrlwkjuYMdiPA/CcrJEdOshAY3VTXtoJx9QmwqmrLTo9jBw1QbfiHdzKIq
         FbzuRFeSMkIr2RZsrhKZx8NV2jsoGAuLetrZ//0XGRwKfDyBQCdKMarEJ1aqwb94ANgr
         sprk5qPGGQlsikv+l6zLbp6EzjRhMRTfIMnZ5AuJ1WALXDQBFhg9YNm7VD7/bZ6c15j+
         t4pMhh0QmaIyMhR1NI6c3NsBOgCa3Kodfm1Xux+PdaESqmSInjyxMSgCyX08aTCga3hb
         1tvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565173; x=1793169973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=N3K8Bbb9tNmHLFt6ZXFDabkPNwYz0MlgUzh0K/zfhr2yAjtdkvQ+atM46OurewOaR1
         5GpHZ1w3HZLexrrVA23itcwJ6z/A3tv78GFsLEvhUonkAC/73dFWQMqQxs4AzcszUoAg
         QywB+6q06BHod6vzHnLg7lTEveFPsMcBeMrLr3fmzfBfZu7SyUZlS+rtU0CFP/tt5s8g
         rXTl04SHDbrB/z7e3KtddFWqAgqZuw1vN7ipKBmLQJ+HhmthCk+mdogVDq20OH2zdFz9
         er4Y6laPpOvP7dFZUifXCwXVCDWoAe8f6eCGE6CSv2DC0EwRrBbnT+ttWzNfLh3PEE/8
         ufzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565173; x=1793169973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=QUXjIwXLovGzWPBrAf/LlulpJY32ktcjTp+L775B1NF5au4uWdUS+O5zD+wYl+0OjS
         RAqKr8h+VtclM2EqhphQAEOKsn0sgqQX4DDeC14jngPnjVhJLfEVrUa5N2u9snz0/IAK
         8CextEMdKFanrJDaZSFiew8V5CfxBpy4YyAHvJxVufByuppMgJpZo3Zw5s7SWMWkxszG
         VKlSWfrGu4iBvqJHAUVIlDi0acnz3S8OcSam9RuKwHnrW77jnprooCy2/5c1zyumWSpN
         nJvztezvHZqNB8+I9Q1ygk4zhGzFn9Xjhg5bWX+W53iRStPLtSIqQ6mpod/t3CFQd7DH
         ac2A==
X-Forwarded-Encrypted: i=1; AKwUvBwfyEKxT/JTRkIrzSXBTSrQad+LHezAjuZ1h/3rVnEixdDdl/puWW06ZNPAQiMTqjRVpnmFA9VeZ40=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPgXJLUhUFdd0oz5Rw165pGSS1QUy2yRbMWREkESw2gQxOtIjI
	twH/LVUz6suSf6moxOtMYOJEP8PYAdqWEfExE4wtywYk+7844UeywR9tYH2WmlCnSjfuq3I8nPB
	gix+u0Zfs014fv0DGy38BQdLrZV33DvoUwNW7
X-Gm-Gg: AYBFou1B14sfgooUFX5Qs950KQFuyfF5P5IUZ3DVn2b5Favl/wp845xhdwyIS+ktVNb
	eYCOcdAxPwK/ozdm98lUDTZhRMZzodFsTRT42c42m8CeWr6T3VTSN7COH0KMyHfbtVcUAUEUQ2y
	jEuv3tEXix2b114YX5ApVxzgWK6ibdIjU5GT5kT/fOgmSf2BeEJV3K67JjK2w4KmqnVA67spGra
	9FPQ/fPXlWmiusUxIec4n9Ch77ImUPg4ZkIvrcR76FjMHwgwWt6lzvscIjehtmdEyyn0STFh9dU
	hTaSx/ETnE9FPCSAkw7Vmi9CBa9I95WzpSsLxBw3D1XHWmwOkUHvyChJPDeemsAC68Bv08qJRwr
	OmGcwwu9CrtNBEA8OMPr5l4bTL0/ktH13BXtsFQS9/RUrIOYHUMTgeWrFzDo=
X-Received: by 2002:a05:6214:487:b0:91b:cafe:58e2 with SMTP id
 6a1803df08f44-91c12eb7b30mr18765456d6.14.1792565172936; Tue, 20 Oct 2026
 23:46:12 -0700 (PDT)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013063259.2734757-1-a0282524688@gmail.com>
 <20261013063259.2734757-6-a0282524688@gmail.com> <sashiko-outbox-169117@kernel.org>
In-Reply-To: <sashiko-outbox-169117@kernel.org>
From: Ming Yu <a0282524688@gmail.com>
Date: Wed, 21 Oct 2026 14:46:01 +0800
X-Gm-Features: AclHuK_sk3N3reGEV1vFqkhXmWhSRT0CO9e7SvF9FhuKig6lX9RUqvijqALmuJY
Message-ID: <CAOoeyxWNsBt6nDn82bCv0DUpar3c_K19su87UEbjm4CfCJbbHA@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] mfd: nct6694: Move module type macros to shared header
To: sashiko-reviews@lists.linux.dev
Cc: linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<sashiko-bot@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=8813=E6=97=A5=E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] mfd: driver-specific header modified in global include/linux/mfd/
> --
...
> > --- a/include/linux/mfd/nct6694.h
> > +++ b/include/linux/mfd/nct6694.h
> > @@ -8,6 +8,15 @@
> >  #ifndef __MFD_NCT6694_H
> >  #define __MFD_NCT6694_H
> >
> > +#define NCT6694_HWMON_MOD    0x00
> > +#define NCT6694_PWM_MOD              0x01
> > +#define NCT6694_I2C_MOD              0x03
> > +#define NCT6694_CANFD_MOD    0x05
> > +#define NCT6694_WDT_MOD              0x07
> > +#define NCT6694_RTC_MOD              0x08
> > +#define NCT6694_RPT_MOD              0xFF
> > +#define NCT6694_GPIO_MOD     NCT6694_RPT_MOD
> > +
>
> [Severity: Low]
> Are these driver-specific module type macros only used by the parent and =
its
> immediate children?
>
> According to MFD subsystem guidelines, driver-specific header files shoul=
d not
> be placed in the global include/linux/mfd/ directory if they are only use=
d
> by the parent and its immediate children. They should be kept local to
> drivers/mfd/ instead.
>
> Does this addition of driver-specific macros to the global header violate
> the subsystem architecture guidelines?
>

The sub-device drivers under gpio, i2c, can, hwmon, rtc, watchdog and
pwm also use these definitions, so the header needs to stay in
include/linux/mfd/.
