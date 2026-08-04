Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270D43FD28
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837356; cv=pass; b=UL/FusP4tnb28iwXRNLZHINxpEyLNf1/WVzIi+dQuUHzLlCdzZLgaVLRyT4Qy2AAR6R/jTWjXCmXIKytkdf42I0fND5CPgggCqjtlzvbrp/1AHzLDZuQuaR2dwqeLQHCqRAdSfv/y7+xAAJtGpxYHyQiR8SZOjP6W9nm/2scG7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837356; c=relaxed/simple;
	bh=j7O+z9nzDpUwwckyXi6LRsSRL6wEHAJaX6lcrRRNg2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW3NxoXTsNaFRscB10p2FdEOStyIM5P/bovvLgBdhqoD7HpIw6cwE2JKi2U4wV0Eixa2LeR9RscZ2FMlMcs4vrKIY5QD38vExcR4MpdUqb8XA2iUO9wJnQzY8xpMg6dPTs2cC0BFqN3I7GNRewdOqB5IQxHrDNvM4JxPn1EVhdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OESaFem2; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OESaFem2"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-934a3d14924so270642985a.2
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 02:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785837347; cv=none;
        d=google.com; s=arc-20260327;
        b=VvwAeVxf/JuueYtWjUGJCM7/yaKhOcyI5cPTpYI68Yh/M506LDZj5duitW/Hr3ypq9
         EWZrUQ0NHa2skttjsiVIFgD+xqS398FU8Ol7GC7Y4nvyFoJ/ZuOz3D4CIHEDV/w56j+B
         1tQUeHs0BF32oxK1EHylwECez0+Nkmz/eTQJMLSDhR8CuZFo2xbVvr/ZdKNqgP43pcmp
         5mZdK27gcIdjUobB6AEOV2c8E/5SNe755BaL0SP0VZOLHqe4aojBdayRrC8IdvRPuHeY
         YJwe/WOE9cJrTB7NQ1iVM6lMXDqoaul9N3e2+l7kMZ0tuhzZMz7JULHXcoPnSBNl/8r+
         7oAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnhmDRT06ITuyvp+mWlf/TkIY2Vt+EFGGG1J+QsbmWA=;
        fh=AjLmnvecYsPEySN3yFBgEpVz07QSYQ32qXcddzqelR8=;
        b=lgr0PuuIAfGOY1UDMcoWj8tpoaL35gKz93wuCspsd5ewCcGHYSyeZo3bdqQAPEIvP+
         s1x/XiwAt/so6cnf9MWfsvkOmIAeIAqDuRLgtMJJ7l6apdmKdPUICNji2EZy4CtEcxgZ
         /gFBgOiV09sSAodL4kBtmV0svTwm3vNvIuarUoG2hVgeH+Z/x+fwmEgiVQ5U0TaDkJDh
         f+CxviDSJ/gN898+QT1JrCptvTLAlz5054tJt7pKMzcIlRxVaxQqk0s6HAJTetVL/rhd
         MU4LknWaUEMrDCunIxBQA8GHrEpUtVEF5f6mqv82vijINn7eu4arJAi/Q8rbVWVHS2YE
         f+Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837347; x=1786442147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnhmDRT06ITuyvp+mWlf/TkIY2Vt+EFGGG1J+QsbmWA=;
        b=OESaFem2lgmW/P388D39yuBam2SUvhp1VAFj0QCws8nOLJf19dJq1qWumMf3/1MnMD
         2JWqp0PjodzAtzZyFvdlEwF7cnZaWHIqxCMGWhR5w59jQRZZxLd8nWf0wMQ2mhQzoF7D
         b/G77S4DorXNYgfZEl+czMlrD4GNcorJI5om4RcMK5pdajVqn44p+wQZLtBzV7wmNFUK
         H2goI9Y6GQDezYTclAoNUoLv3oCmDHFzKo1dJP3fuy6U4kiSeGkMdA6K1gpXlJpRyGRM
         NIGZSwPEsF9PM5Kz968HXSYTlALLqRFHWxFxHizw/XOlsPO+5dCP7n9wJCj1nrbFtzP3
         aSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837347; x=1786442147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnhmDRT06ITuyvp+mWlf/TkIY2Vt+EFGGG1J+QsbmWA=;
        b=BDGssUl1tRo6QZTajyGGia731TFRbG567FsfCY254TKX2yKa9gMPQGdZBJwJok1GDA
         wzWIwAbx5t+MFVA06unx/fL2AVZbmBuTAVPjfqgH5TTkRWlKZkCiQLEXUoRpGss1zmUg
         6Ujkt+250J7Qlqe6sbtt5KBkxwiWGiXnl6Dz4+os8xTm043ypqC0tBtExO7dqIL+M0du
         Rqko9LZQhkJS4cZPH5r9z2wVSP6VOfUf/lxA6SoobDSb6LUQDX9ssJXAUSKB+rYVb3Hv
         FjvuaAKpdJEnL1Jf3AGOozdtirZasXNfMv3LXsfqDVr1NPTws0E7gHwsScO6oIlGugmz
         Bfuw==
