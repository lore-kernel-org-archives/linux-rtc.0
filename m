Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E7476683
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827749; cv=none; b=ERcyh5i3gOGWC44iKyNJ+/6cHL+hJY0dI+6z1Fuv0+CjP4p1+QXq1DYP64YSOZLTqIRGFurx0YeqT19VLpwAZ5cxD8Iwhgcmi4hUx+n6ts8B44Obp51yCyk/T83fjee8B2hfCmL1KfTlR4TlqG12F/6ZLaULgZZBNzDBTl6cbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827749; c=relaxed/simple;
	bh=vykYW/pa+zA1M+X1pOWDQ3yvz9xPp8ytoB0pE8d6eH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtM+d5nCeWAn7QPprrxrF1IVPUeN8CbdZam0Irrc9/k5BJz7EOtcJjf8OGfdtJ+9hijf0EY/GFApK4aTiMoQeLPstM0AQ2uKxVcIcINuJrkaYnVG3OKKfgH/x7BrR7HWVPklEdR3fi+1UTlJ1J/QJjkVLADw0hfWT1iVukbgqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQE/LmDH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQE/LmDH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so8518125e9.0
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827746; x=1785432546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mESjB4FTq5J5yd8bHp4vOsYEbA8V78o1e2ORDrvPZPE=;
        b=gQE/LmDHmrJ5QXqNU7fC8TpMC1XAfxoT7GsSinZffG+FGDFvcMrgCOCrF7iKfz/AoN
         RoR722R2FRhG8JrdflAJN36+yqRGEyR8OpeElqSRo/PF1nDeUJD60YnQUdd8UQMcLOor
         1Hvfix684ppJEbi91x9dfCmRQRYZoChx7/AApz59F9VeLtcwlLArzObMHBq6DVyAWc9M
         IdUTANnM4dZAw+Hf77bjv/cfqinPfjj6AqyiElCDCExMx5/HtOcbKfq7YZ5mVNDhI0bn
         zKT5gD8bXgrTKk6doXFegkGyGY/SCZMxnxoa1sa37etUhkWBbbpDEbARwgTwsN83MTik
         ciLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827746; x=1785432546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mESjB4FTq5J5yd8bHp4vOsYEbA8V78o1e2ORDrvPZPE=;
        b=i+GX80KougRoq1WkrfnhMMuJQEcgzLRQY+TMVD4nX31dCQN6CIT1pv0A2f4siFOvt4
         MDIqVbKtWHqiJKdW5rf8fyBvfGEkzYXYaljufynWNAVlDzyUk5oekcJBkl5UPJsS9Xfl
         pcMR0yFhv53FFQPXMJ5qAjrTRPs6G4FC099QiLgo6oglwLQAPDhWRhBD6kwD6yd/JemA
         +PX9gJOOfaveo25WY7B1ffvTAaWWYD63hz3weY3Kl+NQnk7mfd/geHC64jPfxg8HBtL4
         M0VdJwXRIOzOrBuD90L8yB9RxzY37i5gL2xYvJXbqX3GlH9YpOznPSEeA3tFX9FqasZn
         KckA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5OUROvGfKvEkLybvCAatZDMU+oXAWovfXjcpmEnqIGYWB6K4EYiAmSaoeU7uWmenWGM/hCqIbiJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclBy9/AMgE8v0VqtP2A7y4zJnLA1v/iu8bM83rakntNHOq0ky
	PNDJeyp8SO9o63gKZrEFt/mKWFhzp7CH2WKktc1F+6QhNUHf7vLAfP8K
X-Gm-Gg: AR+sD12igMUIe8s2ReVhSoXlwO5k6zcQFF6PyQvGI4LnZmkpLy6OUvKzwFmCmXQfYb1
	GFeKLaf+TYP4YrYzX1+Ov+ihZ3dVuMBjLBx14UkhmXIwyn2gui65GxG9tIK+ZvXZdKnsDFd/xSl
	exU98zD6LsPbucayjNAFQncqM11OQjRZm/juIkERYWR2wMshfAbsTK/E+iQevwkp6LGSUL1uNXx
	1jrAvRGDlKyj0qc2tBuuR/1QW56hkk9p4YHK2Tz7vQG8pYngsd0y57N9Cl7+2/EJZgB5owDwPHm
	U63kI+WNSpM+KYDNsKgaqK0k04hOSSCw81i4R6GCcEjHpoCKRdAybxIf/2YOMgOyeKefmfRWyZZ
	+6HUojbF7e1pOMBL0mWSrW1zdgBXOwzyw3z5qd3SVayR2FL9aFRnj5CH7izNAzKzoBPPsYR5K0t
	P9iX1I
X-Received: by 2002:a05:600c:8289:b0:495:3af9:4cfe with SMTP id 5b1f17b1804b1-49573cf6d89mr48349715e9.20.1784827745515;
        Thu, 23 Jul 2026 10:29:05 -0700 (PDT)
Received: from antoniarch ([78.212.250.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm17995418f8f.37.2026.07.23.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:29:05 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:27:33 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Message-ID: <amJOp_1SFDdDfN-b@antoniarch>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-2-apokusinski01@gmail.com>
 <20260722200945.CA8891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722200945.CA8891F000E9@smtp.kernel.org>

On Wed, Jul 22, 2026 at 08:09:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The newly added SPI compatible strings `abracon,ab0815` and `abracon,ab1815` were omitted from the `if-then` conditional block that restricts trickle charger properties.
> - [Low] The schema explicitly introduces SPI support but fails to reference the standard SPI peripheral properties schema, causing common SPI properties to be rejected.
> --
> 
> --- Patch [1]: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs ---
> commit 74ad54b7ffcb981494fb52031a1edb5415b809ae
> Author: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> dt-bindings: rtc: abx80x: document ABX81X RTCs
> 
> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
> 
> > diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > index 355b0598411a6..234a103724b56 100644
> > --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> [ ... ]
> > @@ -21,10 +21,12 @@ properties:
> >        - abracon,ab0803
> >        - abracon,ab0804
> >        - abracon,ab0805
> > +      - abracon,ab0815
> >        - abracon,ab1801
> >        - abracon,ab1803
> >        - abracon,ab1804
> >        - abracon,ab1805
> > +      - abracon,ab1815
> >        - microcrystal,rv1805
> 
> [Severity: Low]
> Will the schema validator reject standard trickle charger properties for the
> newly added AB0815 and AB1815 compatible strings?
> 
> Looking at the conditional block later in the file:
> 
> allOf:
>   - $ref: rtc.yaml#
>   - if:
>       properties:
>         compatible:
>           not:
>             contains:
>               enum:
>                 - abracon,abx80x
>                 - abracon,ab0804
>                 - abracon,ab1804
>                 - abracon,ab0805
>                 - abracon,ab1805
> 
> Because abracon,ab0815 and abracon,ab1815 were omitted from this enum list,
> abracon,tc-diode and abracon,tc-resistor will evaluate to false for these
> variants. Should they be added to the list?
> 
> [ ... ]
Yes, the new compatible strings are missing here, will add them in v2.

