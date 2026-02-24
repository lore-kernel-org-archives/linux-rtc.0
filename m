Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884D3A4F55
	for <linux-rtc@vger.kernel.org>; Tue, 24 Feb 2026 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954111; cv=none; b=BauLyoZXyW6gFwCOKuuNmhs7tXbj/sqsqBxiMpoUY+NsFFQLXPmJ+6MK2Cw9Spud/q3m+DwQPtCxCDFbGT3q6D6NedfCGL7HfAVhFaGyfltNtqW1/F4zl1DDSfqtY/DLtaCjK8GLece89KavOjBqjTZXz3qvah4LdGCLJMe34gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954111; c=relaxed/simple;
	bh=bkyp0dc5ZhsH3u0YTsXjE3Qd7aPaXk/E9bI5N1L1cBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGBkSALIQlYkubBPwdFYTGlvJPEcuSmWnoolXUGKDYXHVklyZ8TQPeHUNYgWnfCFFYF7sICJA+oc2NnsvgJkvwYrKgi3Q6mvJPLb993+ZngSNySlGEeMvVe4vq7lk/ZcAAvTZtjfqWfNqNzOG02+pnkFfhEkyyJ1Lvw2X8luYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CVctbAeT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CVctbAeT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 96D1E1A120B;
	Tue, 24 Feb 2026 17:28:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 643DF5FD9D;
	Tue, 24 Feb 2026 17:28:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FE621036805A;
	Tue, 24 Feb 2026 18:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771954106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sJQsE+j4+KEkNPJOCXmvFxAPMzMhKJoCQMrcCdMWvFc=;
	b=CVctbAeT5y94dXxEog34KYi7+HeOOD73JX2p/CMmVeUbqciFMcTnAtmlwNcyaHeVxzZHA/
	k2I1oLuflzrlKN3ua1mL3a9l2ethRp6CNXxMGaw9O8JWHpX0rQH+dhpLD7/JdNSDzNsjq3
	ze3yxXTOa2othA0ubvINihMKLYR2isrLshwl/T/nXt3Vptpd/awocZirUDN2taC1ETDBM5
	Ypze+6QAUwz56Nq4lD4yyTQdtMCOD1afB2NAo1eIOaDCl1lUbjiD+4hJp3rqBiuyXfMaNf
	WAL/9OVLPl0I3N1FDk2yWgkcnhoBWgM+8a4MCtMnenxUHKi6r26Z8iW+LCa2pA==
Date: Tue, 24 Feb 2026 18:28:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-rtc@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v3 1/5] rtc: add device selector for rtc_class_ops
 callbacks
Message-ID: <20260224172822de7f4569@mail.local>
References: <20260221111619162a41a1@mail.local>
 <CAJZ5v0jo2sLKWVOBJz7QP9x_aMZbaVx+ES7QwYWkTzHp7d2xLQ@mail.gmail.com>
 <DGKPPQI0QE73.S8I1M5NCI2BV@kernel.org>
 <20260222000556ea1938c0@mail.local>
 <DGLI4H9M0T6D.25RTLDVU5JRBE@kernel.org>
 <CAJZ5v0gtiQxBCknkaOzLKrDqUQfhKh_UjQkvgxJBL4UthbCOkg@mail.gmail.com>
 <DGLMGEZTM7E2.Y8VV9I6LI1P6@kernel.org>
 <DGMR9XOWP1V0.3C9219TYPXV6J@kernel.org>
 <2026022415010804e28202@mail.local>
 <DGNC6GEH8EV7.2WWAQ8DNCLRAB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGNC6GEH8EV7.2WWAQ8DNCLRAB@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 24/02/2026 17:35:23+0100, Danilo Krummrich wrote:
> On Tue Feb 24, 2026 at 4:01 PM CET, Alexandre Belloni wrote:
> > On 24/02/2026 01:12:32+0100, Danilo Krummrich wrote:
> >> 	impl pci::Driver for SampleDriver {
> >> 	    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
> >> 	        let dev = pdev.as_ref();
> >> 
> >> 	        let rtc_data = impl_pin_init!(SampleRtcData {
> >> 	            io: iomap_region_sized::<BAR0_SIZE>(0, c"my_rtc/bar0")?,
> >> 	            hw_variant: VendorVariant::StV1,
> >> 	        });
> >> 
> >> 	        let rtc = rtc::Device::new(dev, rtc_data)?;
> >> 
> >> 	        // Internally calls `devres::register(rtc::Registration::new())`.
> >> 	        rtc::Registration::register(rtc)?;
> >> 
> >> 	        Ok(impl_pin_init!(Self {
> >> 	            // Give the IRQ handler a reference count of the `rtc::Device`.
> >> 	            irq <- irq::Registration::new(..., rtc.clone()),
> >> 	            rtc,
> >> 	        })
> >
> > I can't really read rust yet but this seems to open a race condition
> > with userspace if irq::Registration::new(...) fails, there is an
> > ordering constraint you missed.
> 
> (I did not have any specific hardware in mind when sketching this up (e.g. an
> IRQ could also only be needed in bus device callbacks, e.g. for loading firmware
> etc.). But for RTC it obviously is common that it is relevant to the class
> device too.)
> 
> So, I assume you mean because there could already be an ioctl before the IRQ has
> been successfully registered, and this ioctl may wait for an IRQ?
> 
> In this case the irq::Registration should go into rtc_data instead to account
> for this dependency. Unfortunately, this is a semantic dependency that we can't
> always catch at compile time.
> 
> The reason we sometimes can is because, if you would need access to the
> irq::Registration from ioctls (e.g. for calling synchronize(), enable(),
> disable() etc.) it would be caught, because you couldn't access it without it
> being in rtc_data in the first place, and being forced to have it in rtc_data
> guarantees that the ordering can't be wrong.

No, once you register the rtc, the character device will appear in
userspace and may be opened, at this point, probe is not allowed to fail
anymore which you are allowing by trying to register the IRQ so late.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
