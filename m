Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAB39281E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Feb 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026431; cv=none; b=kBjqXIw5FRNyCCAv6trl9Fdo5XzcG8t567jHr+MwCMQxwnCo2jEJVpMuIGM5PbNIhkOo970kXhuALDPjmMp15k1M1wjkiAmrokM4yx++OkzQ1F8j3rBZ3T+1YI3yHTQkVqMWnQdAcGb+h8wu0PprbRPVtSnUnItFvFOZgdsAJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026431; c=relaxed/simple;
	bh=fxRVFKCwX8I+j+b3TCx6cy0PI0PLWyaChhkog07Gd7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XarHDCHWAlARy5pMjPBNEKoPpZ9rMeIdjmkuzFc00vM4cPjgN31C4Ysb/qmRW+gmS7glq67iC8HzeZ7cXB4Ye72c7g0Sqh5jx8/MbevH8ZaIxOAy21eb586WEPv0MJW7nejQ2d5dVv7oGdqmZdqT+nwgjf1rfce54XM2+gk1mcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIn/x4xi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIn/x4xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889DC2BC9E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Feb 2026 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772026430;
	bh=fxRVFKCwX8I+j+b3TCx6cy0PI0PLWyaChhkog07Gd7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cIn/x4xiPwsCX6h9l6rMe60v0cRheHyaHVNtpjh9gSKRFlSnXsEE09TUAkrLT/4BZ
	 opzwGZxCka3WPg5CVK/oGY6mCWbAUa16Xt4afQEE66NG4S5Y0KT5wLgjaRmjdAxpZS
	 xy+tIyyReyjatmo8IbwIMnf6MibqipGH48WNn6+B0W5BK1qP570S7TVTRXdDQBdwLJ
	 mwwRyH+2m2RXYo52+G4eDhapfF0df7kAbuINryUBa3gKhf8aXwxMSxqZBVv56qE0pC
	 gMPRkIpfFDfsv2Gad8lW63bYhF1rJBG6u65RRZblIwcO90inzqExAMKS7CGuxwvj91
	 zvyR3hlz4l2mQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be94eeacso2024692a34.2
        for <linux-rtc@vger.kernel.org>; Wed, 25 Feb 2026 05:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvEZOCNZParlpmYnLkzVkzOXSJXrXwb/3Rz+jcI+ciy5D1pyS5p8yvLtOJDPfjcI1Qmh4vJNrXUNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zdJ/2M3N12huMxOy/LhQnWKz3gwX95zgGWnW5v+Irp3XVvKj
	ZxwJ1G6n8L1oypZWef2B/DZnmYzkpaEP+WLpun2XR4HHb8DmXTkJlLWGD1ueKEq+ELKVDmmlBZ1
	inigpmFpRoW1CgOBZMDVfteqn8ugUoSo=
X-Received: by 2002:a05:6820:1513:b0:676:9ba8:e479 with SMTP id
 006d021491bc7-679c44ebc6dmr8126202eaf.43.1772026429804; Wed, 25 Feb 2026
 05:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221111619162a41a1@mail.local> <CAJZ5v0jo2sLKWVOBJz7QP9x_aMZbaVx+ES7QwYWkTzHp7d2xLQ@mail.gmail.com>
 <DGKPPQI0QE73.S8I1M5NCI2BV@kernel.org> <20260222000556ea1938c0@mail.local>
 <DGLI4H9M0T6D.25RTLDVU5JRBE@kernel.org> <CAJZ5v0gtiQxBCknkaOzLKrDqUQfhKh_UjQkvgxJBL4UthbCOkg@mail.gmail.com>
 <DGLMGEZTM7E2.Y8VV9I6LI1P6@kernel.org> <DGMR9XOWP1V0.3C9219TYPXV6J@kernel.org>
 <2026022415010804e28202@mail.local> <DGNC6GEH8EV7.2WWAQ8DNCLRAB@kernel.org>
 <20260224172822de7f4569@mail.local> <DGNJKZA00MNT.2C7NAQYG597MO@kernel.org>
In-Reply-To: <DGNJKZA00MNT.2C7NAQYG597MO@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 14:33:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iA88G0ZRVB347dXEu2y8mT=d+aWd42cB2tpO5pLVpKuQ@mail.gmail.com>
X-Gm-Features: AaiRm50DZMILBW-wLKDoD58lo9J1yR9vKtsMMhsnWbbjvffTLfzdQ6k9D1NO_Sc
Message-ID: <CAJZ5v0iA88G0ZRVB347dXEu2y8mT=d+aWd42cB2tpO5pLVpKuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] rtc: add device selector for rtc_class_ops callbacks
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-rtc@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 11:23=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Tue Feb 24, 2026 at 6:28 PM CET, Alexandre Belloni wrote:
> > On 24/02/2026 17:35:23+0100, Danilo Krummrich wrote:
> >> (I did not have any specific hardware in mind when sketching this up (=
e.g. an
> >> IRQ could also only be needed in bus device callbacks, e.g. for loadin=
g firmware
> >> etc.). But for RTC it obviously is common that it is relevant to the c=
lass
> >> device too.)
> >>
> >> So, I assume you mean because there could already be an ioctl before t=
he IRQ has
> >> been successfully registered, and this ioctl may wait for an IRQ?
> >>
> >> In this case the irq::Registration should go into rtc_data instead to =
account
> >> for this dependency. Unfortunately, this is a semantic dependency that=
 we can't
> >> always catch at compile time.
> >>
> >> The reason we sometimes can is because, if you would need access to th=
e
> >> irq::Registration from ioctls (e.g. for calling synchronize(), enable(=
),
> >> disable() etc.) it would be caught, because you couldn't access it wit=
hout it
> >> being in rtc_data in the first place, and being forced to have it in r=
tc_data
> >> guarantees that the ordering can't be wrong.
> >
> > No, once you register the rtc, the character device will appear in
> > userspace and may be opened, at this point, probe is not allowed to fai=
l
> > anymore which you are allowing by trying to register the IRQ so late.
>
> This does not seem to correspond to my previous reply -- may I kindly ask=
 you to
> read it again?
>
> Here's also some sketched up code for what I wrote above:
>
>         fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl P=
inInit<Self, Error> {
>             let dev =3D pdev.as_ref();
>
>             let rtc_data =3D impl_pin_init!(SampleRtcData {
>                 io: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"my_rtc/bar0=
")?,
>                 hw_variant: VendorVariant::StV1,
>                 irq <- irq::Registration::new(...),
>             });
>
>             let rtc =3D rtc::Device::new(dev, rtc_data)?;
>
>             rtc::Registration::register(rtc)?;
>
>             Ok(Self { rtc })
>         }
>
> Note that if any of the RTC callbacks would ever need to call irq.synchro=
nize(),
> irq.disable(), etc. the compiler would enforce correct ordering, as there=
 would
> not be any other possibility to put the irq::Registration other than into=
 the
> rtc_data that goes into rtc::Device::new().

IIUC, the interrupt handler can only access the rtc_data because the
parent's driver_data may not exist yet when it runs.  Or am I missing
something?
