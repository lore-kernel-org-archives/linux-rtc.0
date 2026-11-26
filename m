Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795652052;
	b=BqmEEzmbschjLXVamVnUdO+yNd/BMl1ngCQiXcXI5iyjPGc4aqsBhjx/Dofei5eLz2Uv
	 lqEcbDvPeJ1EFUAha0dyCJf+vcJzndZ/db8FoD5wicm2B3qwHJsgHoIUkJvDo+V4oRmwM
	 alwxWFIPB393i6GHfTQOxgGSvvxYQkRpZughck0mrHKK36vwPU+WQQF9Tio/hIxbkEoc+
	 sJB2tCicbX1Y/ZZpzZXEYrQAv44Murl+2cKJbXiTI6+jHoYBYzniLbty099+z2nphwOHI
	 mwlROZBC/+oJ5EQdploQqTEHqml5j9bIy5MXj4r0D5o+z3EPUsCKSSzGVH5LNK0f45A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZyKI2qUNxqXt+wcWqV0BvUgrOWmkIinXejzZ4Is8tdg=;
	b=pmKbFOvWe9MbB/wnjV6p6o0/lQVQx9Opg21vVmxgdapYI05GGynsz0w9HOvqj8nCKctJ
	 wVwooeGrcpKBhgxicjfBoAJM+M8CoXt0kOY9jSrMu7ttWIF4Nb8sU+v9oQqvVjBiyZpAu
	 PAk/WIsRaME0zwSHH3apJiaFgj2wo+Tjxbp6tTtwlQp5Ky6mQyIEb1rUpa5EDWo5c8nqQ
	 44CPpvJDaYrfoSjwJHsd58JsikgJvpgk2aimMlFlp+ZRi212UGP7fA6qnRU6Y+MFj5E2I
	 du6fUMk2MEV7wetLCBuZgRYSKAVF2S6boyalhvE1bk6WwxXwXmJY5uyULr6Gf+1zr/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dhvbt+N6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7F606A321
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 00:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dhvbt+N6
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386bd881d39so5772083eec.1
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 16:14:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795652051; cv=none;
        d=google.com; s=arc-20260327;
        b=QnPDvD+JlB6p3Y/8g7KjzEEO9Vt5Bnc2GMfPeFCf03u8NaAV2IGUxuXGeo0jQFyRDR
         1Ih+xzXrVjKTUhdsE0Jyift/tU4WYekD57oEugv/UzMY+13d6gDyjTAO4TKKDJcv1axS
         8f9q4h4M8GNRoLo7PerHnwMzcC3yXkyy2uloxM22fbF0njQWl8HVv9gYghPa21Xlk9Su
         KyIInBHwsqQ9gGs2Z/bGSP2thUHC4a6SwzKzQ3cBUovB2HMRjHwGx/i7q+KZuw0hZUx7
         uLSGUem9P0W/SyIebmiQF/mlg9KWJLH1Johqiy4MnNIhvjMpclot5zsOyfKrJCXjdzke
         tfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZyKI2qUNxqXt+wcWqV0BvUgrOWmkIinXejzZ4Is8tdg=;
        fh=i4O+Z3aSHDqrnEkR0n/G2p6C8mth42BwCocEn2BMl78=;
        b=XqhJ2lkmZzPmNDGQzeoAPLYBb4FHWLF4tZjbsThoOQzdXr/tyzW3McV6jVxYbkoXbb
         mpsceFDRQfOr4G4YILFxVo2ksRn/q9ZjCmeXoFkymG4HTa83yWXinp6PLN054yMbI6aG
         wHBi0eIDIj96+9cyl7u4mHzs6CJPN5yFceLmuWae/2vRu9eaLaiV2KoY+gh/DkzoZvtY
         hixYmBJGhM40wZXhfZftlCMg6Uqa+SSnlBlM8wyq5hncGqpA4iPVDJWkadn3+FDBqVBo
         G8lreaLmrOKljB6tQ5u1KkDFqrhZETLNC8hN1zjlA/zIMkh7F2vZiKDt7GrG1tpyeNOd
         28Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652051; x=1796256851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZyKI2qUNxqXt+wcWqV0BvUgrOWmkIinXejzZ4Is8tdg=;
        b=Dhvbt+N64gW99NVUnyhu/sbzE7bHl8mg4Y/Rm8HapWPrrP8aSul6Isrm+8IxEkko8C
         YuhgCsq6ZVPqN5AI9m+SsEcvqtqn/VTtZHxqJyNigBPi9+qqCmyUYvMJbGjcNfjU3giK
         N1QkT80OL6NB0UX0oas2gDjH7R9bNOyLZTTT1poT+h0kw0qqjIZrHb+JQTFoScAWWVhg
         VBrpa4lmD6/Bd/nVDIany+3qtrPe3elApirp9Gq5XAs7HxnqHVVll8o9qYk0OoA8rEXY
         pOuz5s3n8N7SWWgf1ZSMUcf3lDzt4v0NEByyisQdzOW0gs/YGqRUN/gUpg/9uD57cAqY
         TtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652051; x=1796256851;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZyKI2qUNxqXt+wcWqV0BvUgrOWmkIinXejzZ4Is8tdg=;
        b=w+RGTk2o7tNzf/rq77GSdHAN2iNpRCD4MdAvzwRDMZP3OrshzQWPHHZKaeMyaZz+FH
         nJnayoaYt1+oB4N0av5wpREarfSWVJAvLgeUtelD4nb3JsBXr8r01jciYtdAjQOXjxWc
         doZHwo+ikrWfuCrhU0eVHNXgHhNCQTP3cq7LYRc4ZGt4vwm6jIEkdYsQ5ARvjQyZCeLg
         eESN9W0nk4Eos4WEzwPonrP/r3NKEk5w9I5ukQ3ZlJi0368bV/W1gCy2aU7KZuy6dnnZ
         mW32wx2uBRjAcgwdFrkjk+OU0hECPplPYxFR8L32uAbiZnRF2A/cxCZd60yiG1kRR+gB
         16zw==
