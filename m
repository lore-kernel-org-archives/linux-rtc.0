Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555367;
	b=0NxyyxMx7E8p5msZn4Uq2u77T31fyWRQEQ4cjj7NL6Vi9RFJpCu6De2Q4YJFyc81RLY7
	 e//NRBu43ESEnMi9cIr9qdADNlCQZZxN9CPOzwdeUT8hiBppalk1c68orhMqeH/fMD57m
	 FVIV+mIgn71pw2UMuatNIgxA28Dht6knIwiMz0SJE8UJ8jyR9Dt3Cpc8pQHHUZ99jIjdh
	 a4pKxAh70cKfck3vhvmIFGBWDTHwP3cbf8ijkHlHyKQIgoLxwbc2yEoRsbB48fBdlT32X
	 kJKV78xya9rVajnvqciGWxXDqF1knneqC2uY6SVh3xlR7bGJFHmOkG3RuD9KgE8pAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555367;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=p3p1ImInZyOAgLYhOXYS79QUWFUn7k/0GTAJo+Jk4ME=;
	b=1uy52WBwoVfYF9BqGKDhgjudXu8ut6tYlZNTgHJBGCiQRM5LZVRB7CW/DhL4fITujTz8
	 JAyRyhyVb6U4EgZj6VcVYwh/nAohAXnVIB/1Y5ZtvWwHTklnEfoUs0rDEs1Fsv6rfcmvz
	 ozHkVy3mmijDDzSs4NLKq7LUwl1bduXQ5ylGOEWrIuvdYEmhNLrKMyc3+LjbtDeFCW8g8
	 /4Tbs97/C464MycPEWlLsjlMpCjOrfuCEJiPlp8mYLzSOe0cT/qZr1FiiUS32TZJ0yngB
	 eugK1vWqRg1V0AAc6AG7mjjS285bbpkBUldV6M4DBMEeWj3rlgPb0mjRCJ2AgKYFo8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="P/y05MVy";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F905606A323;
	Fri, 13 Nov 2026 07:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F905606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=P/y05MVy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9C3481A162E;
	Fri, 13 Nov 2026 07:36:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5919B601D5;
	Fri, 13 Nov 2026 07:36:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 335D911BC0C91;
	Fri, 13 Nov 2026 08:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794555362; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=p3p1ImInZyOAgLYhOXYS79QUWFUn7k/0GTAJo+Jk4ME=;
	b=P/y05MVysnOwomEB1s6hACIPho+j457rQ2Mxxw12gLloSPACX19pFPweWYaVPbPiHbHl/5
	51I+5svqPXRVWZePUJre/Fr5+0dyXO0cH4fgkFaKG4Hmk9VIc/C3gw+TOzizO7FS594e8Z
	HfWPLNXzFz9X4ROFd8VRj/G4ghmV8lRGOcq575bae8Ya3GLziwRplzm+xC2A/mWIStcWm7
	i9QJDoiVkeI3n3vmkjPlNGNaQ+jqBatjvixwTguzr9SHWiNJWG01CWxAZeETry8QYoSn5I
	n6m4PUz2brdL+/CODsQyA65erQXIZN/zRTx19boBppI+VhUM2Qt2UwsdfNP0VQ==
Date: Fri, 13 Nov 2026 08:35:57 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Akhilesh Patil <akhilesh.patil@linux.dev>, andy@kernel.org,
	krzk+dt@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	crofts@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <202611130735579e063959@mail.local>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
 <20261113011957.5d8836ff@jic23-hlaptop>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113011957.5d8836ff@jic23-hlaptop>
X-Last-TLS-Session-Version: TLSv1.3

Hi,


On 13/11/2026 01:19:57+0000, Jonathan Cameron wrote:
> On Thu, 12 Nov 2026 09:16:41 +0000
> Akhilesh Patil <akhilesh.patil@linux.dev> wrote:
> 
> > Move to my new linux.dev email address akhilesh.patil@linux.dev
> > I plan to use this email for kernel development going forward.
> > Also update email address in few yaml and driver source files.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> 
> I can pick this one up with an rtc ack, or it can go through that
> tree. I don't mind which.
> 

It makes more sense that you take it.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > 
> > Changes in v4: 
> > - No source change.
> > - Added entire change log for all versions.
> > - Link to v3: 
> > https://lore.kernel.org/linux-iio/20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com/
> > 
> > Changes in v3: 
> > - Fixed order of entry in .mailmap
> > - Link to v2: 
> > https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 
> > 
> > Changes in v2:
> > - Updated email ID in relevant device tree source files and driver source files.
> > - Link to v1: 
> > https://lore.kernel.org/linux-iio/20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com/
> > 
> >  .mailmap                                                      | 1 +
> >  .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
> >  Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
> >  MAINTAINERS                                                   | 2 +-
> >  drivers/iio/pressure/adp810.c                                 | 4 ++--
> >  5 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index 7fb33babc931..d09fd3708023 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -27,6 +27,7 @@ Adrian Bunk <bunk@stusta.de>
> >  Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
> >  Akhil P Oommen <akhilpo@oss.qualcomm.com> <akhilpo@codeaurora.org>
> >  Akhil P Oommen <akhilpo@oss.qualcomm.com> <quic_akhilpo@quicinc.com>
> > +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
> >  Alan Cox <alan@lxorguk.ukuu.org.uk>
> >  Alan Cox <root@hraefn.swansea.linux.org.uk>
> >  Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > index ad5f26ce5043..ca4d4210f609 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: aosong adp810 differential pressure sensor
> >  
> >  maintainers:
> > -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +  - Akhilesh Patil <akhilesh.patil@linux.dev>
> >  
> >  description:
> >    ADP810 is differential pressure and temperature sensor. It has I2C bus
> > diff --git a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > index bdd995c5c1f4..837679dc01ac 100644
> > --- a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: ST M41T93 RTC and compatible
> >  
> >  maintainers:
> > -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +  - Akhilesh Patil <akhilesh.patil@linux.dev>
> >  
> >  description:
> >    ST M41T93 is spi based Real Time Clock (RTC) with time, date,
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 222b7fc2c3aa..3aa8fa3c068f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> >  F:	drivers/iio/chemical/ags02ma.c
> >  
> >  AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> > -M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +M:	Akhilesh Patil <akhilesh.patil@linux.dev>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> > index 82aa433548d2..832df6ba0ee3 100644
> > --- a/drivers/iio/pressure/adp810.c
> > +++ b/drivers/iio/pressure/adp810.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > + * Copyright (c) 2025 Akhilesh Patil <akhilesh.patil@linux.dev>
> >   *
> >   * Driver for adp810 pressure and temperature sensor
> >   * Datasheet:
> > @@ -219,6 +219,6 @@ static struct i2c_driver adp810_driver = {
> >  };
> >  module_i2c_driver(adp810_driver);
> >  
> > -MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
> > +MODULE_AUTHOR("Akhilesh Patil <akhilesh.patil@linux.dev>");
> >  MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
> >  MODULE_LICENSE("GPL");
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
