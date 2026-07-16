Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631F42A16C
	for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213772; cv=pass; b=Md0DpsNIw1wUQVpMCpra4jMyiwtTBIQMRSNRpZ7UEAZY1kFkZtkgOlcPkBagG1utxjHk3lL3bD7GHU0KFQV5U62EqJIjxkhrD6wBFst0BHN/oc6uqpWzpACj6XpS6hlsgFywMGht6T0n5/Vl1bmLWAMXvgv+0xa+m380DO2wDx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213772; c=relaxed/simple;
	bh=CY4i+VwyWYtJkkh5aNDcKsviuaCmzuqsMTJz18jEYUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMY0xemC/qPJ4gTJrt4gFjLLNb9ME7JA31cI0TQzPCZr+CE4UDXYmi4A5ne7d1+ySoz6AySXvrallUqloO0WSCmxeiO0+0zEnZ5FzReTXnp/1cxgYsXHgZ4ASIW+Omyead8ZwtLgwgq8nID8bvO3bi5iYcVTcwKCVy7UBAudO9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY955dLL; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY955dLL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfa429aa6so2277611cf.0
        for <linux-rtc@vger.kernel.org>; Thu, 16 Jul 2026 07:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784213770; cv=none;
        d=google.com; s=arc-20260327;
        b=hMQLiRini6AssUoCG4AoJ7I8M6fpXb7RaMl5rFQ+kBbdNKgVzm5wElJexTtyUaBDfP
         JBZZSGFquIH0OKZyOmrJiSoGKmUFABw+53svgDd2kdKMhloNZ0sKiukUcwaQJGbxFuME
         /mnV6fgcY3KbOPqUdNkrQLERyHx5jDatf4ao4ZkXpSq9aNNVqd+0IcjtcHfzJnlOnVMo
         hImPIuT7xF9qI7RE4hnkULAfTAr8kWZ+ZQ8RFntXc+RhZ7jEOSdAhVdT5byPifTfh75I
         dyrPhOwNgCyRn1cNj2PTITINskTJN7AoS2mONxO6Ygtc9wtuao6Ai5qmpRInDxQRZjBN
         4uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pyfIk61STcvItwvowpvAaF6YjNonLMnEmUnl6F/dljM=;
        fh=nzUQWoA9vWXFkLEMWk2BAxfDVlDMLNwpFs2Y5onRy/0=;
        b=RmAHNhHe8LvyB9baA9T1DD137QHEDVFN6g8YlL/VZfoSvRMoW4AefYDoOzC3HFtSfF
         wChlLd9gO0JPdm0PaYcHhxnil6xwy/KDRI8WyZn5CMVeal571PBc039IseyHCwsEU8AI
         npSp/1pQD2pT30+QLVWgv2eZZtMo0vONEZ+XhakFg9oUTNx5V1YJQg42DSCrW7D1RozZ
         T71we8Yw+SX80HEomt9HmLG9LnxumFFnE/9fVUy4CdcZirKgD7iVE/zC1dtIHK3g++tc
         rAM6rABn2maPt4ah/DmKaehjNInhqvAQS8oOREDber9A04hkCKryLStMMFGJ8RxYv5Ug
         b5aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784213770; x=1784818570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pyfIk61STcvItwvowpvAaF6YjNonLMnEmUnl6F/dljM=;
        b=BY955dLLOeI3GrJzbLKMUPxTmUL1j4Flr0C1AJ/H9NkknmYVRcOWZ7YdDlOdcv5A0S
         gcM5VC07qwudQ/12WtYovHw9h8KSkYVpnLdpQc+s5xtiWycHH625OZRp9Fym+FEL6iuK
         bmFcqlBoYVyk1uL2igD0fhNv7MdqAElGR+DL3SMYHI+3BlbJny3CWOZV5zsvGvrWwBI9
         DJPc1GhAfpl9CNwPml/DZfjOwNUKHzxhFVj2uJFWUo62IZlYj2q37G8Q74wPcm659GMH
         PcJdd4QDu4MkHMKORSiyxT6DZcOznxgN8gKrSUmnGNW07EOfWk0wpAIft+fqu5HyYO1Y
         uNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213770; x=1784818570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyfIk61STcvItwvowpvAaF6YjNonLMnEmUnl6F/dljM=;
        b=OYrrvidknBiIg+nRs+FJF9wPKprxh8a2FVEwsVcYa7kgcu7Am2bgOTw1ZyIxrrzA6a
         vZvWAoS6eC4uquxEz+LhzQWbc6792uvAayrPB05B4KKHWklURoasYJ/Gfq7j9ZfLEmWZ
         RwDi6DNKY1P119wobrw4UVQkmhhxV1z2SCDgkOSFEZ4UVX/9Dzhx5JnCuvVm87ERKn9K
         RI90eF20EIY17URMxz9nRUe5jQSJ12ayvtIflNCr/R8JNn344fatdKuW2ElLIpJ+yWH5
         5McbauPyiB+IvR8Tq++as/DyLQAWuEGVyNc3RTkGM2+d7G8FX3UyhORVnZ4EqmvazTKS
         zyeQ==