X-Forwarded-Encrypted: i=1; AL+hErFSvQMuILjpAon/0KQj32rNqJcEwoS8A9fzt9Cjg/WxAJXk6DG+9dbjrUbur0KFISQuorBS5UPKwA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9et+yOk63E01rdikca9zn/RMYShe0CG6embW20pZlIeeybzT8c
	Cpgg3L7rf1veUwmpGTediEFUUEajXa4p9IK5kfEkhwp1w8y9mOBqMS73HCmlzAJ6vqBRysBDfey
	lQrLeNPCh/dSa7+ClAyAADMjQ8wPSVn8=
X-Gm-Gg: AZFdTZdUPjr2EHn9FJPIXf+qoPA61poBjWp/vNkvkDstB3QXTfYRJG0YcWyny7N3l6F
	Tt0yc0IPiPb35nJBr5a6dbUAU/py+rzifcw/PF09Xfce5A2Yyve+J4Oz2e8WitidtO33ZXX5CVK
	4mb2xQwuWpZtC0Z6x8GsoKAZkHc/URaku248xaCuGzOzKZprcyeBmDm/YZVI4SbCmZq1vpChXqM
	QVXO1oqiTJdppc2BbdrBe80eLyN3wBOv1St8G65jFNToQNw6xrbPQIo5NrI/ttMSTefWtha6rbv
	SExkirjEZDwJh2AiEuJPzqok7xQqI/MYgnupd+wzQ/tig0AorYJUCEgGN2WEWI92qHAtA0wXx+j
	CzMC2gdKKGFGmzihRhzi01CNhr9qpAlUTjOSj1xc=