X-Gm-Message-State: AOJu0Yz3nG7IeecLosFbLsfj1oPFgJckT6w95vT/6pGBcWKx+OP9R7nz
	pr9Ftf0sieBiQ7TdwFOwfE1aH8Ij6jCsv8UQVQIRd56DZMglGJE2HwQniSEAeF8zDNt1bk9vvov
	uGF61XgOIKJXRuwgNySt9ORqhKbKJ1JA=
X-Gm-Gg: AR+sD11y04guJ5lfQhmKxxny3pGAvowY9gVByYaUE1EaAMPH7YsUuktT8+NrkaqZ+JF
	yzjth4aGfiRtAXfSBdiPhvaP5wixV/ISaZkkY5dq1R5npKIOyWFXl780lPFyOlw19ukeY57GB/F
	X5RWI7/e1mRSA4qouHIoDSkvQjDrDvMUcT/0p154mmgCm2VHL0EPQI2J0xYvztxA9zZSSaT4X1n
	FvL2zzSOIaad8v4KzI1PHIjiFZqZmLd2/w8Jjc4PxzoyeLJ7+CyTMNhMoCfKhx0KenvIzcg2Zay
	vdgt/clEzULOJYonpuf71FZP38gf2yInD5KK/kfLqKiMwck=
X-Received: by 2002:a05:620a:4488:b0:92e:305a:d729 with SMTP id
 af79cd13be357-934a070de9emr2437255385a.7.1785837346669; Tue, 04 Aug 2026
 02:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717193705.2003175-1-chou.cosmo@gmail.com>
In-Reply-To: <20260717193705.2003175-1-chou.cosmo@gmail.com>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Tue, 4 Aug 2026 17:55:53 +0800
X-Gm-Features: AUfX_mwscCkjU5sW6MOPcNIegOVOjnuMxQwdSyZ9np5ngRKwNXG5dHWcx0vZHOA
Message-ID: <CAOeEDysuwsFcHZb77zRCEQb2k-o_zKPR9Efet2QbzOgzbVvS6A@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: pcf85363: Add error checking to regmap calls in probe()
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Friendly ping on this patch.

Thanks,
Cosmo

On Sat, Jul 18, 2026 at 3:37=E2=80=AFAM Cosmo Chou <chou.cosmo@gmail.com> w=
rote:
>
> The probe() function ignores errors returned by regmap operations.
> If an I2C transport error occurs (e.g., -ENXIO), the driver continues
> probing and may register a non-functional RTC device.
>
> Propagate errors from all unchecked regmap calls in probe() using
> dev_err_probe().
>
> Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-femt=
ofarads property")
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
> Changes in v2 [1]:
> - Update commit message to reflect the new scope of the fix
> - Add error checking to all remaining regmap calls in probe()
>   (regmap_write to CTRL_FLAGS and regmap_update_bits to CTRL_PIN_IO)
>
> [1] https://lore.kernel.org/linux-rtc/20260716125142.1801599-1-chou.cosmo=
@gmail.com/
>
>  drivers/rtc/rtc-pcf85363.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index 540042b9eec8..ccc7834e5759 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client)
>
>         err =3D pcf85363_load_capacitance(pcf85363, client->dev.of_node);
>         if (err < 0)
> -               dev_warn(&client->dev, "failed to set xtal load capacitan=
ce: %d",
> -                        err);
> +               return dev_err_probe(&client->dev, err,
> +                                    "failed to set xtal load capacitance=
\n");
>
>         pcf85363->rtc->ops =3D &rtc_ops;
>         pcf85363->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> @@ -436,9 +436,16 @@ static int pcf85363_probe(struct i2c_client *client)
>         wakeup_source =3D device_property_read_bool(&client->dev,
>                                                   "wakeup-source");
>         if (client->irq > 0 || wakeup_source) {
> -               regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> -               regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> -                                  PIN_IO_INTAPM, PIN_IO_INTA_OUT);
> +               err =3D regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
> +               if (err)
> +                       return dev_err_probe(&client->dev, err,
> +                                            "failed to clear flags\n");
> +
> +               err =3D regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
> +                                        PIN_IO_INTAPM, PIN_IO_INTA_OUT);
> +               if (err)
> +                       return dev_err_probe(&client->dev, err,
> +                                            "failed to set interrupt pin=
 mode\n");
>         }
>
>         if (client->irq > 0) {
> --
> 2.43.0
>