X-Gm-Message-State: AOJu0Yyfx3vRf6ZZYEUTZYIJxIwvUPwz8FZkuy/Ma7h3+0RHqxKJsPIV
	DSf9hCyuKMNMfaTXMjcNxLLsNoReLd+1OussyoCGyCqaHTixlFcUDse6OSK8kC+DV8GcdDT3VcS
	o6GZPZqh65eQh/D237BjOf5jm5Fv6Kao=
X-Gm-Gg: AfdE7cm8yXu/uUDKCdA0TzWmtxvZ3K8jh8f0UREIuPl0wdM0e8ZeWW6Uw3kzlOeVvgs
	GCPHCqKlS8IJNCZpkS20bigzSQrTLHMKyOKcullfQwht5Ic9ZSRIzW16Cv9pPIKF49bqCVlxW5I
	S3FvaQNV+RyVAcZY6+8oEebqUpHI9HWDd3gTDBvm3+wdGh/W90ICwezjmPs0JCsmhYDl/o4VkNq
	i/u4dyY5z3GqIeuBciuPv85+P77/HB3ClMfD+bEjbv09SnxYFk8l1/QyooEY1g=
X-Received: by 2002:a05:622a:1b23:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-51fbf8ba886mr28344101cf.17.1784213770032; Thu, 16 Jul 2026
 07:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716125142.1801599-1-chou.cosmo@gmail.com> <20260716125617ee5cdf09@mail.local>
In-Reply-To: <20260716125617ee5cdf09@mail.local>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Thu, 16 Jul 2026 22:56:04 +0800
X-Gm-Features: AUfX_mywOXT0UrVub0Y5huFmvkjvi36CrRVvqgUoPDbK9Oni8vfvSkc2ZpzDkPM
Message-ID: <CAOeEDysWcPR+BdjrFGE89dwsQNWFG1ihf0q4kiWzRHVRzOtcyA@mail.gmail.com>
Subject: Re: [PATCH] rtc: pcf85363: Fix phantom device registration on missing hardware
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 8:56=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 16/07/2026 20:51:42+0800, Cosmo Chou wrote:
> > During probe, pcf85363_load_capacitance() writes the oscillator load
> > capacitance configuration to the device. However, if the device is
> > not physically present on the bus (returning -ENXIO), the driver
> > only emits a warning and continues to execute the probe.
> >
> > This results in the successful registration of a phantom RTC device
> > via devm_rtc_register_device() and its associated nvmem regions.
> > Consequently, userspace may attempt to bind to a non-functional
> > /dev/rtc node.
> >
> > Propagate the I2C error back to the driver core using dev_err_probe()
> > to properly abort the probe and prevent phantom device registration.
> >
>
> No, there is no point in this, simply remove the RTC node from you
> device tree.
>

Hi Alexandre,

You are right, fixing the DT is the correct solution for missing
hardware. My commit message was misleading.

However, the current code ignores actual I2C transport errors (e.g.,
-ENXIO due to physical bus issues) from pcf85363_load_capacitance()
and continues probing.

Should I send a v2 with an updated commit message focusing solely on
properly handling these transport errors?

Thanks,
Cosmo

> > Fixes: fd9a6a13949a ("rtc: pcf85363: add support for the quartz-load-fe=
mtofarads property")
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> >  drivers/rtc/rtc-pcf85363.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> > index 540042b9eec8..5612330aff40 100644
> > --- a/drivers/rtc/rtc-pcf85363.c
> > +++ b/drivers/rtc/rtc-pcf85363.c
> > @@ -426,8 +426,8 @@ static int pcf85363_probe(struct i2c_client *client=
)
> >
> >       err =3D pcf85363_load_capacitance(pcf85363, client->dev.of_node);
> >       if (err < 0)
> > -             dev_warn(&client->dev, "failed to set xtal load capacitan=
ce: %d",
> > -                      err);
> > +             return dev_err_probe(&client->dev, err,
> > +                                  "failed to set xtal load capacitance=
\n");
> >
> >       pcf85363->rtc->ops =3D &rtc_ops;
> >       pcf85363->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > --
> > 2.43.0
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