X-Received: by 2002:a05:7301:c005:b0:386:a0c0:5e59 with SMTP id
 5a478bee46e88-386a0c0757fmr16642087eec.20.1795652051165; Wed, 25 Nov 2026
 16:14:11 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-2-prasanth.r@lineo.co.jp> <mo4vj2higl2dmabkeslouimdgoeofqlkyjnngytv5wmub2h4w3@t2ayiiw4qaoz>
In-Reply-To: <mo4vj2higl2dmabkeslouimdgoeofqlkyjnngytv5wmub2h4w3@t2ayiiw4qaoz>
From: Prasanth Ramesh <ragaprasanth@gmail.com>
Date: Thu, 26 Nov 2026 09:13:32 +0900
X-Gm-Features: Aa3M54oCRfqrPa_wvFbRD8sm2OXWz8lngNEw2_ns1ZE4Pa74ZiYvVwkIIJgdohE
Message-ID: <CAG7eodFb_-1RPoe8Ha97NhxWXo7BdBjkFvWNOQ7PqYO3U2KCXg@mail.gmail.com>
Subject: Re: [PATCH 01/12] rtc: snvs: clear the wake IRQ on unbind
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	imx@lists.linux.dev, Support Opensource <support.opensource@diasemi.com>, 
	Prasanth R <prasanth.r@lineo.co.jp>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, CL Wang <cl634@andestech.com>, linux-mips@vger.kernel.org, 
	Paul Cercueil <paul@crapouillou.net>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

Thanks for the feedback. You're right, I should have added proper
error handling. I'll use dev_err_probe() and address this across the
series in the v2.

Thanks,
Prasanth

On Wed, Nov 25, 2026 at 6:18=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Hi Prasanth,
>
> thanks for the patches, please see below.
>
> On 26-11-25 16:20, Prasanth R wrote:
> > From: Prasanth R <ragaprasanth@gmail.com>
> >
> > The driver has no remove callback, so the wake IRQ set with
> > dev_pm_set_wake_irq() and the wakeup source enabled with
> > device_init_wakeup() are never released on unbind.
> >
> > When the driver is bound again, dev_pm_set_wake_irq() finds the old
> > wake IRQ, warns "wake irq already initialized" and returns -EEXIST, so
> > the driver prints "failed to enable irq wake".
> >
> > Use the device-managed variants so both are released on unbind.
> >
> > Tested on an i.MX6Q SABRE-SD board by unbinding and binding the driver
> > through sysfs.
> >
> > I used an AI assistant (Claude) to find this and write the change.
> >
> > Fixes: e7afddb2b4d2 ("rtc: snvs: use dev_pm_set_wake_irq() to simplify =
code")
> > Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
> > ---
> >  drivers/rtc/rtc-snvs.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> > index d99a352d6..647952dcd 100644
> > --- a/drivers/rtc/rtc-snvs.c
> > +++ b/drivers/rtc/rtc-snvs.c
> > @@ -383,8 +383,11 @@ static int snvs_rtc_probe(struct platform_device *=
pdev)
> >               return ret;
> >       }
> >
> > -     device_init_wakeup(&pdev->dev, true);
> > -     ret =3D dev_pm_set_wake_irq(&pdev->dev, data->irq);
> > +     ret =3D devm_device_init_wakeup(&pdev->dev);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "failed to init wakeup, %d\n", ret);
>
> If there is an error you should return here. I would also suggest to at
> a proper failure handling for devm_device_init_wakeup() on all the other
> patches, albeit these drivers may not handle it today. Furthermore these
> days dev_err_probe() should be used during probe, so you have a pattern
> like:
>
> if (ret)
>         return dev_err_probe(&pdev->dev, ret, "failed to init wakeup\n");
>
> Regards,
>   Marco
>
> > +
> > +     ret =3D devm_pm_set_wake_irq(&pdev->dev, data->irq);
> >       if (ret)
> >               dev_err(&pdev->dev, "failed to enable irq wake\n");
> >
> > --
> > 2.43.0
> >
> >
> >
